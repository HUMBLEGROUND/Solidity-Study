// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    uint256 public fatherMoney = 100;

    function getFatherName() public pure returns (string memory) {
        return "KimJung";
    } // 👉 'KimJung' 을 리턴한다

    function getMoney() public view virtual returns (uint256) {
        return fatherMoney;
    } // 👉 100 을 리턴한다
}

contract Mother {
    uint256 public motherMoney = 500;

    function getMotherName() public pure returns (string memory) {
        return "LeeSoo";
    } // 👉 'LeeSoo' 을 리턴한다

    function getMoney() public view virtual returns (uint256) {
        return motherMoney;
    } // 👉 500 을 리턴한다
}

contract Son is Father, Mother {
    // 👉 Son 이라는 컨트랙트에 is 와 상속받을 컨트랙트 명
    // 👉 위에 Father와 Mother 컨트랙트를 다 가져온다

    function getMoney() public view override(Father, Mother) returns (uint256) {
        // 👉 Father와 Mother에 둘다 'getMoney' 함수가 있으니까 'override' 을 이용해 두개 다 상속받아올수 있다
        return fatherMoney + motherMoney;
    } // 👉 100 + 500
}
