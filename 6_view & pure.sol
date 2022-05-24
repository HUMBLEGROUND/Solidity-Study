// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// function get_a() view external returns (uint256)
// function get_a() external view returns (uint256)
// view 의 위치는 접근제한자 앞 뒤 아무곳이나 가능

// function get_a() pure external returns (uint256)
// function get_a() external pure returns (uint256)

// view 👉 function 밖의 변수들을 읽을 수 있으나 변경 불가능
// pure 👉 function 밖의 변수들을 읽지 못하고 / 변경도 불가능 (순수하게 function 내에서 변수로만 구성)

// view 나 pure 둘다 명시 안할 경우 👉 function 밖의 변수들을 읽어서 / 변경을 할 경우

// external 👉 모두 접근 가능하나 / external이 정의된 컨트랙트에서는 접근 불가
// internal 👉 internal이 정의된 자기 컨트랙트에서만 가능 / internal이 정의된 컨트랙트를 상속

contract vwpr {
    // 1. view
    uint256 public a = 1;

    function aa() public view returns (uint256) {
        return a + 2;
    }

    // 👉 a 값을 변경하지 않고 그대로 불러와서 +2를 함
    //--------------------------------------------

    // 2. pure
    function ab() public pure returns (uint256) {
        uint256 b = 1;
        return b + 3;
    }
    // 👉 function 밖의 변수 a 값은 못불러오고
    // 👉 function 안의 변수 b 값은 불러올수 있어서 b +3
}
