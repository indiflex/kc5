//         Run       f
// |--------|--------|--------|--------|--------|
// debounce |----*|----&|----*|--------|
// throttle |-*--*-*-|----*---|--*--*--|

const debounce = (f, delay) => {
  let timer;
  return (...args) => {
    if (timer) clearTimeout(timer);
    timer = setTimeout(() => f(...args), delay);
  };
};

const throttle = (f, delay) => {
  let timer;
  return (...args) => {
    if (timer) return;
    timer = setTimeout(() => {
      f(...args);
      timer = null;
    }, delay);
  };
};

const hong = { id: 1, name: 'Hong' };
const kim = { id: 2, name: 'Kim' };
const lee = { id: 3, name: 'Lee' };
const park = { id: 4, name: 'Park' };
const users = [hong, kim, lee, park];

const find3 = a => a.id === 3;
const idxId2 = users.findIndex(find3);

// Try this: id를 부여해서 실행하는 findId 함수를 작성하시오.
const findId = id => user => user.id === id;
const idxId11 = users.findLastIndex(findId(1));
console.log('🚀  idxId11:', idxId11);
const idxId22 = users.findLastIndex(findId(2));
console.log('🚀  idxId22:', idxId22); // 1
