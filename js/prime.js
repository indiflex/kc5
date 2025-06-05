const assert = require('assert');

const hasPrimeBad = arr => {
  for (let i = 0; i < arr.length; i++) {
    if (isPrimeNormal(arr[i])) return true;
  }
  return false;
};
const hasPrime = arr => arr.some(isPrimeNormal);

assert.strictEqual(hasPrime([1, 2, 3]), true);

// 2) 특정 배열의 원소 중 소수만 추출하는 함수를 작성하시오.
const primeNumbers = arr => arr.filter(isPrimeNormal);
assert.deepStrictEqual(primeNumbers([1, 2, 3, 4, 5]), [2, 3, 5]);

function isPrimeNormal(n) {
  if (n === 1) return false;
  for (let i = 2; i <= Math.sqrt(n); i += 1) {
    if (n % i === 0) return false;
  }
  return true;
}

const a = 'a';
// console.log(Number(a), a.charCodeAt(0).toString(10)); // 97

const arr0 = [1, 3, 2, 5, 10, 5];
const arr1 = ['cc', 'b', 144, 21, 'a', '11', 5, 1];
// const s1 = arr1.sort((a, b) => a - b);
const s1 = arr1.sort((a, b) => (a > b ? 1 : -1));
// console.log('🚀 s1:', s1);

const arr = [1, 2, 3, 4];
const push = (arr, ...args) => [...arr, ...args];
assert.deepStrictEqual(push(arr, 5, 6), [1, 2, 3, 4, 5, 6]);

const pop = (arr, cnt = 1) =>
  cnt > 1 ? arr.slice(cnt * -1) : arr[arr.length - cnt];
assert.deepStrictEqual(pop(arr), 4);
assert.deepStrictEqual(pop(arr, 2), [3, 4]); // 2개 팝!

const unshift = (arr, ...args) => [...args, ...arr];
assert.deepStrictEqual(unshift(arr, 0), [0, 1, 2, 3, 4]);
assert.deepStrictEqual(unshift(arr, 7, 8), [7, 8, 1, 2, 3, 4]);

const shift = (arr, idx = 1) => [arr.slice(0, idx), arr.slice(idx)];
assert.deepStrictEqual(shift(arr), [[1], [2, 3, 4]]); // [shift되는 원소들, 남은 원소들]
assert.deepStrictEqual(shift(arr, 2), [
  [1, 2],
  [3, 4],
]); // 2개 shift
assert.deepStrictEqual(arr, [1, 2, 3, 4]);

// const deleteArray = (arr, s, e = arr.length) => [...arr].splice(s, e - s);
const deleteArray = (arr, startOrKey, endOrVal = arr.length) => {
  if (typeof startOrKey === 'number')
    return [...arr.slice(0, startOrKey), ...arr.slice(endOrVal)];

  return arr.filter(a => a[startOrKey] !== endOrVal);
};
assert.deepStrictEqual(deleteArray(arr, 2), [1, 2]); // 2부터 끝까지 지우고 나머지 리턴
assert.deepStrictEqual(deleteArray(arr, 1, 3), [1, 4]); // 1부터 3까지 지우고 나머지 리턴
assert.deepStrictEqual(arr, [1, 2, 3, 4]);

const Hong = { id: 1, name: 'Hong' };
const Kim = { id: 2, name: 'Kim' };
const Lee = { id: 3, name: 'Lee' };
const users1 = [Hong, Kim, Lee];

assert.deepStrictEqual(deleteArray(users1, 2), [Hong, Kim]);
assert.deepStrictEqual(deleteArray(users1, 1, 2), [Hong, Lee]);
assert.deepStrictEqual(deleteArray(users1, 'id', 2), [Hong, Lee]);
assert.deepStrictEqual(deleteArray(users1, 'name', 'Lee'), [Hong, Kim]);

const hong = { id: 1, name: 'Hong' };
const choi = { id: 5, name: 'Choi' };
const kim = { id: 2, name: 'kim' };
const lee = { id: 3, name: 'Lee' };
const park = { id: 4, name: 'Park' };
const users = [kim, lee, park]; // 오염되면 안됨!!

users.addUser = newer => [...users, newer];
Object.defineProperty(users, 'addUser', { enumerable: false });

assert.deepStrictEqual(users.addUser(hong), [kim, lee, park, hong]);
assert.deepStrictEqual(users.addUser(hong), [kim, lee, park, hong]);
assert.deepStrictEqual(users, [kim, lee, park]);

users.removeUser = user => users.filter(u => user.id !== u.id);

Object.defineProperty(users, 'removeUser', { enumerable: false });
assert.deepStrictEqual(users.removeUser(lee), [kim, park]);
assert.deepStrictEqual(users, [kim, lee, park]);

users.changeUser = (user1, user2) =>
  users.map(u => (u.id === user1.id ? user2 : u));

Object.defineProperty(users, 'changeUser', { enumerable: false });
assert.deepStrictEqual(users.changeUser(kim, choi), [choi, lee, park]);
assert.deepStrictEqual(users, [kim, lee, park]);
