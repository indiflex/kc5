'use strict';

console.log('-->', ff, ff.length);

function f() {
  var z;
  console.log('🚀 f - 1', ff?.length);

  if (true) {
    function ff(y) {
      console.log('🚀 ff - 1', ff.length, x, y);
    }
    const x = 1;
    console.log('🚀 f - if - 1', ff.lengh, x);
  }

  z = 'z';

  ff(12);
}

function ff() {
  console.log('🚀 global - ff - 1', ff.length);
}

f();
