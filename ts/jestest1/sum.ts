export const sum = (...args: number[]) => args.reduce((acc, n) => acc + n, 0);

export const sumId = async () => {
  const users = (await fetch('https://jsonplaceholder.typicode.com/users').then(
    res => res.json()
  )) as { id: number }[];
  return users.reduce((acc, { id }) => acc + id, 0);
};
