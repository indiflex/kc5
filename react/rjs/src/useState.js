let currentlyRenderingFiber = null;
let workInProgressHook = null;
let currentFiber = null;
let currentHook = null;

const useStateForMount = initialState => {
  const hook = { memoizedState: null, queue: null, next: null };
  if (workInProgressHook === null) {
    currentlyRenderingFiber.memoizedState = hook;
  } else {
    workInProgressHook.next = hook;
  }

  workInProgressHook = hook;

  const memoizedState =
    typeof initialState === 'function' ? initialState() : initialState;

  const queue = {
    pending: null,
    dispatch: null,
    lastRenderedState: memoizedState,
    lastRenderedReducer: basicStateReducer,
  };

  hook.memoizedState = memoizedState;
  hook.queue = queue;

  queue.dispatch = ((fiber, queue, action) => {
    const update = {
      action,
      lane: requestUpdateLane(),
      next: null,
    };

    if (queue.pending === null) {
      update.next = update;
    } else {
      update.next = queue.pending.next;
      queue.pending.next = update;
    }
    queue.pending = update;

    scheduleUpdateOnFiber(fiber);
  }).bind(null, currentlyRenderingFiber, queue);

  return [memoizedState, queue.dispatch];
};

const useStateForUpdate = () => {
  const nextCurrentHook =
    currentHook === null ? currentFiber.memoizedState : currentHook.next;
  currentHook = nextCurrentHook;

  const hook = { ...currentHook };

  if (workInProgressHook === null) {
    currentlyRenderingFiber.memoizedState = hook;
  } else {
    workInProgressHook.next = hook;
  }

  workInProgressHook = hook;

  const queue = hook.queue;
  let newState = hook.memoizedState;

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
};
