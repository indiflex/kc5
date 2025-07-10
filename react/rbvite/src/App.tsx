import { useState, type MouseEvent } from 'react';
import './App.css';

export type LoginUser = { id: number; name: string };
export type CartItem = { id: number; name: string; price: number };
export type Session = {
  loginUser: LoginUser | null;
  cart: CartItem[];
};

const SampleSession: Session = {
  loginUser: null,
  // loginUser: { id: 1, name: 'Hong' },
  cart: [
    { id: 100, name: '라면', price: 3000 },
    { id: 101, name: '컵라면', price: 2000 },
    { id: 200, name: '파', price: 5000 },
  ],
};

function App() {
  const [count, setCount] = useState(0);
  const [session, setSession] = useState<Session>(SampleSession);

  const clickCount = (evt: MouseEvent<HTMLButtonElement>) => {
    evt.preventDefault();
    evt.stopPropagation();
    setCount(count => count + 1);
  };

  const login = (id: number, name: string) =>
    setSession({
      ...session,
      loginUser: { id, name },
    });

  const logout = () => setSession({ ...session, loginUser: null });

  return (
    <>
      <h1>React Basic</h1>
      {session.loginUser ? (
        <button onClick={logout}>{session.loginUser?.name} Logined</button>
      ) : (
        <button onClick={() => login(2, 'Kim')}>Login</button>
      )}
      <button onClick={clickCount}>count is {count}</button>
    </>
  );
}

export default App;
