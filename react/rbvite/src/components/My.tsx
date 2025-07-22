import type { CartItem, Session } from '../App';
import Login from './Login';
import Profile from './Profile';
import './My.css';
import { useRef, useState, type FormEvent, type RefObject } from 'react';

type Props = {
  session: Session;
  logout: () => void;
  login: (id: number, name: string) => void;
  addItem: (newer: CartItem) => void;
  editItem: (editingItem: CartItem) => void;
  removeItem: (id: number) => void;
};

export default function My({
  session,
  login,
  logout,
  addItem,
  editItem,
  removeItem,
}: Props) {
  const nameRef = useRef<HTMLInputElement>(null);
  const priceRef = useRef<HTMLInputElement>(null);

  const [workingItem, setWorkingItem] = useState<CartItem | null>(null);

  const saveCartItem = (evt: FormEvent<HTMLFormElement>) => {
    evt.preventDefault();
    if (!nameRef.current || !priceRef.current) return;

    const id = workingItem ? workingItem.id : 0;
    const name = nameRef.current?.value;
    const price = priceRef.current?.value;

    let key: string | undefined;
    let ref: RefObject<HTMLInputElement | null> = nameRef;

    if (!name || !name?.trim()) {
      key = '상품명';
      ref = nameRef;
    }

    if (!price) {
      key = '가격';
      ref = priceRef;
    }

    if (key) {
      alert(`${key} 을(를) 입력하세요!`);
      ref?.current?.focus();
      return;
    }

    const isEditing = !!workingItem;
    const action = isEditing ? editItem : addItem;

    // console.table({ id, name: name!, price: Number(price) });
    action({ id, name: name!, price: Number(price) });

    if (isEditing) setWorkingItem(null);

    nameRef.current.value = '';
    priceRef.current.value = '';
    nameRef.current?.focus();
  };

  const setWorkingItemValues = (item: CartItem) => {
    if (!nameRef.current || !priceRef.current) return;

    nameRef.current.value = item.name;
    priceRef.current.value = String(item.price);

    setWorkingItem(item);
  };

  return (
    <>
      {session.loginUser ? (
        <Profile logout={logout} name={session.loginUser.name} />
      ) : (
        <Login login={login} />
      )}

      {/* <h1>workingItem: {workingItem?.id}</h1> */}
      <ul>
        {session.cart.map(({ id, name, price }) => (
          <li key={id}>
            <small>{id}.</small>
            <a
              href='#'
              onClick={() => setWorkingItemValues({ id, name, price })}
            >
              {name}
            </a>
            <small>({price.toLocaleString()})</small>
            <button
              onClick={() => removeItem(id)}
              className='btn btn-sm red'
              title='아이템 삭제'
            >
              X
            </button>
          </li>
        ))}
      </ul>
      <form onSubmit={saveCartItem} className='item-form'>
        <input type='text' ref={nameRef} placeholder='name...' />
        <input
          type='number'
          name='price'
          ref={priceRef}
          placeholder='price...'
        />
        <button type='reset'>취소</button>
        <button type='submit'>{workingItem ? '수정' : '등록'}</button>
      </form>
    </>
  );
}
