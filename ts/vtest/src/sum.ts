export const sum = (...args: number[]) => args.reduce((acc, a) => acc + a, 0);

export const sumId = async () => {
  const users = (await fetch('https://jsonplaceholder.typicode.com/users').then(
    res => res.json()
  )) as { id: number }[];

  return users.reduce((acc, { id }) => acc + id, 0);
};

type User = { id: number; name: string; username: string };
export const getUser = async (userId: number): Promise<User> => {
  return fetch(`https://jsonplaceholder.typicode.com/users/${userId}`).then(
    res => res.json()
  );
};

export const sumStrs = (...strs: string[]) => strs.join('+');
