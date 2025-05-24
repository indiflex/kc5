const ma = makeArray(10);
console.log('🚀 ma:', ma);
// ⇒ [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

const mra = makeReverseArray(5);
console.log('🚀 mra:', mra);
// ⇒ [5, 4, 3, 2, 1]

// cf. 위 makeArray를 TCO로 작성하시오.
const maTco = makeArrayTCO(10);
console.log('🚀 maTco:', maTco);
// ⇒ [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

function makeArray(n) {
  if (n === 1) return [1];

  // return [...makeArray(9),       10];
  // return [...makeArray(8),    9, 10];
  // return [...makeArray(7), 8, 9, 10];
  return [...makeArray(n - 1), n];
}

function makeReverseArray(n) {
  if (n === 1) return [1];
  return [n, ...makeReverseArray(n - 1)];
}

function makeArrayTCO(n, acc = []) {
  if (n === 1) return [1, ...acc];

  // return makeArrayTCO(9,               [10]);
  // return makeArrayTCO(8,        [9, ...[10]]);
  // return makeArrayTCO(7, [8, ...[9, 10]]);
  return makeArrayTCO(n - 1, [n, ...acc]);
}
