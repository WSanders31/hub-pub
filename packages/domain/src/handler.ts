import { APIGatewayEvent, APIGatewayProxyResult } from 'aws-lambda';
import { domainService } from '.';
import Domain from './Domain';

export async function getDomain(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('getDomain Received event!', event);

    const id = event.pathParameters?.id;
    if (id) {
        const domain: Domain | undefined = await domainService.getDomain(id);

        return {
            statusCode: 200,
            body: JSON.stringify(domain),
        };
    }
    return {
        statusCode: 400,
        body: 'Attribute id not provided.',
    };
}

export async function createDomain(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('createDomain Received event', event);

    const domain: Domain = await domainService.createDomain();

    return {
        statusCode: 200,
        body: JSON.stringify(domain),
    };
}

export async function patchDomain(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('patchDomain Received event', event);

    if (event.body) {
        const domain: Domain = await domainService.putDomain(JSON.parse(event.body) as Domain);

        return {
            statusCode: 200,
            body: JSON.stringify(domain),
        };
    }

    return {
        statusCode: 400,
        body: 'Body not provided.',
    };
}

export async function deleteDomain(event: APIGatewayEvent): Promise<APIGatewayProxyResult> {
    console.log('deleteDomain Received event', event);

    const id = event.pathParameters?.id;
    if (id) {
        const domain: Domain | undefined = await domainService.deleteDomain(id);

        if (domain) {
            return {
                statusCode: 204,
                body: JSON.stringify(domain),
            };
        } else {
            return {
                statusCode: 404,
                body: 'Domain by id not found.',
            };
        }
    }

    return {
        statusCode: 400,
        body: 'Attribute id not provided.',
    };
}
