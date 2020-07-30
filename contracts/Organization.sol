pragma solidity ^0.5.0;

contract Organization {

    enum orgState {verified, invalid}

    struct organization {
        string name;
        address owner;
        uint256 numberOfTokens;
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

    function addTokens(uint256 orgId, uint256 x) public ownerOnly(orgId)  {
        organizations[orgId].numberOfTokens  += x;
    }

    function burnTokens(uint256 orgId, uint256 x) public ownerOnly(orgId) {
        organizations[orgId].numberOfTokens  -= x;
    }

    function issueTokens(uint256 orgId, uint256 x) public ownerOnly(orgId) payable {
        // ntuc token issues to public
        // transfer of ownership of token
    }

    //function to create a new Orgnization, and add to 'organizations' map. requires at least 0.01ETH to create
    function add(
        uint8 numberOfTokens,
        string memory name
    ) public payable returns (uint256) {
        require(numberOfTokens > 0, "Tokens cannot be less than 1");
        // require(msg.value > 0.01 ether, "Require a value of > 0.01 to create organization");

        //new organization object
        organization memory newOrg = organization(
            name,
            tx.origin,
            numberOfTokens,
            orgState.invalid,
            block.timestamp
        );

        uint256 newOrgId = numOrgs++;
        organizations[newOrgId] = newOrg;
        return newOrgId;
    }

    //get organization name
    function getOrgName(uint256 orgId) public view validOrgId(orgId) returns (string memory) {
        return organizations[orgId].name;
    }

    //get number of tokens with organization
    function getOrgTokens(uint256 orgId) public view validOrgId(orgId) returns (uint256) {
        return organizations[orgId].numberOfTokens;
    }

    // set the isVerified flag of organization
    function approve(uint256 orgId) public validOrgId(orgId) {
        organizations[orgId].isVerified = orgState.verified;
    }

    //get organization Owner
    function getOrgOwner(uint256 orgId) public view validOrgId(orgId) returns (address) {
        return organizations[orgId].owner;
    }

}
