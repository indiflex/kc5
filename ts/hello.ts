let myName = 'Jade';
const isMale = true;

myName = 123 as unknown as string;

const obj1: {} = 1;
const obj2: Object = 1;
const obj3: object = { oi: '1' };
// const obj4: object = null;

let rocker;

rocker = 'Alice';

console.log(`Hello, ${myName}!`);

let firstName = 'Tom';
// firstName.length();

let john = {
  firstName: 'John',
  lastName: 'ahn',
};

function f(...args: (number | string)[]) {}

type User =
  | {
      isStudent: true;
      takeTaxi: false;
    }
  | { isStudent: false; takeTaxi: true };

const s = { isStuden: true, takeTaxi: false } as const;

function isStudent(x: any): x is User {
  return 'isStudent' in x && 'takeTaxi' in x;
}

let ss = { is: false };

// .... fetch(...)

const y: User | undefined = isStudent(ss) ? ss : undefined;

const zUser = {};

type Member = {
  name: string;
  addr: string;
  discountRate: number;
};
type Guest = {
  name: string;
  age: number;
};

let who: Member | Guest;
who = {
  name: '홍길동',
  addr: '용산구',
  discountRate: 0.1,
};
// who; // const who: Member
const price = 10000 - 10000 * who.discountRate;

let xxx = { id: 2, name: 'xx', age: 26, addr: 'xx' };
let m: Member;
let g: Guest;
