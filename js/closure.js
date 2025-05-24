function factorial(n) {
  if (n === 1) return 1;
  return n * factorial(n - 1);
}

function factorialTCO(n, acc = 1) {
  if (n === 1) return acc * 1;
  return factorialTCO(n - 1, acc * n);
}
/*
f(3) : 3 * f(2)
t(3) : t(2, 1 * 3)
            t(1, 1 * 3 * 2)
                    
*/

console.log('x=', factorial(3));
console.log('tco=', factorialTCO(3));
