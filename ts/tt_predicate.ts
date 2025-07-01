type User = {
  id: number;
  name: string;
  12: number;
};

type UserNumKeyPrefix = {
  [k in keyof User as `user_${k}`]: User[k];
};

type UserOnlyStrKey = {
  [k in keyof User as k & string]: User[k];
  // [k in keyof User as k extends string ? k : never]: User[k];
};

type UserOnlyStrKeyPrefix = {
  [k in keyof User as k extends string ? `user_${k}` : never]: User[k];
  // [k in keyof User as `user_${k & string}`]: User[k];
};

const deleteArrayx = (
  array: number[] | TUser[],
  startIdxOrKey: number | string,
  endIdxOrValue: number | TUser[keyof TUser] = array.length
) => {
  const cb =
    typeof startIdxOrKey === 'number' && typeof endIdxOrValue === 'number'
      ? (_: number | TUser, i: number) =>
          i < startIdxOrKey || i >= endIdxOrValue
      : (a: number | TUser) =>
          typeof startIdxOrKey === 'string' &&
          typeof a !== 'number' &&
          a[startIdxOrKey as keyof TUser] !== endIdxOrValue;

  return array.filter(cb);

  // if (typeof startIdxOrKey === 'number' && typeof endIdxOrValue === 'number') {
  //   return array.filter((_, i) => i < startIdxOrKey || i >= endIdxOrValue);
  // }

  // return array.filter(
  //   a =>
  //     typeof a !== 'number' &&
  //     typeof startIdxOrKey === 'string' &&
  //     a[startIdxOrKey] !== endIdxOrValue
  // );
};

const deleteArrayT = <T>(
  array: T[],
  startIdxOrKey: number | keyof T,
  endIdxOrValue: number | T[keyof T] = array.length
) => {
  const cb =
    typeof startIdxOrKey === 'number' && typeof endIdxOrValue === 'number'
      ? (_: T, i: number) => i < startIdxOrKey || i >= endIdxOrValue
      : (a: T) => a[startIdxOrKey as keyof T] !== endIdxOrValue;

  return array.filter(cb);
};

// function f<T extends unknown[]>(T, ...args: T)
// f(1, '2', false)
const deleteArray = <T extends unknown[]>(
  array: T,
  startIdxOrKey: number | keyof T[0],
  endIdxOrValue: number | T[0][keyof T[0]] = array.length
) => {
  const cb =
    typeof startIdxOrKey === 'number' && typeof endIdxOrValue === 'number'
      ? (_: T[0], i: number) => i < startIdxOrKey || i >= endIdxOrValue
      : (a: T[0]) => a[startIdxOrKey as keyof T[0]] !== endIdxOrValue;

  return array.filter(cb);
};

type TUser = { id: number; name: string };
const arr = [1, 2, 3, 4];
console.log(deleteArray(arr, 2)); // [1, 2]
console.log(deleteArray(arr, 1, 3)); // [1, 4]
console.log(arr); // [1, 2, 3, 4]

const users = [
  { id: 1, name: 'Hong' },
  { id: 2, name: 'Kim' },
  { id: 3, name: 'Lee' },
];

console.log(deleteArray(users, 2)); // [Hong, Kim]
console.log(deleteArray(users, 1, 2)); // [Hong, Lee]
console.log(deleteArray(users, 'id', 2)); // [Hong, Lee]
console.log(deleteArray(users, 'name', 'Lee')); // [Hong, Kim]

export {};
