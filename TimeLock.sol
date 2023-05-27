// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract TimeLock {
    address owner;
    uint256 public lockTime = 1 minutes;
    uint256 startTime;

    modifier onlyBy(address _account) {
        require(msg.sender == _account, "Not authorized");
        _;
    }

    receive() external payable {}

    constructor() {
        owner = msg.sender;
        startTime = block.timestamp;
    }

    function withdraw() public onlyBy(owner) {
        require((startTime + lockTime) < block.timestamp, "Lock time not passed");
        payable(owner).transfer(address(this).balance);
    }
}
