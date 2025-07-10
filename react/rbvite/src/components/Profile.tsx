type Props = {
  logout: () => void;
  name: string;
};

export default function Profile({ logout, name }: Props) {
  return (
    <>
      <button onClick={logout}>{name} Logined</button>
    </>
  );
}
