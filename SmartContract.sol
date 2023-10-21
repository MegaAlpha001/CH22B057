// Ayushman CH22B057
// SPDX-License-Identifier: GPL3.0
pragma solidity ^0.8.0;

//  smart contract scenario where an admin can enter details of various
//  users, including Aadhar card, name, age, and wallet address, but only the respective user
//  should be able toviewtheir information.

contract EmployeeDetails {
    address internal admin; 

    struct EmployeeRecord {
        string userid;
        string name;
        uint256 age;
        string aadharCard;
        address walletAddress;
        string passcode;
    }

    mapping(string => EmployeeRecord) internal  employees_record;

    modifier AdminOnly() {
        require(msg.sender == admin); 
        _;
    }

    constructor() {
        admin = msg.sender; 
    }

    function AddEmployee(
        string memory UserID,
        string memory Name,
        uint256 Age,
        string memory AadharCard,
        address WalletAddress,
        string memory Passcode
    ) public AdminOnly {
        employees_record[UserID] = EmployeeRecord({
            userid: UserID,
            name: Name,
            age: Age,
            aadharCard: AadharCard,
            walletAddress: WalletAddress,
            passcode: Passcode
        });
    }

    function GetEmployeeDetails(
        string memory Passcode, 
        string memory UserID
    ) public view returns (string memory, uint256, string memory, address) 
    {
        EmployeeRecord storage employee = employees_record[UserID];
        require(keccak256(abi.encodePacked(employee.passcode)) == keccak256(abi.encodePacked(Passcode)), "Invalid passcode");
        return (employee.name, employee.age, employee.aadharCard, employee.walletAddress);
    }
}

