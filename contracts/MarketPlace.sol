pragma solidity ^0.5.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Organization.sol";
import "./OrganizationVoucher.sol";

contract Market {

    OrganizationVoucher orgVoucherContract;  //reference to Dice.sol
    IERC20 token;       //reference to OrgToken.sol or any ERC20
    uint256 public commissionFee;
    address _owner = msg.sender;
    mapping(uint256 => uint256) listedOrgs;
    //mapping(uint256 => address) prevOwner;

    constructor(OrganizationVoucher orgAddress, IERC20 ercAddress ,uint256 fee) public {
        orgVoucherContract = orgAddress;
        token = ercAddress;
        //Not sure if we need the commissionFee
        commissionFee = fee;
    }

   
    //Lists the vouchers from organization on the marketplace
    function listVouchers(uint256 orgId, uint256 tokens) public {
      //require(orgVoucherContract.ownerOf(orgId) == msg.sender, "Only owner can list");
        orgVoucherContract.transferFrom(msg.sender, address(this), orgId);
     // prevOwner[diceId] = msg.sender;
      listedOrgs[orgId] = tokens;
    }

     //Buy Vouchers from a listed organization 
    function buyVouchers(uint256 orgId, uint256 price, uint256 tokens) public {
       require(listedOrgs[orgId]!= 0, "Organization is not listed"); //is listed
       
       // Probably need to keep a record of which organization has which vouchers    
       //Write logic to transfer tokens from organization to buyer   

      // require(price >= (listedOrgs[orgId]+ commissionFee), "Price is too low");
      //  listPrice[diceId] = 0;
      //  require(token.transferFrom(msg.sender, _owner, commissionFee), "D1");
      //  require(token.transferFrom(msg.sender, prevOwner[diceId], (price - commissionFee)), "D2");
      //  diceContract.transferFrom(address(this), msg.sender, diceId);
    }

    //get owner of DiceMarket
    function getContractOwner() public view returns(address) {
       return _owner;
    }
}
