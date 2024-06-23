// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;






contract StudentManager {
   
    // Student Struct
    struct Student {

        string name;
        uint256 point;
        bool isActive;
    }

    Student public student;

    // student variable

    function addStudent(string memory _name, uint256 _point, bool _isActive) public {
        
        student = Student({
            name: _name,
            point: _point,
            isActive: _isActive
        });
    }


    function addPoints(uint256 amount) public {
        require(student.isActive, "Student account is not active.");
        student.point += amount;
    }


    function decreasePoints(uint256 amount) public {
        
        require(student.isActive, "Student account is not active.");
        require(student.point >= amount, "Not enough points to decrease.");
        student.point -= amount;
        
    }


    function checkPoints() public view returns (uint256) {
        return student.point;
    }

    function checkName() public view returns (string memory) {
        return student.name;
    }
}


  