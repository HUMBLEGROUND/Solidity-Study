// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    uint256 public money = 100;

    function getMoney() public view virtual returns (uint256) {
        return money; // 👉 부모에는 'virtual' 을 명시해준다
    } // 👉 100 을 리턴한다
}

contract Son is Father {
    // 👉 Son 이라는 컨트랙트에 is 와 상속받을 컨트랙트 명
    // 👉 위에 Father 컨트랙트를 다 가져온다

    uint256 public earning = 0;

    function work() public {
        earning += 100;
    } // 👉 work 함수를 실행 할때마다 100씩 증가

    function getMoney() public view override returns (uint256) {
        return money + earning; // 👉 상속받아올 'override' 을 명시해준다
    } // 👉 기존 정의된 money 100 을 리턴하고
    // 👉 earning 100 이 계속 추가된다 (work 함수가 실행될때마다)
}
