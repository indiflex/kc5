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
  id: number;
  name: string;
  addr: string;
  discountRate: number;
  spend: number[];
};
type Guest = {
  id: number;
  name: string;
  age: number;
  spend: number;
};

let who: Member | Guest = { id: 2, name: 'xx', age: 26, addr: 'xx', spend: 1 };

let m: Member;
let g: Guest = { id: 2, name: 'xx', age: 26, spend: 0 };

if (typeof who['spend'] === 'number') who = g;

let xxx = { id: 2, name: 'xx', age: 26, addr: 'xx' };

// g = xxx;
if ('age' in xxx) g = xxx;
else m = xxx;
