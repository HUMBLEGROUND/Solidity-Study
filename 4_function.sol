// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// function 변수명 () public { 함수에 들어갈 내용 }

contract func {
    // 1. Parameter 랑 Return 값이 없는 function 정의
    uint256 public a = 3;

    function changeA1() public {
        a = 5;
    }

    // 👉 a = 5
    // 👉 a 변수에 3을 넣었어도 function 을 통해 a를 5로 바꿔줄수 있다
    //--------------------------------------------

    // 2. Parameter 는 있고 / Return 값이 없는 function 정의

    function changeA2(uint256 value) public {
        a = value;
    }

    // 👉 a = value 값으로 배포할때 직접 입력해서 정해줄수 있다
    //--------------------------------------------

    // 3. Parameter 는 있고 / Return 값이 있는 function 정의
    function changeA3(uint256 value) public returns (uint256) {
        a = value;
        return a;
    }
    // 👉 a = value 값으로 배포할때 직접 입력해서 정해줄수 있다
    // 👉 a 값으로 나온 값을 리턴해준다
}
