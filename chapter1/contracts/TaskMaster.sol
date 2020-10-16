pragma solidity ^0.4.17;

contract TaskMaster {
    mapping(address => uint256) public balances; // balances of everyone
    address public owner; // owner of the contract

    function TaskMaster() public {
        owner = msg.sender;
        balances[msg.sender] = 10000;
    }

    function reward(address doer, uint256 rewardAmount)
        public
        isOwner()
        hasSufficientFunds(rewardAmount)
        returns (bool sufficientFunds)
    {
        balances[msg.sender] -= rewardAmount;
        balances[doer] += rewardAmount;
        return sufficientFunds;
    }

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    modifier hasSufficientFunds(uint256 rewardAmount) {
        require(balances[msg.sender] >= rewardAmount);
        _;
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }
}
