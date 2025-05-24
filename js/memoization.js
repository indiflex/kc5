function memoized(fn) {
  const memoizedTable = {};
  return function B(k) {
    return memoizedTable[k] || (memoizedTable[k] = fn(k));
  };
}

const memoizedFactorial = memoized(function A(n) {
  if (n === 1) return 1;
  return n * memoizedFactorial(n - 1);
});
console.log(memoizedFactorial(3));
