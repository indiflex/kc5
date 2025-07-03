// import { describe, expect, it } from 'vitest';
import { sum } from './sum';

const obj = { id: 1, addr: { city: 'Seoul' } };

describe('sum', () => {
  test('ttt', () => {
    expect(sum()).toBe(0);
    expect.soft(sum(0)).toBe(0);
  });

  it('return num with 1 data', () => {
    expect(sum(0)).toBe(0);
    expect(sum(9)).toBe(9);
  });

  it('return 15 with 1~5 data', () => {
    expect(sum(1, 2, 3, 4, 5)).toBe(15);
    expect(obj).toStrictEqual({
      id: 1,
      addr: { city: 'Seoul' },
    });
  });
});
