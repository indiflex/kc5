// function once(...args) {}
function once() {
  const fn = arguments[0];
  let state = false;

  return function (...args) {
    if (!state) {
      state = true;
      return fn(...args);
    }
    return;
  };
}

const sum = (...nums) => nums.reduce((acc, n) => acc + n);

function onceAgain(f, rebirthDelay = 1000) {
  let state = false;
  let interval = null;

  const start = (...args) => {
    // setInterval 시작
    interval = setInterval(() => {
      console.log(f(...args));
    }, 100);

    // rebirthDelay 후에 중지
    setTimeout(() => {
      clearInterval(interval);
      console.log('중지됨!');
    }, rebirthDelay);
    // const intl = setInterval(() => {
    //   clearInterval(intl);
    // }, interval);
  };

  return start;
}

const fn = once((x, y) => `금일 운행금지 차량은 끝번호 ${x}, ${y}입니다!`);
console.log(fn(1, 6)); // 금일 운행금지 차량은 끝번호 1, 6입니다!
console.log(fn(2, 7)); // undefined
const fn2 = onceAgain((x, y) => `차량번호: ${x}, ${y}`, 1000);
fn2(3, 8);
//---------------------
