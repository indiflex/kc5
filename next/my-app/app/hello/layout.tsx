import Link from 'next/link';
import { PropsWithChildren } from 'react';

export default function HelloLayout({ children }: PropsWithChildren) {
  return (
    <>
      <nav className='flex justify-around space-x-3 text-sm'>
        <Link href={'/hello/morning'}>Morning</Link>
        <Link href={'/hello/afternoon'}>Afternoon</Link>
        <Link href={'/hello/evening'}>Evening</Link>
      </nav>

      <hr />
      <div className='text-center mt-5'>{children}</div>
    </>
  );
}
