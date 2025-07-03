module.exports = {
  preset: 'ts-jest',
  testMatch: ['**/*.test.ts'],
  reporters: [
    'default',
    [
      './node_modules/jest-html-reporter',
      {
        pageTitle: 'Jest Test Report',
        includeFailureMsg: true,
        includeConsoleLog: true,
        sort: 'titleAsc',
      },
    ],
  ],
};

// const { createDefaultPreset } = require("ts-jest");

// const tsJestTransformCfg = createDefaultPreset().transform;

// /** @type {import("jest").Config} **/
// module.exports = {
//   testEnvironment: "node",
//   transform: {
//     ...tsJestTransformCfg,
//   },
// };
