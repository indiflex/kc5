import { GithubLoginButton } from '@/components/github-login-button';
import { GoogleLoginButton } from '@/components/google-login-button';
import { KakaoLoginButton } from '@/components/kakao-login-button';
import { NaverLoginButton } from '@/components/naver-login-button';
import { SnsLoginButton } from '@/components/sns-login-button';

export default function Login() {
  return (
    <div className='grid place-items-center'>
      <h1 className='text-2xl'>Login</h1>
      <div className='w-72 flex flex-col gap-3'>
        <SnsLoginButton label='Sign with Naver' />
        <GithubLoginButton />
        <GoogleLoginButton />
        <KakaoLoginButton />
        <NaverLoginButton />
      </div>
    </div>
  );
}
