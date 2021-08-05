---
to: services/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/serverless.yml
---
# domain
service: ${self:custom.domain}

# New variable resolver
variablesResolutionMode: 20210326

projectDir: ../..

custom:
    # API Domain name
    domain: <%= h.changeCase.lower(h.inflection.pluralize(domain))  %>
    dynamodb: ${self:provider.stage}-${self:custom.domain}-dynamodb
    handlerPath: ./dist/src/${self:custom.domain}

provider:
    name: aws
    runtime: nodejs14.x
    stage: ${file(../../serverless.config.js):stage}
    region: ${file(../../serverless.config.js):region}
    deploymentBucket: ${file(../../serverless.config.js):deploymentBucket}
    versionFunctions: false
    logRetentionInDays: 7

    # NodeJS environment variables
    environment:
        AWS_NODEJS_CONNECTION_REUSE_ENABLED: 1 # Reuse DynamoDB TCP connection
        DYNAMODB: ${self:custom.dynamodb}
        STAGE: ${self:provider.stage}
        REGION: ${self:provider.region}
        NODE_OPTIONS: '--enable-source-maps'
        DEBUG: typedorm:*

    iam:
        role:
            statements:
                - Effect: 'Allow'
                  Action:
                      - 'dynamodb:*'
                  Resource: !GetAtt DynamoDB.Arn
                - Effect: 'Allow'
                  Action:
                      - 'dynamodb:*'
                  Resource: !Join ['/', [!GetAtt DynamoDB.Arn, 'index/*']]

    # Shared API Gateway - using exported api name to make cross-stack reference
    httpApi:
        id: !ImportValue ${file(../../serverless.config.js):apiName}

package:
    individually: true
    patterns:
        - '!./serverless/**'
        - '!./src/**'
        - '!./tests/**'
        - '!./tsoa/**'
        - '!./.eslintrc.js'
        - '!./.gitignore'
        - '!./.nvmrc'
        - '!./.prettierrc.js'
        - '!./jest.config.js'
        - '!./openapitools.json'
        - '!./package-lock.json'
        - '!./package.json'
        - '!./README.md'
        - '!./serverless.yml'
        - '!./tsconfig.eslint.json'
        - '!./tsconfig.json'
        - '!./tsoa.json'
        - '!./webpack.config.js'
        - '!./dist/tests/**'
        - './dist/src/**'

# Lambda functions
functions:
    get:
        handler: ${self:custom.handlerPath}/handler.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>
        events:
            - httpApi:
                  path: /${self:custom.domain}/{id}
                  method: GET
    list:
        handler: ${self:custom.handlerPath}/handler.get<%= h.inflection.camelize(h.changeCase.lower(h.inflection.pluralize(domain))) %>
        events:
            - httpApi:
                  path: /${self:custom.domain}
                  method: GET
    post:
        handler: ${self:custom.handlerPath}/handler.post<%= h.inflection.camelize(h.inflection.singularize(domain)) %>
        events:
            - httpApi:
                  path: /${self:custom.domain}
                  method: POST
    patch:
        handler: ${self:custom.handlerPath}/handler.patch<%= h.inflection.camelize(h.inflection.singularize(domain)) %>
        events:
            - httpApi:
                  path: /${self:custom.domain}/{id}
                  method: PATCH
    delete:
        handler: ${self:custom.handlerPath}/handler.delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>
        events:
            - httpApi:
                  path: /${self:custom.domain}/{id}
                  method: DELETE

resources:
    Resources:
        DynamoDB:
            Type: AWS::DynamoDB::Table
            Properties:
                TableName: ${self:custom.dynamodb}
                BillingMode: PAY_PER_REQUEST
                AttributeDefinitions:
                    - AttributeName: pk
                      AttributeType: S
                    - AttributeName: sk
                      AttributeType: S
                    - AttributeName: gsi1pk
                      AttributeType: S
                    - AttributeName: gsi1sk
                      AttributeType: S
                KeySchema:
                    - AttributeName: pk
                      KeyType: HASH
                    - AttributeName: sk
                      KeyType: RANGE
                GlobalSecondaryIndexes:
                    - IndexName: gsi1
                      KeySchema:
                          - AttributeName: gsi1pk
                            KeyType: HASH
                          - AttributeName: gsi1sk
                            KeyType: RANGE
                      Projection:
                          ProjectionType: ALL
                PointInTimeRecoverySpecification:
                    PointInTimeRecoveryEnabled: true



