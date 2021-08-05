---
to: services/<%= service %>/src/common/DynamoDB.ts
---
import { INDEX_TYPE } from '@typedorm/common/src/enums';
import { Table } from '@typedorm/common/src/table';

const dynamodbTable = new Table({
    name: process.env.DYNAMODB || 'DYNAMODB_TABLE_NOT_DEFINED',
    partitionKey: 'pk',
    sortKey: 'sk',
    indexes: {
        gsi1: {
            type: INDEX_TYPE.GSI,
            partitionKey: 'gsi1pk',
            sortKey: 'gsi1sk',
        },
    },
});

export default dynamodbTable;



