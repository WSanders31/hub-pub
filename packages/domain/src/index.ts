import DomainService from "./DomainService";
import DomainRepository from "./DomainRepository";
import Domain from "./Domain";

// Instantiate singleton classes.
const domainService: DomainService = new DomainService();
const domainRepository: DomainRepository = new DomainRepository();

// Expose
export {
  Domain,
  domainService,
  DomainService,
  domainRepository,
  DomainRepository,
};
