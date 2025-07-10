type Props = {
  login: (id: number, name: string) => void;
};
export default function Login({ login }: Props) {
  return (
    <>
      <button onClick={() => login(2, 'Kim')}>Login</button>
    </>
  );
}
