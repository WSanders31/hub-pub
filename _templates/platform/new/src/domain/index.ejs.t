---
to: services/<%= service %>/src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/index.ts
---
import 'reflect-metadata';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %>Service from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Service';
import { Connection, createConnection, getConnection } from '@typedorm/core';
import dynamodbTable from '../common/DynamoDB';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %> from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>';

// TypedORM requires creating a connection and establishing an entity manager.
let connection: Connection;
try {
    connection = createConnection({
        table: dynamodbTable, // Table definition
        entities: [<%= h.inflection.camelize(h.inflection.singularize(domain)) %>], // Must register data models at runtime. Glob pattern not working.
    });
} catch (e) {
    console.log('Error creating connection, attempting to get active connection. Error -->', e);
    connection = getConnection(); // Error creating connection, attempting to fetch default.
}

const entityManager = connection.entityManager;
const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository = new <%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository(connection, entityManager);
const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service = new <%= h.inflection.camelize(h.inflection.singularize(domain)) %>Service(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository);

export { connection, entityManager, <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service, <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository };
