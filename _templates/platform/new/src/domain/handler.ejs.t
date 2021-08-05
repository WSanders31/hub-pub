---
to: services/<%= service %>/src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/handler.ts
---
import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %> from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>';
import { <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service } from '.';
import EntityList from '../common/EntityList';

export async function get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('get<%= h.inflection.camelize(h.inflection.singularize(domain)) %> recieved event', event);

    const id: string | undefined = event.pathParameters?.id;
    if (id) {
        const domain: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null = await <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id);

        if (domain) {
            return {
                statusCode: 200,
                body: JSON.stringify(domain),
            };
        } else {
            return { statusCode: 404, body: '<%= h.inflection.camelize(h.inflection.singularize(domain)) %> not found' };
        }
    }
    return {
        statusCode: 400,
        body: 'Attribute id not provided.',
    };
}

export async function get<%= h.inflection.camelize(h.changeCase.lower(h.inflection.pluralize(domain))) %>(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('get<%= h.inflection.camelize(h.changeCase.lower(h.inflection.pluralize(domain))) %> recieved event', event);

    const status: string | undefined = event.queryStringParameters?.status;
    const <%= h.changeCase.lower(h.inflection.pluralize(domain)) %>: EntityList<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>> = await <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service.get<%= h.inflection.camelize(h.changeCase.lower(h.inflection.pluralize(domain))) %>(status);

    return {
        statusCode: 200,
        body: JSON.stringify(<%= h.changeCase.lower(h.inflection.pluralize(domain)) %>),
    };
}

export async function post<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('create<%= h.inflection.camelize(h.inflection.singularize(domain)) %> recieved event', event);

    if (event.body) {
        const request = JSON.parse(event.body) as <%= h.inflection.camelize(h.inflection.singularize(domain)) %>;

        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> = await <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service.create<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(request);

        return {
            statusCode: 201,
            body: JSON.stringify(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>),
        };
    } else {
        return {
            statusCode: 400,
            body: '<%= h.changeCase.lower(h.inflection.singularize(domain)) %> not provided.',
        };
    }
}

export async function patch<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('patch<%= h.inflection.camelize(h.inflection.singularize(domain)) %> recieved event', event);

    if (event.body && event.pathParameters?.id) {
        const request = JSON.parse(event.body) as <%= h.inflection.camelize(h.inflection.singularize(domain)) %>;
        const id = event.pathParameters?.id;
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null = await <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service.update<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id, request);

        return {
            statusCode: 200,
            body: JSON.stringify(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>),
        };
    }

    return {
        statusCode: 400,
        body: '<%= h.inflection.camelize(h.inflection.singularize(domain)) %> and/or id not provided.',
    };
}

export async function delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %> recieved event', event);

    const id = event.pathParameters?.id;
    if (id) {
        const deleted: boolean = await <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service.delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id);

        if (deleted) {
            return {
                statusCode: 204,
                body: 'No Content.',
            };
        } else {
            return {
                statusCode: 404,
                body: '<%= h.changeCase.lower(h.inflection.singularize(domain)) %> by id not found.',
            };
        }
    }

    return {
        statusCode: 400,
        body: 'Attribute id not provided.',
    };
}
