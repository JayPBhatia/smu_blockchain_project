pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Organization.sol";
import "./OrganizationVoucher.sol";

contract Market {

    Organization orgContract;  //reference to OrganizationVoucher
    OrganizationVoucher orgVoucherContract;  //reference to OrganizationVoucher

    uint256 public commissionFee;
    address _owner = msg.sender;
    mapping(uint256 => uint256) listedOrgs;

    constructor(Organization orgAddress, OrganizationVoucher orgVoucherAddress, uint256 fee) public {
        orgContract = orgAddress;
        orgVoucherContract = orgVoucherAddress;
        commissionFee = fee;
    }


    //Lists the vouchers from organization on the marketplace
    function listOrganization(uint256 orgId, uint256 tokens) public {
        require(orgContract.getOrgOwner(orgId) == msg.sender, "Only owner can list");
        orgVoucherContract.transferFrom(msg.sender, address(this), tokens);
        listedOrgs[orgId] = tokens;
    }

    function addTokens(uint256 orgId, uint256 tokens) public {
        require(orgContract.getOrgOwner(orgId) == msg.sender, "Only owner can list");
        orgVoucherContract.transferFrom(msg.sender, address(this), tokens);
        listedOrgs[orgId] = tokens + listedOrgs[orgId] ;
    }

    //Buy Vouchers from a listed organization
    function buyVouchers(uint256 orgId, uint256 price, uint256 tokens) public {
        require(listedOrgs[orgId] != 0, "Organization is not listed");
        //is listed

        // Probably need to keep a record of which organization has which vouchers
        //Write logic to transfer tokens from organization to buyer

        // require(price >= (listedOrgs[orgId]+ commissionFee), "Price is too low");
        //  listPrice[diceId] = 0;
        //  require(token.transferFrom(msg.sender, _owner, commissionFee), "D1");
        //  require(token.transferFrom(msg.sender, prevOwner[diceId], (price - commissionFee)), "D2");
        //  diceContract.transferFrom(address(this), msg.sender, diceId);
    }

    //get owner of DiceMarket
    function getContractOwner() public view returns (address) {
        return _owner;
    }
}
