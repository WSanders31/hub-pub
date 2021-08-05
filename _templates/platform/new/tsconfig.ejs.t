---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/tsconfig.json
---
{
    "extends": "@tsconfig/node14/tsconfig.json",
    "compilerOptions": {
        "emitDecoratorMetadata": true,
        "experimentalDecorators": true,
        "outDir": "./dist",
        "sourceMap": true
    },
    "include": ["src/**/*", "tests/**/*"]
}



