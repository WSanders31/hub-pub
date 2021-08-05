---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/package.json
---
{
    "name": "<%= h.changeCase.lower(h.inflection.singularize(domain))  %>",
    "version": "1.0.0",
    "description": "<%= h.inflection.camelize(h.inflection.singularize(domain)) %> API",
    "main": "index.ts",
    "author": "<%= author %>",
    "license": "ISC",
    "devDependencies": {
        "@openapitools/openapi-generator-cli": "^2.3.9",
        "@tsoa/cli": "^3.9.0",
        "@types/aws-lambda": "^8.10.79",
        "@types/jest": "^26.0.24",
        "@types/node": "^16.3.3",
        "@types/uuid": "^8.3.1",
        "@typescript-eslint/eslint-plugin": "^4.29.0",
        "@typescript-eslint/parser": "^4.29.0",
        "aws-sdk": "^2.955.0",
        "eslint": "^7.32.0",
        "eslint-config-prettier": "^8.3.0",
        "eslint-config-standard": "^16.0.3",
        "eslint-plugin-import": "^2.23.4",
        "eslint-plugin-node": "^11.1.0",
        "eslint-plugin-prettier": "^3.4.0",
        "eslint-plugin-promise": "^5.1.0",
        "jest": "^27.0.6",
        "lint-staged": "^11.1.1",
        "prettier": "^2.3.2",
        "serverless": "^2.52.0",
        "ts-jest": "^27.0.4",
        "ts-node": "^10.1.0",
        "typescript": "^4.3.5"
    },
    "dependencies": {
        "@tsoa/runtime": "^3.9.0",
        "@typedorm/common": "^1.14.3",
        "@typedorm/core": "^1.14.3",
        "reflect-metadata": "^0.1.13"
    }
}



