const assert = require('assert');

const s = ['강원도 고성군', '고성군 토성면', '토성면 북면', '북면', '김1수'];

// '강원도 고성군'.match(/[ㄱ가-깋]+[ㅇ아-잏]+/g)
const CHO = 'ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ';
const JA = '가까나다따라마바빠사싸아자짜차카타파하';
const searchByKoreanInitialSound = (data, first) => {
  const reg = [...first].reduce((acc, a) => {
    const idx = CHO.indexOf(a);
    const ja = JA[idx];
    const e = JA[idx + 1].charCodeAt(0) - 1;
    return `${acc}[${a}${ja}-${String.fromCharCode(e)}]+`;
  }, '');
  // console.log('🚀 reg:', reg);
  const regExp = new RegExp(reg);
  return data.filter(d => regExp.test(d));
};

assert.deepStrictEqual(searchByKoreanInitialSound(s, 'ㄱㅇ'), [
  '강원도 고성군',
]);
assert.deepStrictEqual(searchByKoreanInitialSound(s, 'ㄱㅅㄱ'), [
  '강원도 고성군',
  '고성군 토성면',
]);
assert.deepStrictEqual(searchByKoreanInitialSound(s, 'ㅌㅅㅁ'), [
  '고성군 토성면',
  '토성면 북면',
]);
assert.deepStrictEqual(searchByKoreanInitialSound(s, 'ㅂㅁ'), [
  '토성면 북면',
  '북면',
]);
assert.deepStrictEqual(searchByKoreanInitialSound(s, 'ㅍㅁ'), []);
assert.deepStrictEqual(searchByKoreanInitialSound(s, 'ㄱ1ㅅ'), ['김1수']);
