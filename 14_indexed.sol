// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract indxd {
    event numberTracker(uint256 num, string str);
    // event 명 / (출력하고자 하는 타입)
    event numberTracker2(uint256 indexed num, string str);
    // event 명 / 👉 indexed를 이용하면 원하는 값만 필터하여 가져올수 있음)

    uint256 num = 0;

    function PushEvent(string memory _str) public {
        emit numberTracker(num, _str); // num 이 0 에서 출력후에 +1 씩 증가된다
        emit numberTracker2(num, _str); // num 이 0 에서 출력후에 +1 씩 증가된다
        num++;
    } // event의 값들을 언제든지 가져와서 쓸수 있다
}
// ⭐ emit 👉 정의된 이벤트를 발생시킴
