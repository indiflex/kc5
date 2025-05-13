// 'use strict';

f = 1;
// NaN = 1;
// Infinity = 0;
console.log('🚀 Infinity:', Infinity);
// Array.prototype = Object.prototype;
function f(a, aa) {
  console.log('outer f');
}
// delete f; // error
{
  const y = f.bind({ x: 1 });
  f(100);
  y(100);
  function f(a) {
    console.log('block f >>', a, this.x);
  }
  f.call({ x: 2 }, 999);
}
f(200);
