pragma solidity ^0.5.10;

contract test {
    address payable owner;

    modifier onlyOwner {
        require(
            msg.sender == owner,
            "Only owner can call this function."
        );
        _;
    }

    uint256[100] data;

    constructor() public {
        owner = msg.sender;
        data = [1];
    }

    function Put(uint256 addr, uint256 value) public {
        data[addr] = value;
    }

    function close() public onlyOwner { //onlyOwner is custom modifier
        selfdestruct(owner);  // `owner` is the owners address
    }
}