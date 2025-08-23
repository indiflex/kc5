# Practical Project

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

## Project Setup Scripts
1. create next project

```bash
pnpm dlx create-next-app@latest bm
```

```bash
cd bm
```

2. prettier & eslint setting

```bash
pnpm add -D prettier eslint-config-prettier 
```

```bash
pnpm add -D @trivago/prettier-plugin-sort-imports
```

.prettierrc 파일 작성 

```json
{
  "singleQuote": true,
  "jsxSingleQuote": true,
  "semi": true,
  "tabWidth": 2,
  "useTabs": false,
  "trailingComma": "es5",
  "parser": "typescript",
  "plugins": ["@trivago/prettier-plugin-sort-imports"],
  "importOrder": [
    "^next$",
    "^next/\\w*$",
    "^next/(.*)$",
    "^react$",
    "^react/(.*)$",
    "^lucide-react$",
    "^@/lib/(.*)$",
    "^[./]"
  ]
}
```

.prettierignore 파일 생성해서 prettier에서 제외하기

```
# Markdown 파일 제외
*.md
*.css

# 이미지, JSON, log 제외
*.png
*.jpg
*.json
*.log
*.ico
*.svg

# node_modules와 빌드 폴더 제외
node_modules
dist
build
LICENSE

.*
*.sql
*.yaml
*.yml
*.json
*.prisma
```

package.json에 format script 걸기
```json
"format": "prettier --write .",
```

```bash
vi eslint.config.mjs
```

```javascript
import { FlatCompat } from '@eslint/eslintrc'

const compat = new FlatCompat({
  baseDirectory: import.meta.dirname,
})

const eslintConfig = [
  ...compat.config({
    extends: ['next', 'next/typescript', 'prettier'],
    rules: {}
  }),
]

export default eslintConfig
```

3. node setting

```bash
vi .nvmrc
```

```
v22
```

4. pnpm hoisting setting (for eslint)

```bash
vi .npmrc
```

```
public-hoist-pattern[]=*eslint*
```

5. 새롭게 pnpm 으로 설치
```bash
pnpm install
```

6. shadcn 설치

```bash
pnpm dlx shadcn@latest init
```

```bash 모든 컴포넌트 설치
pnpx shadcn@latest add dashboard-01
```

7. Dark/Light mode
```bash
pnpm add next-themes
```

components/theme-provider.tsx

```typescript
'use client';

import { ThemeProvider as NextThemesProvider } from 'next-themes';
import { ComponentProps } from 'react';

export function ThemeProvider({
  children,
  ...props
}: ComponentProps<typeof NextThemesProvider>) {
  return <NextThemesProvider {...props}>{children}</NextThemesProvider>;
}

const { theme, setTheme } = useTheme();
```

components/theme-changer.tsx
```typescript
import { useTheme } from 'next-themes';
import { useEffect, useState } from 'react';
import { MonitorIcon, MoonIcon, SunIcon } from 'lucide-react';

const themes = ['light', 'system', 'dark'];
const themeIcon = {
  light: <MonitorIcon />,
  system: <MoonIcon />,
  dark: <SunIcon />,
};

export default function ThemeChanger() {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  const changeTheme = () => {
    let idx = themes.indexOf(theme as keyof typeof themeIcon) + 1;
    if (idx === themes.length) idx = 0;
    setTheme(themes[idx]);
  };

  if (!mounted) {
    return <SunIcon className='w-2 h-2' />;
  }

  return (
    <button
      onClick={changeTheme}
      className='cursor-pointer rounded-full border-1 border-blue-100 hover:ring-1 hover:ring-blue-300 hover:[&>svg]:stroke-blue-300 p-1'
    >
      {themeIcon[theme as keyof typeof themeIcon]}
    </button>
  );
}
```

8. next-auth

```bash
pnpm add next-auth@beta
```

lib/auth.ts

```typescript
import NextAuth from 'next-auth';
import GitHub from 'next-auth/providers/github';
import Google from 'next-auth/providers/google';
import Kakao from 'next-auth/providers/kakao';
import Naver from 'next-auth/providers/naver';

export const {
  handlers: { GET, POST },
  auth,
  signIn,
  signOut,
} = NextAuth({
  session: {
    strategy: 'jwt',
  },
  pages: {
    // signIn: '/login',
  },
  providers: [Google, GitHub, Naver, Kakao],
});
```

Auth key 생성 (.env.local에 자동으로 생성)
```bash
pnpm dlx auth secret
```

.env.local
```
DATABASE_URL="mysql://bookmarker@--@127.0.0.1:3309/bookmarkdb?connection_limit=5&pool_timeout=10"

AUTH_SECRET="FzF89ROlg5pOU/GBwHLxvJN"

AUTH_GOOGLE_ID="641566194982-20b29cu2ssn8.apps.googleusercontent.com"
AUTH_GOOGLE_SECRET=GOCSPX-pTpVkTlLswWi9X7

AUTH_GITHUB_ID=Ov23lilo1Te
AUTH_GITHUB_SECRET=3f776e98adfe551f474115d75ebf

AUTH_NAVER_ID="t7BZF1kwdh3"
AUTH_NAVER_SECRET="wMIch8ci"

AUTH_KAKAO_ID="d3134d7758c891199f62c9820"
AUTH_KAKAO_SECRET="7WoTBDPzI9MdtmfsyrqIlSTP"
```

app/api/auth/[...nextauth]/route.ts

```typescript
export { GET, POST } from '@/lib/auth';
// export const runtime = 'edge'; // 'nodejs'
```

app/layout.tsx 에 SessionProvider 걸기

```typescript
import { SessionProvider } from 'next-auth/react';
import { auth } from '@/lib/auth';

const session = use(auth());
...
<SessionProvider session={session}>
  ...
</SessionProvider>
```

middleware.ts 생성

```typescript
import { NextResponse, type NextRequest } from 'next/server';
import { auth } from './lib/auth';

export async function middleware(req: NextRequest) {
  const session = await auth();
  const didLogin = !!session?.user;
  if (!didLogin) {
    const callbackUrl = encodeURIComponent(req.nextUrl.pathname);
    return NextResponse.redirect(
      new URL(`/api/auth/signin?callbackUrl=${callbackUrl}`, req.url)
    );
  }

  return NextResponse.next();
}

export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|robots.txt|images|api/auth|login|regist|$).*)',
  ],
};
```

9. next.config.ts에 image host 등록

```typescript
import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  images: {
    remotePatterns: [
      { hostname: '*.googleusercontent.com' },
      { hostname: 'avatars.githubusercontent.com' },
      { hostname: 'phinf.pstatic.net' },
      { hostname: '*.kakaocdn.net' },
    ],
  },
};

export default nextConfig;
```

10. prisma setting
```bash
pnpm i -D prisma
```

```bash
pnpm dlx prisma init --datasource-provider mysql

# ==> .env 자동생성되는데, 지우고나서 .env.local에 DB 연결정보 세팅
```


eslint.config.mjs (under rule) to build project

```
ignorePatterns: ['lib/generated/prisma/**'],
```

table 생성

package.json에 script 설정 
```json
"scripts": {
  "db:pull": "dotenv -e .env.local prisma db pull",
  "db:gen": "dotenv -e .env.local prisma generate",
  "db:push": "dotenv -e .env.local prisma db push",
  "db:reset": "dotenv -e .env.local prisma migrate reset",
  "db:seed": "dotenv -e .env.local prisma db seed"
},
"prisma": {
  "seed": "ts-node --compiler-options {\"module\":\"CommonJS\"} prisma/seed.ts"
},
```

```
pnpm db:pull
```

generate해서 prisma-client 설치
```
pnpm db:gen

# ==> prisma/schema.prisma 생성
```

prisma client (db.ts)

```typescript
import { PrismaClient } from '@/lib/generated/prisma/client';

const prisma = new PrismaClient();

export default prisma;
```

seed data (prisma/seed.ts)

```typescript
async function main() {
  const sico = await prisma.member.upsert({
    where: { email: 'indiflex.sico@gmail.com' },
    update: {},
    create: {
      email: 'indiflex.sico@gmail.com',
      nickname: 'sico',
      Books: {
        create: {
          title: 'sico first book',
          withdel: false,
          Marks: {
            create: {
              url: 'https://naver.com',
              title: 'Naver',
              descript: 'seeding...',
            },
          },
        },
      },
    },
  });

  const indiflex = await prisma.member.upsert({
    where: { email: 'indiflex.corp@gmail.com' },
    update: {},
    create: {
      email: 'indiflex.corp@gmail.com',
      nickname: 'indiflex',
      Books: {
        create: [
          {
            title: 'indiflex first book',
            withdel: false,
          },
          {
            title: 'indiflex second book',
            withdel: true,
          },
        ],
      },
    },
  });

  console.log({ sico, indiflex });
}
```

11. password cryptor module

```bash
pnpm add bcryptjs  
```

```typescript
import { compare, hash } from 'bcryptjs';

const encPasswd = await hash(passwd, 10);

const isValid = await compare(passwd, encPasswd);
```

12. zod
```bash
pnpm add zod
```

13. login & regist (feat. next-auth)
 1) sign with button 및 UI 마무리
```
```

 1) auth.ts
```typescript
  callbacks: {
    async signIn({ user, account, profile }) {
      console.log('🚀 signIn - user:', user, account?.provider, profile);
      if (!user.email) return false;

      const { email } = user;
      const userData = await findUserByEmail(email);
      if (account?.provider === 'credentials') {
        const isValidPassword =
          userData?.passwd &&
          user.password &&
          (await compare(userData.passwd, user.password));

        if (!userData || !isValidPassword) return false;
        user.id = String(userData.id);
        user.name = userData.name;
        user.image = userData.image;
      } else {
        if (!userData) {
          delete user.id;
          const newer = await createUser(user as UserData);
          console.log('🚀 newer:', newer);
          user.id = String(newer.id);
          user.isadmin = newer.isadmin;
        } else {
          user.id = String(userData?.id);
        }
      }

      user.isadmin = userData?.isadmin;
      return true;
    },
    async jwt({ token, user, trigger, session }) {
      // console.log('🚀 trigger:', trigger, session);
      // console.log('🚀 jwt - token:', token, user);
      const userData = trigger === 'update' ? session : user;
      if (userData) {
        token.id = userData.id;
        token.email = userData.email;
        token.name = userData.name;
        token.picture = userData.image;
        token.isadmin = userData.isadmin;
      }
      return token;
    },
    async session({ session, token }) {
      // console.log('🚀 cb - session:', session, token);
      if (token) {
        session.user.id = String(token.id);
        session.user.email = token.email as string;
        session.user.name = token.name;
        session.user.image = token.picture;
        session.user.isadmin = token.isadmin;
      }
      return session;
    },
  },
```

 1) sign.ts (server action)
 1) app/login/page.tsx 작성



sign.ts - logout 개선
```typescript
export const logout = async () => {
  await signOut({ redirectTo: '/' });
};

const loginGithub = async () => {
  login('github', '/bookcase');
};
```

login/error/page.tsx
```tsx
// pages > error: '/login/error',

// 'use client';
// import { useSearchParams } from 'next/navigation';

import { Button } from '@/components/ui/button';
import Link from 'next/link';
import { use } from 'react';

const getErrorMessage = (error: string) => {
  if (error === 'CheckEmail') return '이메일 승인 후 다시 로그인해주세요!';
  return '알 수 없는 오류 발생!';
};

type Props = {
  searchParams: Promise<{ error: string }>;
};

export default function LoginError({ searchParams }: Props) {
  // const searchParams = useSearchParams();
  // const error = searchParams.get('error')!;
  const { error } = use(searchParams);

  return (
    <div className='grid place-items-center h-full'>
      <div className='border p-5 text-center'>
        <h1 className='text-xl mb-5'>{getErrorMessage(error)}</h1>
        <Button variant={'outline'} asChild={true}>
          <Link href='/'>OK</Link>
        </Button>
      </div>
    </div>
  );
}
```

api/sendmail/route.ts
```typescript
import { sendRegistCheck } from '@/actions/mailer';
import { v4 as uuidv4 } from 'uuid';
import { redirect } from 'next/navigation';
import { NextResponse } from 'next/server';
import prisma from '@/lib/db';

export async function POST(req: Request) {
  const { email, emailcheck, oldEmailcheck } = await req.json();

  // resend...
  if (oldEmailcheck) {
    const mbr = await prisma.member.findUnique({ where: { email } });
    if (mbr?.emailcheck !== oldEmailcheck) {
      redirect('/login/error?error=InvalidToken'); // abusing
    }
    const newToken = uuidv4();
    await prisma.member.update({
      data: { emailcheck: newToken },
      where: { email },
    });
    await sendRegistCheck(email, newToken);
  } else {
    const authorization = req.headers.get('authorization');
    if (authorization !== `Bearer ${process.env.INTERNAL_SECRET}`)
      throw new Error('InvalidToken');
    await sendRegistCheck(email, emailcheck);
  }

  return NextResponse.json({ email, message: 'Email Resent.' });
}
```

api.rest
```
@host = http://localhost:3000
@auth_token=AXBXCX

### regist email
POST {{host}}/api/sendmail
Authorization: Bearer {{auth_token}}

{
  "email": "indiflex1@gmail.com",
  "emailcheck": "ABCDFEWFAEAWFEWFAFDFDF"
}
```

lib/validator.ts (for regist)
```typescript
export type ValidError = {
  success: false;
  error: Record<string, { errors: string[] }>;
};
export type ValidSuccess<T = object> = {
  success: true;
  data: T;
};

export const validate = <T extends z.ZodObject>(
  zobj: z.ZodObject,
  formData: FormData
) => {
  const entries = Object.fromEntries(formData.entries());
  const validator = zobj.safeParse(entries);
  if (!validator.success) {
    return {
      error: z.treeifyError(validator.error).properties,
    } as ValidError;
  }

  const data = validator.data;
  return { success: true, data } as ValidSuccess<z.infer<T>>;
};
```

actions/sign.ts
```typescript
export const regist = async (formData: FormData) => {
  const zobj = z
    .object({
      email: z.email(),
      passwd: z.string().min(6),
      passwd2: z.string().min(6),
      nickname: z.string().min(3),
    })
    .refine(({ passwd, passwd2 }) => passwd === passwd2, {
      path: ['passwd2'],
      error: 'Password check is not matching!',
    });
  const validator = validate<typeof zobj>(zobj, formData);
  if (!validator.success) {
    return validator;
  }

  const emailcheck = uuidv4();
  const { passwd2: _passwd2, ...data } = { ...validator.data, emailcheck };
  await prisma.member.create({ data });

  // await sendRegistCheck('indiflex.corp@gmail.com', authKey); // stream error
  const { NEXT_PUBLIC_URL, INTERNAL_SECRET } = process.env;
  await fetch(`${NEXT_PUBLIC_URL}/api/sendmail`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${INTERNAL_SECRET}`,
    },
    body: JSON.stringify({
      email: data.email,
      emailcheck,
    }),
  });
  console.log('Mail has sent.');

  return { success: true, data } as ValidSuccess<typeof data>;
};

// cf. lint에서 _시작 제거
  rules: {
    '@typescript-eslint/no-unused-vars': [
      'error',
      { argsIgnorePattern: '^_', varsIgnorePattern: '^_' },
    ],
  },
```

sign-form.tsx에 <RegistForm>
```typescript
const [validError, register, isPending] = useActionState(
  async (_preError: ValidError | undefined, formData: FormData) => {
    const rs = await regist(formData);
    console.log('🚀 ~ rs:', rs);
    if (!rs.success) return rs;
    redirect(`/login/error?error=CheckEmail&email=${rs.data.email}`);
  },
  undefined
);

const [isTransitioning, startTransition] = useTransition();
const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
  e.preventDefault();
  startTransition(() => {
    register(new FormData(e.currentTarget));
  });
};
```