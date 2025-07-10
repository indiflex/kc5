import type { Session } from '../App';
import Login from './Login';
import Profile from './Profile';

type Props = {
  session: Session;
  logout: () => void;
  login: (id: number, name: string) => void;
};
export default function My({ session, login, logout }: Props) {
  return (
    <>
      {session.loginUser ? (
        <Profile logout={logout} name={session.loginUser.name} />
      ) : (
        <Login login={login} />
      )}

      <ul>
        {session.cart.map(({ id, name, price }) => (
          <li key={id}>
            {name} <small>({price.toLocaleString()})</small>
          </li>
        ))}
      </ul>
    </>
  );
}
