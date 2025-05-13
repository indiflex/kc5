let i;
var x;
// var f;
function ff() {
  // console.log('ff>', y, yy);
  console.log('ff>', y);
}
var xx;
var y;
i = 1;
console.log(i); // error
console.log('x=', x);
x = 1;
// console.log('ff>>', ff, f);
console.log('ff>>', ff);
// if (f) f(); // error

{
  function f() {
    console.log('f>', x, xx, bb);
  }
  const bb = 'BB';
  x = 2;
  f();
  const b = 1;
  q = 1;
}
console.log('🚀 q:', q);
if (x >= 2) {
  y = 5;
  let yy = 55;
}
xx = 100;
ff();

f = () => console.log('FFFFFFFFF');
console.log('🚀 f:', f);
if (f) f();
