module.exports = async ({ options, resolveVariable }) => {
  const stage = await resolveVariable("opt:stage, 'dev'");
  const region = await resolveVariable('opt:region, "us-east-2"');

  // Replace with the hostedZone of your base domain.
  const hostedZone = "Z06486512G46XH4KD3G1A";
  const deploymentBucket = "hub-pub-serverless-deployments";
  // Repalce with your base domain.
  const baseDomain = `sanderless.com`;
  const stageDomain = `${stage}.${baseDomain}`;
  const apiName = `${stage}-hub-api`;
  
  const certificateArnExport = "certificateArn";

  return {
    hostedZone,
    stage,
    region,
    deploymentBucket,
    certificateArnExport,
    apiName,
    baseDomain,
    stageDomain,
  };
};
