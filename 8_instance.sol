// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// instance

// 하나의 컨트랙트에서 다른 컨트랙트로 접근할때 쓰인다
//--------------------------------------------

contract A {
    uint256 public a = 5;

    function change(uint256 value) public {
        a = value;
    }
    // 👉 a = 5
    // 👉 a 변수에 5을 넣었어도 / a = value 값으로 배포할때 직접 입력해서 정해줄수 있다
}

//--------------------------------------------
contract B {
    A instance1 = new A();

    // 👉 컨트랙트 A에 접근한다고 선언

    function getA() public view returns (uint256) {
        return instance1.a();
    }

    // 👉 a = 5 / 위에 컨트랙트 A에 a값을 그대로 가져옴 / a 뒤에 괄호() 를 써야한다
    // 👉 view 를 쓴이유는 / function 밖의 변수들을 읽을 수 있으나 변경 불가능
    //--------------------------------------------
    function change1(uint256 value) public {
        instance1.change(value);
    }
    // 👉 컨트랙트 A에 function 변수 change를 그대로 가져옴 / value 값도 같이
    // 👉 value 값으로 배포할때 직접 입력해서 정해줄수 있다
}
