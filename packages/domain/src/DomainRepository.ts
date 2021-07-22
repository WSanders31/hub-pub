import { Domain } from ".";

export default class DomainRepository {
  public async getDomain(id: string): Promise<Domain> {
    return new Domain();
  }

  public async createDomain(): Promise<Domain> {
    return new Domain();
  }

  public async putDomain(inputDomain: Domain): Promise<Domain> {
    return new Domain();
  }

  public async deleteDomain(inputDomain: Domain): Promise<Domain> {
    return new Domain();
  }
}
