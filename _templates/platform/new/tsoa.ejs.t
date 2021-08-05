---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/tsoa.json
---
{
  "entryFile": "package.json",
  "noImplicitAdditionalProperties": "throw-on-extras",
  "controllerPathGlobs": ["src/**/*Service.ts"],
  "ignore": ["**/node_modules/**"],
  "spec": {
    "outputDirectory": "tsoa",
    "specVersion": 3,
    "specFileBaseName": "<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>"
  }
}



