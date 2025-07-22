import { use } from 'react';

type Props = {
  params: Promise<{ time: string }>;
};

export async function generateStaticParams() {
  return [
    { time: 'Morning' },
    { time: 'Afternoon' },
    { time: 'Evening' },
    { time: 'Night' },
  ];
}

export default function HiTime({ params }: Props) {
  const { time } = use(params);

  return (
    <>
      <h1 className='text-2xl capitalize'>good {time}~</h1>
    </>
  );
}
