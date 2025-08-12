import { use } from 'react';

type Props = {
  params: Promise<{ member: string }>;
};
export default function Bookcase({ params }: Props) {
  const { member } = use(params);
  return (
    <>
      <h1 className='text-2xl font-semibold'>
        @{decodeURI(member)}&apos;s BookCase
      </h1>
    </>
  );
}
