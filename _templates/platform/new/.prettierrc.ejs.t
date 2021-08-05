---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/.prettierrc.js
---
module.exports = {
  semi: true,
  trailingComma: "all",
  singleQuote: true,
  printWidth: 120,
  tabWidth: 4
};


