import { Button } from '@/components/ui/button';

interface NaverLoginButtonProps {
  onClick?: () => void;
  label?: string;
}

export function SnsLoginButton({
  onClick,
  label = '네이버로 로그인',
}: NaverLoginButtonProps) {
  return (
    <Button
      type='button'
      onClick={onClick}
      aria-label={label}
      className='w-full gap-2 rounded-md bg-[#03C75A] text-white hover:brightness-95'
    >
      <span className='inline-flex size-5' aria-hidden='true'>
        <svg
          className='w-5 h-5'
          viewBox='0 0 24 24'
          xmlns='http://www.w3.org/2000/svg'
        >
          <rect width='24' height='24' rx='3' fill='#fff' opacity='0' />
          <path
            fill='currentColor'
            d='M6.5 6.5h3.2l4 5.6V6.5h3.8v11h-3.2l-4-5.6v5.6H6.5z'
          />
        </svg>
      </span>
      <span className='text-sm font-medium'>{label}</span>
    </Button>
  );
}
