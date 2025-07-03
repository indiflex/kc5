const hongx = { id: 1, name: 'Hing', 12: 1 };
const kimx = { id: 2, name: 'Kim', 12: 1 };
const leex = { id: 3, name: 'Lee', 12: 1 };
const users = [hongx, leex, kimx];

declare global {
  interface Array<T> {
    firstObject: T;
    lastObject: T;

    mapBy<P extends keyof T>(prop: P): T[P][];

    filterBy<P extends keyof T>(
      prop: P,
      value: T[P],
      isIncludes?: boolean
    ): T[];

    rejectBy<P extends keyof T>(
      prop: P,
      value: T[P],
      isIncludes?: boolean
    ): T[];

    findBy<P extends keyof T>(prop: P, value: T[P]): T;

    sortBy<P extends keyof T | `${keyof T & string}:${'asc' | 'desc'}`>(
      prop: P
    ): T[];
  }
}

// type U = {id: number, name: string}
// type X = keyof U | `${keyof U & string}:${'asc' | 'desc'}`;

Array.prototype.sortBy = function <
  T,
  P extends keyof T | `${keyof T & string}:${'asc' | 'desc'}`
>(this: T[], prop: P) {
  const [key, direction = 'asc'] = (
    typeof prop === 'string' ? prop.split(':') : [prop]
  ) as [keyof T, string];

  // const [key, direction = 'asc'] = String(prop).split(':') as [keyof T, string]; // not valid at prop is symbol

  const dir = direction.toLowerCase() === 'desc' ? -1 : 1;
  return this.sort((a, b) => (a[key] > b[key] ? dir : -dir));
};

console.log('sort-name:desc=', users.sortBy('name:desc')); //  [lee, kim, hong];
console.log('sort-name=', users.sortBy('name')); // [hong, kim, lee]

Array.prototype.findBy = function <T, P extends keyof T>(
  this: T[],
  prop: P,
  value: T[P]
) {
  return this.find(a => a[prop] === value);
};
console.log(users.findBy('name', 'Kim')); //  kim;

Array.prototype.rejectBy = function <T, P extends keyof T>(
  this: T[],
  prop: P,
  value: T[P],
  isIncludes = false
) {
  return this.filter(a => {
    if (isIncludes && typeof a[prop] === 'string')
      return !a[prop].includes(value as string);
    if (isIncludes && Array.isArray(a[prop])) return !a[prop].includes(value);
    else return a[prop] !== value;
  });
};

console.log(users.rejectBy('id', 2)); // [hong, lee]
console.log(users.rejectBy('name', 'i', true)); // [hong, lee]

Array.prototype.filterBy = function <T, P extends keyof T>(
  this: T[],
  prop: P,
  value: T[P],
  isIncludes = false
) {
  return this.filter(a => {
    if (isIncludes && typeof a[prop] === 'string')
      return a[prop].includes(value as string);
    if (isIncludes && Array.isArray(a[prop])) return a[prop].includes(value);
    else return a[prop] === value;
  });
};
console.log(users.filterBy('id', 2)); // [kim]);
console.log(users.filterBy('name', 'i', true)); // [kim]

Array.prototype.mapBy = function <T, P extends keyof T>(this: T[], prop: P) {
  return this.map(a => a[prop]);
};

console.log(users.mapBy('id')); // [1, 3, 2];
console.log(users.mapBy('name')); // ['Hong', 'Lee', 'Kim']);

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
