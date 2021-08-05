---
to: services/<%= service %>/src/<%= h.changeCase.lower(h.inflection.pluralize(domain))  %>/<%= h.inflection.camelize(h.inflection.singularize(domain))  %>Service.ts
---
import { Route, Get, Tags, Patch, Body, Delete, Path, Post, Query } from '@tsoa/runtime';
import EntityList from '../common/EntityList';
import <%= h.inflection.camelize(h.inflection.singularize(domain)) %> from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>';
import { I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository } from './<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository';

export interface I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Service {
    get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>s(status?: string): Promise<EntityList<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>>>;
    get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null>;
    create<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>>;
    update<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string, request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null>;
    delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string): Promise<boolean>;
}

@Route('<%= h.changeCase.lower(h.inflection.pluralize(domain)) %>')
@Tags('<%= h.changeCase.lower(h.inflection.pluralize(domain)) %>')
export default class <%= h.inflection.camelize(h.inflection.singularize(domain)) %>Service implements I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Service {
    public <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository: I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository;

    public constructor(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository: I<%= h.inflection.camelize(h.inflection.singularize(domain)) %>Repository) {
        this.<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository = <%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository;
    }

    @Get()
    public async get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>s(@Query() status?: string): Promise<EntityList<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>>> {
        return this.<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>s(status);
    }

    @Get('{id}')
    public async get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(@Path() id: string): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null> {
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> | undefined = await this.<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository.get<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id);

        if (!<%= h.changeCase.lower(h.inflection.singularize(domain)) %>) {
            return null;
        }

        return <%= h.changeCase.lower(h.inflection.singularize(domain)) %>;
    }

    @Post()
    public async create<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(@Body() request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %>> {
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> = Object.assign(
            new <%= h.inflection.camelize(h.inflection.singularize(domain)) %>({
                name: request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.name,
                status: request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.status,
            }),
        );

        return this.<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository.create<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(<%= h.changeCase.lower(h.inflection.singularize(domain)) %>);
    }

    @Patch('{id}')
    public async update<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id: string, @Body() request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %>): Promise<<%= h.inflection.camelize(h.inflection.singularize(domain)) %> | null> {
        // Remove any attributes that might effect keys.
        delete request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>.id;
        const <%= h.changeCase.lower(h.inflection.singularize(domain)) %>: <%= h.inflection.camelize(h.inflection.singularize(domain)) %> | undefined = await this.<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository.update<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id, request<%= h.inflection.camelize(h.inflection.singularize(domain)) %>);

        return <%= h.changeCase.lower(h.inflection.singularize(domain)) %> || null;
    }

    @Delete('{id}')
    public async delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(@Path() id: string): Promise<boolean> {
        return this.<%= h.changeCase.lower(h.inflection.singularize(domain)) %>Repository.delete<%= h.inflection.camelize(h.inflection.singularize(domain)) %>(id);
    }
}
