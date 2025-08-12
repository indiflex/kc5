'use client';

import { Button } from '@/components/ui/button';
import Image from 'next/image';
import Link from 'next/link';
import { ExternalLink, UserX2Icon } from 'lucide-react';

export default function My() {
  return (
    <div className='grid place-items-center mt-5'>
      <div className='group bg-white dark:bg-black/10 rounded-lg shadow-md flex gap-3 border border-slate-200 p-3 max-w-96'>
        <Image
          src={'globe.svg'}
          alt='test'
          width={50}
          height={50}
          className='rounded-full border group-hover:border-0 group-hover:w-20 transition-all'
        />
        <div>
          <strong className='block'>indiflex seniorcoding</strong>
          <p className='truncate w-56 overflow-hidden'>
            Lorem ipsum sdf asdf asdf asdf dolor sit amet sdfaf sadfd.
          </p>
          <div className='bg-gray-100 hidden group-hover:block text-right space-x-2'>
            <Button
              variant='destructive'
              size={'sm'}
              className='cursor-zoom-in'
            >
              <UserX2Icon />
            </Button>
            <Button variant='default' size={'sm'} className='float-rightx'>
              <ExternalLink />
            </Button>
          </div>
        </div>
      </div>

      <Link href='/api/auth/signout' className='mt-5'>
        LogOut
      </Link>
    </div>
  );
}
