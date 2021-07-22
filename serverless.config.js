module.exports = async ({ options, resolveVariable }) => {
    const hostedZone = 'yourHostedZoneId';
    const stage = await resolveVariable('opt:stage');
    const region = await resolveVariable('opt:region, "us-east-2"');
    const deploymentBucket = 'hub-pub-serverless-deployments';
    const certificateArn = 'certificateArn';
    const baseDomain = `yourDomainHere.com`;
    const stageDomain = `${stage}.${baseDomain}`;
    const apiName = `${stage}-hub-api`;
  
    return {
      hostedZone,
      stage,
      region,
      deploymentBucket,
      certificateArn,
      apiName,
      baseDomain,
      stageDomain,
    }
  }