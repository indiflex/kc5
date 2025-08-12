'use client';

import ThemeChanger from '@/components/theme-changer';
import { useSession } from 'next-auth/react';
import Image from 'next/image';
import Link from 'next/link';
import { SquareLibraryIcon } from 'lucide-react';

export default function Nav() {
  const session = useSession();
  console.log('🚀 ~ session:', session?.data?.user);
  const didLogin = !!session?.data?.user;

  return (
    <div className='flex items-center gap-5'>
      <Link href='/' className=' active-scale active:no-underline'>
        Home
      </Link>

      <Link
        href={`/bookcase/${session?.data?.user?.name}`}
        className='border rounded-full p-1'
      >
        <SquareLibraryIcon />
      </Link>

      <ThemeChanger />

      {didLogin ? (
        <Link href='/my'>
          <Image
            src={session?.data?.user?.image || ''}
            alt={session?.data?.user?.name || ''}
            width={40}
            height={40}
            className='rounded-full border'
          />
        </Link>
      ) : (
        <Link href='/api/auth/signin'>Login</Link>
      )}
    </div>
  );
}
