---
to: services/<%= service %>/src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/<%= h.inflection.camelize(h.inflection.singularize(domain))  %>.ts
---

import {
    Attribute,
    AutoGenerateAttribute,
    AUTO_GENERATE_ATTRIBUTE_STRATEGY,
    Entity,
    INDEX_TYPE,
} from '@typedorm/common';

export interface RequiredAttributes {
    name: string;
    status: string;
}

/**
 * @tsoaModel
 */
@Entity({
    name: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME,
    primaryKey: {
        partitionKey: 'ID#{{id}}',
        sortKey: `__EN#${<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME}`,
    },
    indexes: {
        gsi1: {
            partitionKey: `__EN#${<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME}`,
            sortKey: 'STATUS#{{status}}',
            type: INDEX_TYPE.GSI,
        },
    },
})
export default class <%= h.inflection.camelize(h.inflection.singularize(domain)) %> {
    public constructor(requiredAttributes: RequiredAttributes) {
        this.name = requiredAttributes.name;
        this.status = requiredAttributes.status;
    }

    public static ENTITY_NAME = '<%= h.inflection.camelize(h.inflection.singularize(domain)) %>';

    @AutoGenerateAttribute({
        strategy: AUTO_GENERATE_ATTRIBUTE_STRATEGY.UUID4,
    })
    public id?: string;

    @Attribute()
    public name: string;

    @Attribute()
    public status: string;
}
