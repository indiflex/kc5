import { ReactNode } from 'react';

type Props = {
  children: ReactNode;
  viewer: ReactNode;
};
export default function PhotosLayout({ children, viewer }: Props) {
  return (
    <>
      <h1 className='text-2xl text-center'>Photo Gallery</h1>
      <div className='flex justify-center'>{children}</div>
      {viewer}
    </>
  );
}
