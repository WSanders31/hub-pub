---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/tsconfig.eslint.json
---
{
  "extends": "./tsconfig.json",
  "include": [
    ".eslintrc.js", // ESLint's config must be included
    ".",
  ],
}


