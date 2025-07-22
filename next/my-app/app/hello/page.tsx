import { Suspense } from 'react';
import SearchParams from './SearchParams';

export default function Hello() {
  return (
    <>
      <h3 className='text-2xl text-blue-500'>Hello Page</h3>

      <Suspense>
        <SearchParams />
      </Suspense>
    </>
  );
}
