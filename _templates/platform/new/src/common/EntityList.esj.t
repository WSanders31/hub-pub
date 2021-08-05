---
to: services/<%= service %>/src/common/EntityList.ts
---

/**
 * @tsoaModel
 */
export default interface EntityList<T> {
    items: T[];
    cursor?: { [key: string]: string } | null;
}
