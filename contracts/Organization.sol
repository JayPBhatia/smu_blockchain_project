pragma solidity ^0.5.0;
import "./OrganizationVoucher.sol";

contract Organization {

    OrganizationVoucher orgVoucherContract;  //reference to OrganizationVoucher
    constructor( OrganizationVoucher orgVoucherAddress) public {
        orgVoucherContract = orgVoucherAddress;
    }

    enum orgState {verified, invalid}

    struct organization {
        string name;
        string symbol;
        uint256 price;
        address payable owner;
        uint256 numberOfVouchers;
        orgState isVerified;
        uint256 creationDate;
    }

    uint256 public numOrgs = 0;

    mapping(uint256 => organization) public organizations;

    //modifier to ensure a function is callable only by its owner
    modifier ownerOnly(uint256 orgId) {
        require(orgId < numOrgs, "Invalid organization Id");
        require(organizations[orgId].owner == msg.sender, "Owner only function");
        _;
    }

    modifier validOrgId(uint256 orgId) {
        require(orgId < numOrgs, "Invalid organization Id");
        require(organizations[orgId].isVerified==orgState.verified, "Organization is not verified");
        _;
    }

    function addVouchers(uint256 orgId, uint256 x) public ownerOnly(orgId)  {
        organizations[orgId].numberOfVouchers  += x;
        // TODO call voucher add
    }

    function burnVouchers(uint256 orgId, uint256 x) public ownerOnly(orgId) {
        organizations[orgId].numberOfVouchers  -= x;
        // TODO call voucher burn
    }

    function issueTokens(uint256 orgId, uint256 x) public ownerOnly(orgId) payable {
        // ntuc token issues to public
        // transfer of ownership of token
    }

    //function to create a new Orgnization, and add to 'organizations' map. requires at least 0.01ETH to create
    function add(
        uint8 numberOfVouchers,
        string memory name,
        string memory symbol,
        uint256 price
    ) public payable returns (uint256) {
        require(numberOfVouchers > 0, "Vouchers cannot be less than 1");
        // require(msg.value > 0.01 ether, "Require a value of > 0.01 to create organization");

        //new organization object
        organization memory newOrg = organization(
            name,
            symbol,
            price,
            tx.origin,
            numberOfVouchers,
            orgState.invalid,
            block.timestamp
        );

//       voucher memory newOrgVoucher = orgVoucherContract.addVouchers(
//            name,
//            symbol,
//            price,
//            numberOfVouchers
//        );

        // mint
        uint256 newOrgId = numOrgs++;
        organizations[newOrgId] = newOrg;
        return newOrgId;
    }

    //get organization name
    function getOrgName(uint256 orgId) public view validOrgId(orgId) returns (string memory) {
        return organizations[orgId].name;
    }

    //get number of tokens with organization
    function getOrgVouchers(uint256 orgId) public view validOrgId(orgId) returns (uint256) {
        return organizations[orgId].numberOfVouchers;
    }

    // set the isVerified flag of organization
    function approve(uint256 orgId) public ownerOnly(orgId) {
        organizations[orgId].isVerified = orgState.verified;
    }

    //get organization Owner
    function getOrgOwner(uint256 orgId) public view validOrgId(orgId) returns (address payable) {
        return organizations[orgId].owner;
    }

    function getVoucherPrice(uint256 orgId) public view validOrgId(orgId) returns (uint256) {
        return organizations[orgId].price;
    }

}
