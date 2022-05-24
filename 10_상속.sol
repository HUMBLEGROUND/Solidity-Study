// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    string public finallyName = "Kim";
    string public givenName = "Jung";
    uint256 public money = 100;

    function getFinallyName() public view returns (string memory) {
        return finallyName;
    } // 👉 'Kim' 을 리턴한다

    function getGivenName() public view returns (string memory) {
        return givenName;
    } // 👉 'Jung' 을 리턴한다

    function getMoney() public view returns (uint256) {
        return money;
    } // 👉 100 을 리턴한다
}

contract Son is Father {
    // 👉 Son 이라는 컨트랙트에 is 와 상속받을 컨트랙트 명
    // 👉 위에 Father 컨트랙트를 다 가져온다
}
