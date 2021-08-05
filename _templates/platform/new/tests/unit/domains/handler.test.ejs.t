---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain)) %>/tests/unit/<%= h.changeCase.lower(h.inflection.pluralize(domain)) %>/handler.test.ts
---
/* eslint-disable @typescript-eslint/no-unused-vars */
import * as handler from '../../../src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/handler';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %> from '../../../src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/<%= h.inflection.camelize(h.inflection.singularize(domain)) %>';
import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';
import { <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service } from '../../../src/<%= h.changeCase.lower(h.inflection.pluralize(domain)) %>';

describe('get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>', () => {
    it('should get a <%= h.changeCase.lower(h.inflection.singularize(domain)) %> and return 200', async () => {
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy = jest.spyOn(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service, 'get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>').mockReset();

        const mockResult = new <%= h.inflection.camelize(h.inflection.singularize(domain)) %>({ name: 'testing', status: 'hopefully-passing' });
        <%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy.mockImplementation((id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null> => {
            return Promise.resolve(Object.assign(mockResult, { id }));
        });

        const apiGatewayResult: APIGatewayProxyResult = await handler.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>({
            pathParameters: { id: '1337' },
        } as unknown as APIGatewayEvent);

        const resultBody: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> = JSON.parse(apiGatewayResult.body) as <%= h.inflection.camelize(h.inflection.singularize(domain)) %>;

        expect(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy).toHaveBeenCalled();
        expect(apiGatewayResult).toBeDefined();
        expect(apiGatewayResult.statusCode).toEqual(200);
        expect(resultBody.name).toEqual(mockResult.name);
        expect(resultBody.status).toEqual(mockResult.status);
        expect(resultBody.id).toEqual(mockResult.id);
    });

    it('should not find a <%= h.changeCase.lower(h.inflection.singularize(domain)) %> and return a 404', async () => {
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy = jest.spyOn(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service, 'get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>').mockReset();

        const mockResult = new <%= h.inflection.camelize(h.inflection.singularize(domain)) %>({ name: 'testing', status: 'hopefully-passing' });
        <%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy.mockImplementation((id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null> => {
            return Promise.resolve(null);
        });

        const apiGatewayResult: APIGatewayProxyResult = await handler.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>({
            pathParameters: { id: '1337' },
        } as unknown as APIGatewayEvent);

        const resultBody: string = apiGatewayResult.body;

        expect(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy).toHaveBeenCalled();
        expect(apiGatewayResult).toBeDefined();
        expect(apiGatewayResult.statusCode).toEqual(404);
        expect(resultBody).toEqual('<%= h.inflection.camelize(h.inflection.singularize(domain)) %> not found');
    });

    it('should return a 400 when no id is provided', async () => {
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy = jest.spyOn(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Service, 'get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>').mockReset();

        <%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy.mockImplementation((id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null> => {
            return Promise.resolve(null);
        });

        const apiGatewayResult: APIGatewayProxyResult = await handler.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>({
            pathParameters: {},
        } as unknown as APIGatewayEvent);

        const resultBody: string = apiGatewayResult.body;

        expect(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>ServiceSpy).not.toHaveBeenCalled();
        expect(apiGatewayResult).toBeDefined();
        expect(apiGatewayResult.statusCode).toEqual(400);
        expect(resultBody).toEqual('Attribute id not provided.');
    });
});
