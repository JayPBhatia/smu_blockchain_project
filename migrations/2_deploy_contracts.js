const Organization = artifacts.require("Organization");
const OrganizationVoucher = artifacts.require("OrganizationVoucher");
const MarketPlace = artifacts.require("Market");
const SimpleStorage = artifacts.require("SimpleStorage");




module.exports = function(deployer, networks, accounts) {
  let platform = accounts[0];
  let orgInstance;
  let orgVoucher;
  let fee = 100;

  deployer.deploy(OrganizationVoucher, "NTUC" , "NTUC$", 1, 100).then((_inst) => {
    orgVoucher = _inst;
    return deployer.deploy(Organization, orgVoucher.address)
  }).then((_inst) => {
    orgInstance = _inst;
    return deployer.deploy(MarketPlace, orgInstance.address, orgVoucher.address, fee, {from: platform});
  })

  deployer.deploy(SimpleStorage);
};
