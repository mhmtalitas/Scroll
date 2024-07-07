
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayPool {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct DepositRecord {
        address depositor;
        uint256 amount;
        uint256 timestamp;
        DepositStatus status;
    }

    enum DepositStatus {
        Pending,
        Approved,
        Rejected
    }

    DepositRecord[] public depositHistory;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");

        DepositRecord memory newRecord = DepositRecord({
            depositor: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp,
            status: DepositStatus.Pending
        });

        depositHistory.push(newRecord);
    }

    function approveDeposit(uint256 index) public onlyOwner {
        require(index < depositHistory.length, "Invalid index");
        depositHistory[index].status = DepositStatus.Approved;
    }

    function rejectDeposit(uint256 index) public onlyOwner {
        require(index < depositHistory.length, "Invalid index");
        depositHistory[index].status = DepositStatus.Rejected;
    }

    function getDepositHistory() public view returns (DepositRecord[] memory) {
        return depositHistory;
    }
}
