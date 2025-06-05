globalThis.name = 'XXXXXX';
class Dog {
  constructor(name) {
    this.name = name;
  }

  getName() {
    {
      function _f() {
        console.log('____f');
      }
      console.log('&&&&--->>', _f);
    }
    console.log('&&&&&&&>>', _f);
    return this.name;
  }

  fn() {
    return 'FN';
  }

  static sfn() {
    return 'SFN';
  }
}

globalThis.id = 100;
const obj = {
  id: 1,
  f() {
    return this.id;
  },
};
const fff = obj.f;
console.log('*******', obj.id, obj.f(), fff());

const lucy = new Dog('Lucy');
console.log('🚀 lucy:', lucy);
console.log('🚀 Dog:', Dog);
const { sfn } = Dog;
console.log('🚀 sfn:', sfn.name);
const { name: aa, fn: fnnn, getName } = lucy;
console.log('🚀 fnnn:', fnnn);
console.log('🚀 getName:', getName);
console.log(aa, sfn(), fnnn(), getName.name); // ?
lucy.getName();
getName(); // this

// function sf() {
//   'use strict';
//   console.log('sss>>', this.name);
// }
// sf();

return;

const weeks = '일월화수목금토';
const getNextWeek = (() => {
  let widx = -1;

  return () => {
    widx += 1;
    if (widx >= weeks.length) widx = 0;
    return `${weeks[widx]}요일`;
  };
})();

let cnt = 0;
const intl = setInterval(() => {
  // widx += 2; // side-effect!
  console.log('call', cnt, getNextWeek());
  if ((cnt += 1) === 8) clearInterval(intl);
}, 1000);
