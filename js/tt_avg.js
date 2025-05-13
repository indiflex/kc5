const prices = [
  10.34,
  19,
  'xxx',
  5.678,
  null,
  '20.9',
  1.005,
  0,
  undefined,
  0.5,
];

const P = 10 ** 2;
let sum = 0;
let cnt = 0;
// for (let i = 0; i < prices.length; i += 1) {
for (const price of prices) {
  // const price = p !== null ? Number(p) : null;
  // if (typeof price !== 'number') continue;
  // if (typeof price !== 'number' && isNaN(price)) continue;
  if (price === null || isNaN(price)) continue;
  // console.log(price, isNaN(price), Number(price));
  sum += +price * P;
  // sum += price;
  cnt += 1;
}
const avg = Math.trunc(sum / cnt) / P;
// const avg = (sum / cnt).toFixed(2);
console.log('🚀 sum:', sum, avg);

const onlyNumbers = prices.filter(price => price !== null && !isNaN(price));

const sum2 = onlyNumbers.reduce((acc, p) => acc + p);
console.log('🚀 sum2:', sum2, +(sum2 / onlyNumbers.length).toFixed(2));

const [sum3, cnt3] = prices.reduce(
  (acc, p) => {
    if (p === null || isNaN(p)) return acc;
    return [acc[0] + p, acc[1] + 1];
  },
  [0, 0]
);
console.log('🚀 sum3:', sum3, cnt3, +(sum3 / cnt3).toFixed(2));
