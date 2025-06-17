const assert = require('assert');

const ALPHA_NUMERIC = [...'LMNRlmnr013678'].map(a => a.charCodeAt(0));

// console.log('🚀 ALPHA_NUMERIC:', ALPHA_NUMERIC);
const ㄱ = 'ㄱ'.charCodeAt();
const ㅎ = 'ㅎ'.charCodeAt();
const 가 = '가'.charCodeAt();
const 힣 = '힣'.charCodeAt();

const isEndJaum = str => {
  const e = str.charCodeAt(str.length - 1);
  // console.log('🚀 str:', str, e);
  if (ALPHA_NUMERIC.includes(e)) return true;
  if (e >= ㄱ && e <= ㅎ) return true;
  if (e >= 가 && e <= 힣 && (e - 가) % 28 !== 0) return true;

  return false;
};

assert.equal(isEndJaum('아지오'), false);
assert.equal(isEndJaum('북한강'), true);
assert.equal(isEndJaum('뷁'), true);
assert.equal(isEndJaum('강원도'), false);
assert.equal(isEndJaum('바라당'), true);
assert.equal(isEndJaum('ㅜㅜ'), false);
assert.equal(isEndJaum('케잌'), true);
assert.equal(isEndJaum('점수 A'), false);
assert.equal(isEndJaum('알파벳L'), true);
assert.equal(isEndJaum('24'), false);
assert.equal(isEndJaum('23'), true);

const josa = (str, jaum, moum) => (isEndJaum(str) ? jaum : moum);
const iga = str => josa(str, '이', '가');
const eunun = str => josa(str, '은', '는');
const eulul = str => josa(str, '을', '를');
const eyuya = str => josa(str, '이어야', '여야');

assert.equal(`고성군${iga('고성군')}`, '고성군이');
assert.equal(`고성군${eunun('고성군')}`, '고성군은');
assert.equal(`고성군${eulul('고성군')}`, '고성군을');
assert.equal(`성동구${iga('성동구')}`, '성동구가');
assert.equal(`성동구${eunun('성동구')}`, '성동구는');
assert.equal(`성동구${eulul('성동구')}`, '성동구를');
assert.equal(`고성군${eyuya('고성군')}`, '고성군이어야');
assert.equal(`성동구${eyuya('성동구')}`, '성동구여야');

// for (let i = '가'.charCodeAt(); i <= '깋'.charCodeAt(); i++) {
//   console.log(i - 44032, String.fromCharCode(i), (i - 44032) % 28);
// }
