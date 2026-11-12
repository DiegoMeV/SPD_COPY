module.exports = {
  root: true,
  ignores: [
    "node_modules",
    "dist",
    "jest.config.js",
    "fixtures",
    "shared-fixtures",
    "coverage",
    "__snapshots__",
    ".docusaurus",
    "build",
  ],
  env: {
    browser: true,
    es6: true,
    jest: true,
    node: true,
    mocha: true,
    jquery: true,
  },
  globals: {
    BigInt: true,
    browser: true,
    cy: true, // for cy unit test
    NodeJS: true,
  },
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: 2018,
    sourceType: "module",
    ecmaFeatures: {
      jsx: true,
    },
  },
  settings: {
    "import/resolver": {
      typescript: {
        project: ["tsconfig.json"],
      },
    },
    react: {
      version: "18.0",
    },
  },
  extends: [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "plugin:react/recommended",
    "prettier",
  ],
  plugins: ["@typescript-eslint", "react", "import", "react-hooks"],
  rules: {
    "no-console": ["warn", { allow: ["warn", "error"] }],
    "no-var": "error",
    "prefer-const": "error",
    "no-unused-vars": "off",
    "react/prop-types": "off",
    "react/no-unescaped-entities": ["error", { forbid: [">", "}"] }],
    "@typescript-eslint/no-unused-vars": ["warn", { args: "none", varsIgnorePattern: "^_" }],
    "react/jsx-uses-react": "error",
    "react/jsx-uses-vars": "error",
    "react/display-name": "off",
    "react-hooks/exhaustive-deps": "warn",
    "react-hooks/rules-of-hooks": "error",
    "import/no-unresolved": ["error", { ignore: ["^next$", "^webpack$", "^gestalt$"] }],
    // Disable no-redeclare since it reports false negatives for TypeScript when you do
    // function overloads or declaration merging. We use @typescript-eslint/no-redeclare instead.
    "no-redeclare": "off",
    "@typescript-eslint/no-redeclare": ["error"],
    "@typescript-eslint/no-explicit-any": "warn",
  },
};
