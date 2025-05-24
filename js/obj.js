const assert = require('assert');
const arr = [100, 200, 300, 400, 500, 600, 700];
const obj = { name: 'Kim', addr: 'Yongsan', level: 1, role: 9, receive: false };

const data = [
  ['A', 10, 20],
  ['B', 30, 40],
  ['C', 50, 60, 70],
];

const kim2 = {
  nid: 3,
  nm: 'Kim',
  addr: { city: 'Pusan', road: 'Haeundaero', zip: null },
};
const newKim2 = deepCopy(kim2);
console.log('🚀 newKim2:', newKim2);
newKim2.addr.city = 'Daegu';
console.log(kim2.addr.city !== newKim2.addr.city); // true면 통과!

function deepCopy(obj) {
  const result = {};
  for (const [k, v] of Object.entries(obj)) {
    if (v !== null && typeof v === 'object') result[k] = deepCopy(v);
    else result[k] = v;
  }

  return result;
}

return;
function makeObjectFromArray(arr) {
  const result = {};
  for (const [k, ...rest] of arr) {
    result[k] = rest;
  }

  return result;
}
function makeObjectFromArrayHS(arr) {
  for (i in arr) {
    let [, ...rest] = arr[i];
    arr[i] = [arr[i][0], rest]; // ['A', [10, 20]]
  }
  return Object.fromEntries(arr);
}

function makeArrayFromObject2(obj) {
  const result = [];
  for (const k in obj) {
    result.push([k, ...obj[k]]);
  }
  return result;
}
function makeArrayFromObject(obj) {
  const result = [];
  for (const [k, v] of Object.entries(obj)) {
    result.push([k, ...v]);
  }
  return result;
}
function makeArrayFromObjectHS(obj) {
  const res = Object.entries(obj);
  for (i in res) {
    res[i] = [res[i][0], ...res[i][1]];
  }
  return res;
}

assert.deepStrictEqual(makeObjectFromArray(data), {
  A: [10, 20],
  B: [30, 40],
  C: [50, 60, 70],
});

const x2 = makeArrayFromObject({ A: [10, 20], B: [30, 40], C: [50, 60, 70] });
assert.deepStrictEqual(x2, data);
console.log('🚀 x2:', x2);

return;
console.log('-----------1. for-in문 사용 배열의 인덱스(키) 출력 ----------');
for (const a in arr) console.log(a);

console.log('-----------2. for-in문 사용 배열의 원소(값) 출력 (of) ----------');
// for-in문을 사용하여 배열의 원소(값)를 출력하시오. (of)
for (const a in arr) console.log(arr[a]);
for (const a of arr) console.log(a);
console.log('-----------3. for-in문 사용 프로퍼티 이름(키) 출력.--------');
for (const a in obj) console.log(a);

console.log('------- 4. for-in문 사용 프로퍼티 값 출력.--------');
for (const a in obj) console.log(obj[a]);

console.log('---------5. for-of문을 사용 프로퍼티 값 출력---------');
for (const a of Object.values(obj)) console.log(a);

console.log(
  '----------6. level 프로퍼티가 열거(entries)되지 않도록 설정하시오.-------'
);
Object.defineProperty(obj, 'level', {
  enumerable: false,
});
for (const [k, a] of Object.entries(obj)) console.log(k, '=>', a);
return;

console.log(
  '----------7. role 프로퍼티는 읽기전용으로 설정하시오. // Object.defineProperty-------'
);
Object.defineProperty(obj, 'role', {
  writable: false,
});
// 전체 읽기 전용
Object.freeze(obj);
