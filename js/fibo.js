const assert = require('assert');
Array.prototype.mapBy = function (k) {
  return this.map(a => a[k]);
};

Object.defineProperty(Array.prototype, 'firstObject', {
  get(k) {
    return this[0];
  },
});

const users = [
  { id: 1, name: 'Kim' },
  { id: 1, name: 'Hong' },
];
console.log('🚀 users:', users.mapBy('name'));
console.log('🚀 user1:', users.firstObject);

const arr = [1, 2, 3];
const ax = [...arr, 9];
console.log('🚀 ax:', ax);
const ay = [].concat(arr).concat([9]);
console.log('🚀 ay:', ay);
console.log('🚀 arr:', arr);
assert.deepEqual(arr, [1, 2, 3], 'XXX');

value = JSON.rawJSON('1234');
console.log('🚀 value:', value);
value = JSON.rawJSON('"str"');
console.log('🚀 value:', value);

if (JSON.isRawJSON(value)) {
  return console.log(value.rawJSON);
}

return;

function memoized(fn) {
  const memoizedTable = {};
  return k => {
    return memoizedTable[k] || (memoizedTable[k] = fn(k));
  };
}

function fibonacciByLoop(n) {
  let fibonacciArray = [0, 1];

  for (let i = 2; i <= n; i++) {
    fibonacciArray[i] = fibonacciArray[i - 1] + fibonacciArray[i - 2];
  }

  return fibonacciArray[n];
}

function fibonacciByRecursive(n) {
  if (n <= 1) return n;

  return fibonacciByRecursive(n - 1) + fibonacciByRecursive(n - 2);
}

const memoizedFibonacci = memoized(n => {
  if (n <= 1) return n;

  return memoizedFibonacci(n - 1) + memoizedFibonacci(n - 2);
});

console.log('🚀 ~ fibonacciByLoop:', fibonacciByLoop(9));
console.log('🚀 ~ fibonacciByRecursive:', fibonacciByRecursive(9));
console.log(
  '🚀 ~ memoizedFibonacci ~ memoizedFibonacci:',
  memoizedFibonacci(9)
);

// TCO Factorial

let currN = 100000;
let acc = 0;
while (currN >= 1) {
  function f(n) {
    if (n % 10000 === 1 || n === 1) return 1;
    try {
      currN = n;
      acc = f(n - 1); // f(10) -> f(9) => f(8) -> f(7)
    } catch (err) {
      // 10 * 9 * 8 * 1
      return 1;
    }
  }
  f(currN);
}

function tcoFactorial(n, acc) {
  if (n === 1) return acc;

  return tcoFactorial(n - 1, acc + n);
}

//tcoFactorial(10000, 0);

console.log('🚀 ~ makeArrayTco:', makeArrayTco(10));
