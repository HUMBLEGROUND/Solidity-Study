// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract evnt {
    event info(string name, uint256 money);

    // event 명 / (출력하고자 하는 타입)

    function sendMoney() public {
        emit info("KimJung", 1000);
    } // info의 값들을 언제든지 가져와서 쓸수 있다
}
// ⭐ emit 👉 정의된 이벤트를 발생시킴
