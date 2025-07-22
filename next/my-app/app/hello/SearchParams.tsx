'use client';

import { usePathname, useRouter, useSearchParams } from 'next/navigation';

export default function SearchParams() {
  const searchParams = useSearchParams();
  const q = searchParams.get('q');
  console.log('🚀 ~ Hello ~ q:', q, searchParams.toString());

  const router = useRouter();
  const pathname = usePathname();
  const params = new URLSearchParams(searchParams.toString());

  return (
    <>
      <button
        onClick={() => {
          params.set('q', '000');
          router.push(`${pathname}?${params.toString()}`);
        }}
        className='border border-blue-200 hover:border-blue-300 rounded-md text-blue-300 hover:text-blue-500 p-1 cursor-pointer'
      >
        setQ
      </button>
    </>
  );
}
