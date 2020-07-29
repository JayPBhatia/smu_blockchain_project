pragma solidity ^0.5.0;

contract Organization {


 enum orgState { verified, invalid }

     struct organization {
        uint8 numberOfTokens;
        string name;
        orgState isVerified;
        uint256 creationDate;
    }

    uint256 public tokenCount;

    uint256 public numOrgs = 0;

    mapping(uint256 => organization) public organizations;

   function addTokens(uint256 x) public {
        // only the orgnization owner should be able to add token
        // ntuc  says that they want 1000 token in mkt
        tokenCount += x;
    }

    function issueTokens(uint256 x) public payable {
        // ntuc token issues to public
        // transfer of ownership of token
    }

    function burnTokens(uint256 x ) public {
        // public gives back to ntuc for service / products
        tokenCount -= x;
    }

      //function to create a new Orgnization, and add to 'organizations' map. requires at least 0.01ETH to create
    function add(
        uint8 numberOfTokens,
        string memory name
    ) public payable returns(uint256) {
        require(numberOfTokens > 0, "Tokens cannot be less than 1");
       // require(msg.value > 0.01 ether, "Require a value of > 0.01 to create organization");

        //new organization object
        organization memory newOrg = organization(
            numberOfTokens,
            name,
            orgState.invalid,
            block.timestamp            
        );

        uint256 newOrgId = numOrgs++;
        organizations[newOrgId] = newOrg;   //commit to state variable
        return newOrgId;             //return new OrgId
    }

    //modifier to ensure a function is callable only by its owner
    modifier ownerOnly(uint256 orgId) {
        //require(ownerOf(orgId) == msg.sender, "Owner only function");
        _;
    }

    modifier validOrgId(uint256 orgId) {
        require(orgId < numOrgs, "Invalid organization Id");
        //require(organizations[orgId].isValidated==orgState.verified, "Organization is not verified");
        _;
    }

    //get organization name
    function getOrgName(uint256 orgId) public view validOrgId(orgId) returns (string memory) {
        return organizations[orgId].name;
    }

     //get number of tokens with organization
    function getOrgTokens(uint256 orgId) public view validOrgId(orgId) returns (uint8) {
        return organizations[orgId].numberOfTokens;
    }

    // set the isVerified flag of organization
    function approve(uint orgId) public  validOrgId(orgId){
        organizations[orgId].isVerified= orgState.verified;
    }

}
