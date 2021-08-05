---
to: services/<%= service %>/src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/<%= h.inflection.camelize(h.inflection.singularize(domain))  %>Repository.ts
---
import { Connection, EntityManager } from '@typedorm/core/public-api';
import EntityList from '../common/EntityList';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %> from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>';

export interface I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository {
    get<%= h.inflection.camelize(h.changeCase.lower(h.inflection.pluralize(domain))) %>(status?: string): Promise<EntityList<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>>>;
    get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | undefined>;
    create<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(domain: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>>;
    update<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string, domain: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | undefined>;
    delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string): Promise<boolean>;
}

export default class <%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository implements I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository {
    public connection: Connection;
    public entityManager: EntityManager;
    public constructor(connection: Connection, entityManager: EntityManager) {
        this.connection = connection;
        this.entityManager = entityManager;
    }

    public async get<%= h.inflection.camelize(h.changeCase.lower(h.inflection.pluralize(domain))) %>(status?: string): Promise<EntityList<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>>> {
        return this.entityManager.find(
            <%= h.inflection.camelize(h.inflection.singularize(domain)) %>,
            { pk: `__EN#${<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME}` },
            {
                queryIndex: 'gsi1',
                ...(status && { keyCondition: { EQ: `STATUS#${status}` } }),
            },
        );
    }

    public async get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | undefined> {
        return this.entityManager.findOne(<%= h.inflection.camelize(h.inflection.singularize(domain)) %>, { id, sk: `__EN#${<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME}` });
    }

    public async create<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>> {
        return this.entityManager.create(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>);
    }

    public async update<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string, <%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | undefined> {
        return this.entityManager.update(<%= h.inflection.camelize(h.inflection.singularize(domain)) %>, { id, sk: `__EN#${<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME}` }, <%= h.changeCase.lower(h.inflection.singularize(domain)) %>);
    }

    public async delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string): Promise<boolean> {
        return (await this.entityManager.delete(<%= h.inflection.camelize(h.inflection.singularize(domain)) %>, { id, sk: `__EN#${<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.ENTITY_NAME}` })).success;
    }
}
