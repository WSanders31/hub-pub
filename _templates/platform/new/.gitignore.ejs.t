---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/.gitignore
---
.serverless
dist
node_modules
tsoa
openapitools.json
.openapi-generator
client

