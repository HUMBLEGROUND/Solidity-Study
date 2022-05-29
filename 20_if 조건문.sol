// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//Javascript 이나 python 같은 언어들 처럼 if 문 개념은 똑같다
//--------------------------------------------

contract ifs {
    string private outcome = "";

    // string 타입으로 outcome라는 빈객체 생성
    function isIt5(uint256 _number) public returns (string memory) {
        if (_number == 5) {
            outcome = "Yes, it is 5";
            return outcome;
        }
        // _number 5 일경우 outcome를 리턴
        else {
            outcome = "No, it is not 5";
            return outcome;
        } // _number 5 가 아닐땐 outcome를 리턴
    }
}
