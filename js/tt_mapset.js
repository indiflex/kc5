const assert = require('assert');

const hrTeam = { id: 1, dname: '인사팀' };
const devTeam = { id: 2, dname: '개발팀' };
const depts = [hrTeam, devTeam];
const hong = { id: 1, name: 'Hong', dept: 1 };
const kim = { id: 2, name: 'Kim', dept: 2 };
const emps = [
  hong,
  kim,
  { id: 3, name: 'Park', dept: 2 },
  { id: 4, name: 'Choi', dept: 2 },
];
const deptMap = new Map(depts.map(d => [d.id, d]));
// console.log(deptMap);
const empMap = new Map(emps.map(d => [d.id, d]));
// console.log(empMap);

// key: Emp, val: Dept
const empDept = new Map(
  emps.map(emp => {
    const dept = deptMap.get(emp.dept);
    delete emp.dept;
    return [emp, dept];
  })
);
console.log(empDept); // Map(4) { { id: 1, name: 'Hong' } => { id: 1, dname: '인사팀' }, { id: 2, name: 'Kim' } => { id: 2, dname: '개발팀' }, { id: 3, name: 'Park' } => { id: 2, dname: '개발팀' }, { id: 4, name: 'Choi' } => { id: 2, dname: '개발팀' } }

console.log(empDept.get(kim).dname); // '개발팀'

assert.deepStrictEqual(
  [...empDept.keys()],
  emps.map(({ id, name }) => ({ id, name }))
);
assert.strictEqual(empDept.get(kim)?.dname, devTeam.dname);

const str = 'Senior COding Learning JS aqb';
const re1 = str.replace(/[A-Z]/g, (matchedStr, pos) => {
  return matchedStr.toLowerCase();
});
console.log('🚀 re:', re1);
const re2 = str.replace(
  /([A-Z]*)([a-z]*)/g,
  (allMatched, upper, lower) => `${upper.toLowerCase()}${lower.toUpperCase()}`
);
console.log('🚀 re2:', re2);
