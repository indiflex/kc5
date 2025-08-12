'use client';

import ThemeChanger from '@/components/theme-changer';
import { useSession } from 'next-auth/react';
import Image from 'next/image';
import Link from 'next/link';

export default function Nav() {
  const session = useSession();
  const didLogin = !!session?.data?.user;

  return (
    <div className='flex items-center gap-5'>
      <Link
        href='/'
        className='text-blue-500 hover:text-blue-800 hover:underline active-scale active:no-underline'
      >
        Home
      </Link>

      <ThemeChanger />

      {didLogin ? (
        <Link href='/my'>
          <Image
            src={session?.data?.user?.image || ''}
            alt={session?.data?.user?.name || ''}
            width={40}
            height={40}
            className='rounded-full'
          />
        </Link>
      ) : (
        <Link href='/api/auth/signin'>Login</Link>
      )}
    </div>
  );
}
