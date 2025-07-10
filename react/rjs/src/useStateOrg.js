// ✅ useState 내부 작동 방식 (React 핵심 흐름 정리)

type Hook = {
  memoizedState: any, // 현재 상태값 (ex. useState의 값)
  baseState?: any, // base 상태 (useReducer에서 사용)
  queue: UpdateQueue | null, // setState 큐
  next: Hook | null, // 다음 훅 (Linked List 구조)
};

type UpdateQueue = {
  pending: Update | null, // 원형 연결 리스트의 마지막 노드
  dispatch: (action: any) => void, // setState 함수
  lastRenderedReducer?: Function, // useReducer 전용
  lastRenderedState?: any, // 마지막 상태 캐시
};

// 1. public API
function useState(initialState) {
  const dispatcher = resolveDispatcher();
  return dispatcher.useState(initialState);
}

// 2. dispatcher getter
// 최초 랜더링 단계면 HooksDispatcherOnMount
// 리렌더링 단계면 HooksDispatcherOnUpdate으로 설정(React가)
const ReactCurrentDispatcher = { current: null };

// 랜더링 단계에 따라서 다른 dispathcer 반환(Mount or Update)
function resolveDispatcher() {
  const dispatcher = ReactCurrentDispatcher.current;
  if (!dispatcher) throw new Error('Invalid hook call');
  return dispatcher;
}

// 3. dispatcher 종류 (렌더 시점에 따라)
const HooksDispatcherOnMount = { useState: mountState };
const HooksDispatcherOnUpdate = { useState: updateState };

// Hook 연결 상태 추적용 전역
// 현재 rendering 중인 fiber
let currentlyRenderingFiber = null;
let workInProgressHook = null;

// 이전 redered된 fiber(현재 DOM에 반영된 Fiber)
let currentFiber = null;
// pointer 역할
let currentHook = null;

// 4. mountState: 최초 렌더에서 useState 동작
function mountState(initialState) {
  // Hook 생성 workInProgressHook가 없으면 currentlyRenderingFiber의 next로 hook 등록
  // workInProgressHook가 있으면 workInProgressHook의 next로 hook 등록
  const hook = mountWorkInProgressHook();

  // 함수면 실행해서 저장
  const memoizedState =
    typeof initialState === 'function' ? initialState() : initialState;

  // queue 객체 만들기
  const queue = {
    pending: null,
    dispatch: null,
    lastRenderedState: memoizedState,
    lastRenderedReducer: basicStateReducer,
  };

  hook.memoizedState = memoizedState;
  hook.queue = queue;

  // dispatch(setState)는 즉시 state를 변경하지 않는다.
  // queue에 update를 저장해뒀다가 rerender되는 시점(useState를 호출(updateState)하는 시점에 업데이트됨)
  const dispatch = (queue.dispatch = dispatchAction.bind(
    null,
    currentlyRenderingFiber,
    queue
  ));
  return [memoizedState, dispatch];
}

// 5. updateState: 리렌더에서 useState 동작
function updateState(initialState) {
  // 최초 실행시 이번 시점의 fiber에 hook을 추가
  // 그다음 번은 workinprocesshook의 next에 hook을 추가(현재 DOM의 Hook들을 순서대로 받아옴)
  const hook = updateWorkInProgressHook();
  const queue = hook.queue;
  let newState = hook.memoizedState;

  // 이전 시점에서 이 hook에 대한 update가 존재하면 update 실행
  const pendingQueue = queue.pending;
  if (pendingQueue !== null) {
    queue.pending = null;
    let first = pendingQueue.next;
    let update = first;
    do {
      newState = queue.lastRenderedReducer(newState, update.action);
      update = update.next;
    } while (update !== first);
  }

  hook.memoizedState = newState;
  queue.lastRenderedState = newState;
  return [newState, queue.dispatch];
}

// 6. Hook 생성 (mount)
function mountWorkInProgressHook() {
  const hook = { memoizedState: null, queue: null, next: null };
  if (workInProgressHook === null) {
    currentlyRenderingFiber.memoizedState = hook;
  } else {
    workInProgressHook.next = hook;
  }
  workInProgressHook = hook;
  return hook;
}

// 7. Hook 재사용 (update)
function updateWorkInProgressHook() {
  // 현재 DOM의 fiber의 hook들을 순서대로 받아오기
  let nextCurrentHook =
    currentHook === null ? currentFiber.memoizedState : currentHook.next;

  currentHook = nextCurrentHook;

  // React는 불변성(immutability) 을 지키기 위해,
  // 렌더링할 때마다 Hook 객체를 새로 복사해서 만들고,
  // 그것들을 새롭게 연결된 Hook 리스트(work-in-progress) 로 구성함.
  const hook = {
    memoizedState: currentHook.memoizedState,
    queue: currentHook.queue,
    next: null,
  };

  // Rendering할 Fiber에 복사한 Hook을 추가해주기
  if (workInProgressHook === null) {
    currentlyRenderingFiber.memoizedState = hook;
  } else {
    workInProgressHook.next = hook;
  }

  workInProgressHook = hook;
  return hook;
}

// 8. 상태 변경 요청 처리
function dispatchAction(fiber, queue, action) {
  // setSate로 인한 새로운 업데이트 변수
  const update = {
    action,
    lane: requestUpdateLane(),
    next: null,
  };

  // 원형 연결 리스트 삽입
  if (queue.pending === null) {
    // circular linked list라서
    // Why Circular Linked List? :: 마지막에 삽입 시에 O(1)으로 유리 (Linked List는 O(N))
    update.next = update;
  } else {
    // 새로운 업데이트의 next를 원래 마지막의 next로
    update.next = queue.pending.next;
    // 원래 마지막의 next를 update로
    queue.pending.next = update;
  }
  // 마지막 위치 지정
  queue.pending = update;

  scheduleUpdateOnFiber(fiber);
}

// 9. 상태 계산 reducer (useState 기본값)
function basicStateReducer(prev, action) {
  return typeof action === 'function' ? action(prev) : action;
}

// 10. 렌더 스케줄링 관련 (단순화)
function requestUpdateLane() {
  return 1; // 간단한 우선순위 예시
}
function scheduleUpdateOnFiber(fiber) {
  // 실제 React는 여기서 ReactDOM 렌더 예약을 함
  console.log('Schedule update on fiber', fiber);
}
