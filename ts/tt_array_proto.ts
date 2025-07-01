const hongx = { id: 1, name: 'Hong' };
const kimx = { id: 2, name: 'Kim' };
const leex = { id: 3, name: 'Lee' };
const users = [hongx, leex, kimx];

declare global {
  interface Array<T> {
    firstObject: T;
    lastObject: T;
    mapBy: <T extends Object, P extends keyof T>(this: T[], prop: P) => T[P][];
    filterBy: <T extends Object>(
      this: T[],
      prop: keyof T,
      value: T[keyof T],
      isIncludes?: boolean
    ) => T[];
  }
}

Array.prototype.filterBy = function <T extends Object>(
  this: T[],
  prop: keyof T,
  value: T[keyof T],
  isIncludes = false
) {
  return this.filter(a => {
    if (isIncludes) {
      if (Array.isArray(a[prop])) return a[prop]?.includes(value);
      else if (typeof a[prop] === 'string')
        return a[prop]?.includes(value as string);
    }

    return a[prop] === value;
  });
};
console.log(users.filterBy('id', 2)); // [kim]);
console.log(users.filterBy('name', 'i', true)); // [kim]

const arrx = [
  { id: 1, addr: [1, 2, 3] },
  { id: 2, addr: [1, 22, 3] },
];
console.log('tt>>', arrx.filterBy('addr', 2, true));

Array.prototype.mapBy = function <T extends Object, P extends keyof T>(
  this: T[],
  prop: P
) {
  return this.map(a => a[prop]);
};

console.log(users.mapBy('id')); // [1, 3, 2];
console.log(users.mapBy('name')); // ['Hong', 'Lee', 'Kim']);

// Array.prototype.rejectBy = function (prop, value, isIncludes = false) {
//   const cb = isIncludes
//     ? a => !a[prop]?.includes(value)
//     : a => a[prop] !== value;

//   return this.filter(cb);
// };

// Array.prototype.findBy = function (prop, value) {
//   return this.find(a => a[prop] === value);
// };

// Array.prototype.sortBy = function (prop) {
//   // name | name:desc | name:asc
//   const [key, direction = 'asc'] = prop?.split(':');
//   const dir = direction.toLowerCase() === 'desc' ? -1 : 1;
//   // console.log('🚀  dir:', dir, prop);
//   return this.sort((a, b) => (a[key] > b[key] ? dir : -dir));
// };

// Array.prototype.groupBy = function (gfn) {
//   const ret = {};
//   for (const a of this) {
//     const k = gfn(a);
//     ret[k] ||= [];
//     ret[k].push(a);
//   }

//   return ret;
// };

// Object.defineProperties(Array.prototype, {
//   firstObject: {
//     get() {
//       return this[0];
//     },
//     set(value) {
//       this[0] = value;
//       // this.with(0, value); // pure fn
//     },
//   },
//   lastObject: {
//     get() {
//       return this.at([-1]);
//     },
//     set(value) {
//       this[this.length - 1] = value;
//       // this.with(-1, value);
//     },
//   },
// });

// console.log(users.rejectBy('id', 2)); // [hong, lee]
// console.log(users.rejectBy('name', 'i', true)); // [hong, lee]
// console.log(users.findBy('name', 'Kim')); //  kim;
// console.log(users.sortBy('name:desc')); //  [lee, kim, hong];
// console.log(users.sortBy('name')); // [hong, kim, lee]
// console.log(users.groupBy(({ dept }) => dept));
// /*
// Server: [
//   { id: 1, name: 'Hong', dept: 'Server' },
//   { id: 2, name: 'Kim', dept: 'Server' },
// ],
// Client: [
//   { id: 3, name: 'Lee', dept: 'Client' }
// ],
// */

// console.log('first/last=', users.firstObject.name, users.lastObject.name); // hong/lee
// users.firstObject = kimx;
// users.lastObject = hongx;
// console.log('first/last=', users.firstObject.name, users.lastObject.name); // kim/hong

export {};
