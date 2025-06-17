const assert = require('assert');
const { receiveMessageOnPort } = require('worker_threads');

const arr = [1, 2, 3, true];
const ret1 = arr.map(String);
assert.deepStrictEqual(ret1, ['1', '2', '3', 'true']);
/* ex2) 다음과 같이 작동하는 classNames 함수를 작성하시오. */
const classNames = (...args) => args.filter(a => !!a.trim()).join(' ');
const ret2 = classNames('', 'a b c', 'd', ' ', 'e');
assert.strictEqual(ret2, 'a b c d e');

// ---------------------------
const reduce = (arr, fn, initValue) => {
  let i = 0;
  let acc = initValue ?? (i++, arr[0]);
  for (; i < arr.length; i++) acc = fn(acc, arr[i]);

  return acc;
};

// for (; ;) {
//   if (xxx) break;
// }
// while (true) {
//   sleep(1)
// }

// const ax = [1, 2, 3];
// const cbf = (acc, a) => {
//   setTimeout(() => acc + a, 100);
// };
// const x1 = ax.reduce(cbf);
// console.log('🚀 x1:', x1);

const kim = { id: 2, name: 'kim' };
const lee = { id: 3, name: 'Lee' };
const park = { id: 4, name: 'Park' };
const users = [kim, lee, park];

const a10 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
assert.deepStrictEqual(
  reduce(a10, (acc, cur) => acc + cur, 0),
  a10.reduce((acc, cur) => acc + cur, 0)
);

assert.deepStrictEqual(
  reduce(users, (acc, user) => acc + user.name),
  users.reduce((acc, user) => acc + user.name)
);

assert.deepStrictEqual(
  reduce(a10, (acc, cur) => acc + cur, 0),
  a10.reduce((acc, cur) => acc + cur, 0)
);
assert.deepStrictEqual(
  reduce(a10, (acc, cur) => acc + cur),
  a10.reduce((acc, cur) => acc + cur)
);
assert.deepStrictEqual(
  reduce([1, 2, 3, 4, 5], (a, b) => a * b, 1),
  [1, 2, 3, 4, 5].reduce((a, b) => a * b, 1)
);

assert.deepStrictEqual(
  reduce(users, (acc, user) => acc + user.name),
  users.reduce((acc, user) => acc + user.name)
);

// -------------------------
const square = n => n ** 2;
const cube = n => n ** 3;
const { sqrt } = Math;
function fnReduce() {
  const arr = [1, 2, 3, 4, 5];
  const result1 = [1, 8, 27, 64, 125];
  const r1 = arr
    .map(a => a ** 2)
    .map(a => Math.sqrt(a))
    .map(a => a ** 3);

  console.log('🚀 r1:', r1);
  assert.deepStrictEqual(r1, result1);
  const fnGrp2 = [square, sqrt, cube];
  const r2 = arr.map(a => fnGrp2.reduce((_acc, fn) => fn(a)));
  assert.deepStrictEqual(r2, result1);
}
fnReduce();

// -------------------------------------
const range = (s, e, step = s > e ? -1 : 1) => {
  const t = s;

  e = e ?? (s > 0 ? ((s = 1), t) : s === 0 ? 0 : -1);

  if ((s - e) * step > 0) return [];
  if (s === e || step === 0) return [s];

  const result = [];
  for (let i = s; s < e ? i <= e : i >= e; i += step) {
    result.push(i);
  }

  return result;
};

assert.deepStrictEqual(range(1, 10, 2), [1, 3, 5, 7, 9]);
assert.deepStrictEqual(range(1, 10, 1), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
assert.deepStrictEqual(range(1, 10), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
assert.deepStrictEqual(range(10, 1), [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]);

assert.deepStrictEqual(range(5, 5, 0), [5]);
assert.deepStrictEqual(range(1, 5, 0), [1]);
assert.deepStrictEqual(range(5, 5, -1), [5]);
assert.deepStrictEqual(range(5, 5), [5]);
assert.deepStrictEqual(range(0, 0, 5), [0]);
assert.deepStrictEqual(range(1, 5, -1), []);

assert.deepStrictEqual(range(1, 5, 6), [1]);
assert.deepStrictEqual(range(0, 5), [0, 1, 2, 3, 4, 5]);
assert.deepStrictEqual(range(-3, 0), [-3, -2, -1, 0]);

assert.deepStrictEqual(range(5, 1, 1), []);
assert.deepStrictEqual(range(0, -1), [0, -1]);
assert.deepStrictEqual(range(0, -3), [0, -1, -2, -3]);
assert.deepStrictEqual(range(5, 1), [5, 4, 3, 2, 1]);
assert.deepStrictEqual(range(10, 1, -2), [10, 8, 6, 4, 2]);

assert.deepStrictEqual(range(5), [1, 2, 3, 4, 5]);

assert.deepStrictEqual(range(0), [0]);
assert.deepStrictEqual(range(0, 0), [0]);
assert.deepStrictEqual(range(1, 1), [1]);
assert.deepStrictEqual(range(2, 1, -5), [2]);
assert.deepStrictEqual(range(0, -1, -5), [0]);
assert.deepStrictEqual(range(-5), [-5, -4, -3, -2, -1]);
assert.deepStrictEqual(
  range(50),
  Array.from({ length: 50 }, (_, i) => i + 1)
);
assert.deepStrictEqual(
  range(1, 150, 3),
  Array.from({ length: 50 }, (_, i) => i * 3 + 1)
);

// -----------------------------------
const keyPair = (arr, n) => {
  const cache = {};

  for (let i = 0; i < arr.length; i++) {
    const val = arr[i];
    if (val in cache) return [cache[val], i];
    cache[n - val] = i;
  }
};
assert.deepStrictEqual(keyPair([1, 3, 4, 5], 7), [1, 2]);
assert.deepStrictEqual(keyPair([1, 4, 45, 6, 10, 8], 16), [3, 4]);
assert.deepStrictEqual(keyPair([1, 2, 4, 3, 6], 10), [2, 4]);
assert.deepStrictEqual(keyPair([1, 2, 3, 4, 5, 7], 9), [3, 4]);

// -------------------------------------
function flattenArray(arr) {
  let result = [];
  arr.forEach(item => {
    if (Array.isArray(item)) {
      result = result.concat(flattenArray(item));
      // result.push(...flattenArray(item));
      // result = [...result, ...flattenArray(item)];
    } else {
      result.push(item);
    }
  });
  return result;
}

console.log(flattenArray([1, [2, [3, [4]]]]));
