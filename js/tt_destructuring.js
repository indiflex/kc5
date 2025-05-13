const user = { name: 'Hong', passwd: 'xyz', addr: 'Seoul' };
function getValueExceptInitial(k) {
  const { [k]: val } = user;
  const [, ...ret] = val;
  return ret.join('');
}
console.log(getValueExceptInitial('name')); // 'ong'
console.log(getValueExceptInitial('passwd')); // 'yz'
console.log(getValueExceptInitial('addr')); // 'eoul'

const k = 'abc';
const obj = {
  [k]: 124,
};
console.log('🚀 obj:', obj);
