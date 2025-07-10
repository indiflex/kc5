import { getUser, sum, sumId, sumStrs } from './sum';

describe('sum', () => {
  test('sum - 0 args', () => {
    const tot = sum();
    expect(tot).toBe(0);
  });

  it('sum - 1 args', () => {
    const validArgs = [-2, -1, 0, 1, 2];
    for (const va of validArgs) expect(sum(va)).toBe(va);
  });
});

describe('sum - testcases', () => {
  const testCases = [
    { input: [0], expected: 0 },
    { input: [1, 2, 3], expected: 6 },
    { input: [1, 2, 3, 4, 5], expected: 15 },
  ];
  for (const { input, expected } of testCases) {
    test(`case: sum(${input}) ==>`, () => expect(sum(...input)).toBe(expected));
  }
});

describe('sumStrs & token', () => {
  test('string array -', () => {
    expect(sumStrs('ab', 'cd', 'ef')).toEqual('ab+cd+ef');
  });

  const TOKENS = ['Bret', 'Antonette', 'Samantha'];
  test('user token test', async () => {
    const tokens = await Promise.all([1, 2, 3].map(getUser));
    const x = tokens.map(({ username }) => username);
    console.log('🚀 x:', x);
    expect(x).toStrictEqual(TOKENS);
  });
});

describe('sumId - all user ids', () => {
  const mockFetch = jest.fn();
  global.fetch = mockFetch;

  test('1..10 ids - mock', async () => {
    mockFetch.mockResolvedValueOnce({
      ok: true,
      json: async () => Array.from({ length: 10 }, (_, i) => ({ id: i + 1 })),
    });

    const tot = await sumId();
    expect(tot).toBe(55);
  });
});
// describe('sumId - all user ids', () => {
//   test('1..10 ids', async () => {
//     const tot = await sumId();
//     expect(tot).toBe(55);
//   });
// });
