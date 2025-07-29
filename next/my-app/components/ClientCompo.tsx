'use client';

import { useEffect, useMemo } from 'react';

export default function ClientCompo({
  arr,
  date,
}: {
  arr: number[];
  date: { id: number; dt: string };
}) {
  const sum = useMemo(
    () =>
      arr.reduce((acc, a) => {
        console.log('🚀 ~ ClientCompo.a:', a);
        return acc + a;
      }),
    [arr]
  );

  const tot = arr.reduce((acc, a) => {
    console.log('🚀 ~ ClientCompo.reduce:', a);
    return acc + a;
  });
  console.log('**************', tot);
  useEffect(() => {
    console.log('🚀 ~ tot:', tot);
  }, [tot]);

  return (
    <h1 className='text-2xl'>
      ClientCompo: {tot}:{sum} - {date.dt}
    </h1>
  );
}
