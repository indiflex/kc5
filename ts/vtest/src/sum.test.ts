// import { describe, expect, test } from 'vitest';
import { sum } from './sum';

describe('sum', () => {
  test('1 args', () => {
    expect(sum(1)).toBe(1);
  });
});
