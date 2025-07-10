function memoized<T extends (...args: Parameters<T>) => ReturnType<T>>(fn: T) {
  const memoizedTable: Record<string, ReturnType<T>> = {};
  return function B(...k: Parameters<T>) {
    const key = JSON.stringify(k);
    return memoizedTable[key] ?? (memoizedTable[key] = fn(...k));
  };
}

const memoizeAdd = memoized((a: number, b: number) => {
  return a + b;
});

console.log('memoizeAdd(1, 2)=', memoizeAdd(1, 2)); // 3
console.log('memoizeAdd(3, 4)=', memoizeAdd(3, 4)); // 7

const memoizeFactorial = memoized((n: number): number => {
  if (n <= 1) return 1;

  return n * memoizeFactorial(n - 1);
});
console.log('memoizeFactorial(3)=', memoizeFactorial(3)); //6
console.log('memoizeFactorial(5)=', memoizeFactorial(5)); //120
// ------------------------------------------
// 방법1) args를 Generic으로!
const debounce = <T extends unknown[]>(
  cb: (...args: T) => void,
  delay: number
) => {
  let timer: ReturnType<typeof setTimeout>;
  return (...args: T) => {
    if (timer) clearTimeout(timer);
    timer = setTimeout(cb, delay, ...args);
  };
};

// 방법2) cb 을 Generic으로!
const throttle = <T extends (...args: Parameters<T>) => ReturnType<T>>(
  cb: T,
  delay: number
) => {
  let timer: ReturnType<typeof setTimeout> | null;
  return (...args: Parameters<T>) => {
    if (timer) return;
    timer = setTimeout(() => {
      cb(...args);
      timer = null;
    }, delay);
  };
};

const debo = debounce((a: number, b: string) => console.log(a + 1, b), 1000);
for (let i = 10; i < 15; i++) debo(i, 'abc'); // 15, 'abc'

const thro = throttle((a: number) => console.log(a + 1), 1000);
for (let i = 10; i < 15; i++) thro(i); // 11

// ---------------------
type FirstArgs<F extends (...args: Parameters<F>) => ReturnType<F>> =
  F extends (...args: [...infer Arg]) => ReturnType<F> ? Arg[0] : never;
type SecondArgs<F> = F extends (...args: [...infer Arg]) => infer Ret
  ? Arg[1]
  : never;

// type Args<F> = F extends (...args: [...infer Arg]) => infer Ret ? Arg : never;
type Args<F> = F extends (...args: infer P) => any ? P[number] : never;

type First<F> = F extends (a: infer FirstParam, ...b: any) => void
  ? FirstParam
  : never;
type CArg11 = First<typeof add>; // number | string
type Second<F> = F extends (
  a: First<F>,
  b: infer SecondParam,
  ...c: any
) => void
  ? SecondParam
  : never;
type CArg22 = Second<typeof add>; // number | string

type Test1 = number extends unknown ? '맞음' : '틀림'; // "맞음"
type Test2 = any extends number ? '맞음' : '틀림'; // "틀림"
type N = number;
let i: N = 0;
let n: unknown = i;
function fff(num: number, un: number | string) {}
fff(1, 2);
type FX<F extends (num: number, un: number | string) => void> = Parameters<F>;
type FXa = FX<typeof add>;

type X<T> = T extends number | string ? T : never;
type XXX = X<number>;

const x = 1;
// type A = FirstArgs<typeof add>; // number
type Para = Parameters<typeof add>; // number
type A = Parameters<typeof add>[0]; // number
// type B = SecondArgs<typeof add>; // string
type B = Parameters<typeof add>[1]; // string
type C = Parameters<typeof add>; // number | string
type CArg = Args<typeof add>; // number | string

function add(a: number, b: string | number) {
  return `${a} - ${b}`;
}
