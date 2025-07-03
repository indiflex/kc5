import { sum, sumId } from './sum';

const obj = { id: 1, addr: { city: 'Seoul' } };

const mockFetch = jest.fn() as jest.MockedFunction<typeof fetch>;
global.fetch = mockFetch;

describe('sum', () => {
  beforeEach(() => {
    mockFetch.mockClear();
  });

  const testCases = [
    { input: [0], expected: 0 },
    { input: [1, 2, 3], expected: 6 },
    { input: [1, 2, 3, 4, 5], expected: 15 },
  ];
  for (const { input, expected } of testCases) {
    test(`case: sum(${input}) ==>`, () => expect(sum(...input)).toBe(expected));
  }

  it('return num with 1 data', () => {
    expect(sum(0)).toBe(0);
    expect(obj).toStrictEqual({
      id: 1,
      addr: { city: 'Seoul' },
    });
  });

  test('sumId', async () => {
    mockFetch.mockResolvedValueOnce({
      ok: true,
      json: async () => Array.from({ length: 10 }, (_, i) => ({ id: i + 1 })),
    } as Response);

    const totId = await sumId();
    expect(totId).toBe(55);
  });
});
