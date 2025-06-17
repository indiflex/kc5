function Dog(name, power) {
  // const dog = {};
  // 2)
  const dog = Object.create(Dog.prototype);
  dog.name = name;
  dog.power = power;
  return dog;

  // 1)
  // this.name = name;
  // this.power = power;

  // return this;
}

Dog.prototype.eat = function (amount) {
  console.log(`${this.name} is eating.`);
  this.power += amount;
};

const maxx = new Dog('Maxx', 7); // {name: 'Maxx
maxx.eat(5);

// ------------------------
class Emp {
  firstName;
  lastName;
  constructor() {
    return new Proxy(this, {
      get(target, prop) {
        if (prop === 'fullName') {
          return `${this.firstName} ${this.lastName}`;
        } else {
          return target[prop];
        }
      },
      set(target, prop, value) {
        if (prop === 'fullName') {
          const [f, l] = value.split(' ');
          if (!l) {
            target.firstName = target.firstName;
            target.lastName = f;
          } else {
            this.firstName = f;
            this.lastName = l.toUpperCase();
          }
        } else {
          target[prop] = value;
        }
      },
    });
  }
  // get fullName() {
  //   return `${this.firstName} ${this.lastName}`
  // }
  // set fullName()
}

const hong = new Emp();
hong.firstName = 'Jade';
const f = hong.firstName;
console.log('🚀 f:', f);
hong.fullName = 'Kildong Hong'; // split하여 firstName, lastName 셋
console.log(hong.fullName); // 'Kildong HONG' 출력하면 통과!
hong.fullName = 'Lee';
console.log(hong.firstName, hong.lastName); // 'Kildong LEE' 출력하면 통과!

// ----------------------
const assert = require('assert');
function proto() {
  const arr = [1, 2, 3, 4, 5];
  const hong = { id: 1, name: 'Hing' };
  const kim = { id: 2, name: 'Kim' };
  const lee = { id: 3, name: 'Lee' };
  const users = [hong, lee, kim];
  Object.defineProperty(Array.prototype, 'firstObject', {
    get() {
      return this[0];
    },
    set(v) {
      this[0] = v;
    },
  });
  Object.defineProperty(Array.prototype, 'lastObject', {
    get() {
      return this.at(-1);
    },
    set(v) {
      this[this.length - 1] = v;
    },
  });
  const fo = arr.firstObject;
  console.log('🚀 fo:', fo);
  assert.deepStrictEqual([arr.firstObject, arr.lastObject], [1, 5]);

  Array.prototype.mapBy = function (prop) {
    return this.map(a => a[prop]);
  };
  assert.deepStrictEqual(users.mapBy('id'), [1, 3, 2]);
  assert.deepStrictEqual(users.mapBy('name'), ['Hing', 'Lee', 'Kim']);

  Array.prototype.filterBy = function (prop, val, isInclude) {
    return this.filter(a =>
      isInclude ? a[prop].includes(val) : a[prop] === val
    );
  };
  assert.deepStrictEqual(users.filterBy('id', 2), [kim]);
  assert.deepStrictEqual(users.filterBy('name', 'i', true), [hong, kim]); // key, value일부, isInclude
  assert.deepStrictEqual(users.rejectBy('id', 2), [hong, lee]);
  assert.deepStrictEqual(users.rejectBy('name', 'i', true), [lee]);
  assert.deepStrictEqual(users.findBy('name', 'Kim'), kim);
  assert.deepStrictEqual(users.sortBy('name:desc'), [lee, kim, hong]);
  assert.deepStrictEqual(users.sortBy('name'), [hong, kim, lee]);
  assert.deepStrictEqual(users.firstObject, hong);
  assert.deepStrictEqual(users.lastObject, lee);
  users.firstObject = kim;
  assert.deepStrictEqual(users.firstObject, kim);
  users.lastObject = hong;
  assert.deepStrictEqual(users.lastObject, hong);
}
proto();

class Collection {}

class Stack extends Collection {
  constructor() {
    this.arr = [];
  }

  push(x) {
    this.arr.push(x);
  }
}
