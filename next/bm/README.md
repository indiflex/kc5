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
1. setup

```bash
pnpm dlx create-next-app@latest bm
```

```bash
cd bm
```

```bash
pnpm add -D prettier eslint-config-prettier 
```

```bash
pnpm add -D @trivago/prettier-plugin-sort-imports
```

2. vi .prettierrc

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

1. vi eslint.config.mjs
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
1. vi .nvmrc
```v22```
1. vi .npmrc
```
public-hoist-pattern[]=*eslint*
```
1. pnpm install
1. pnpm dlx shadcn@latest init
1. 


## Deploy on Vercel

