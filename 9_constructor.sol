// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// constructor

// instance로 다른 컨트랙트를 접근할때 초기 기본값을 정해주는것
//--------------------------------------------

contract A {
    string public name;
    uint256 public age;

    constructor(string memory name1, uint256 age1) {
        name = name1;
        age = age1;
    } // 그냥 가져오는

    function change(string memory name1, uint256 age1) public {
        name = name1;
        age = age1;
    } // 값을 변경할 수 있는 change 함수
}

//--------------------------------------------
contract B {
    A instance1 = new A("Bob", 52);

    // 👉 컨트랙트 A에 접근한다고 선언하고 / 기본값도 정의한다

    function get1() public view returns (string memory, uint256) {
        return (instance1.name(), instance1.age());
    }

    // 👉 instance1 로 가져온 값을 리턴

    function change1(string memory name2, uint256 age2) public {
        instance1.change(name2, age2);
    }
    // 👉 instance1 로 가져온 값("Bob", 52)을 배포할때 직접 입력해서 정해줄수 있다
}
