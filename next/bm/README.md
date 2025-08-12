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


## Deploy

