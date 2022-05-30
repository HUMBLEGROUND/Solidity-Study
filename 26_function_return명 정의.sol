// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// 함수를 정의할때 return 명을 미리 정의 해줄수 있다

//--------------------------------------------

contract func {
    function add(uint256 _num1, uint256 _num2) public pure returns (uint256) {
        // 함수를 정의할때 return 명을 미리 정의 해주지 않았을때
        uint256 total = _num1 + _num2;
        // 👉 total이라는 명의 타입이 뭔지 적어줘야한다 uint256
        return total;
    }

    //--------------------------------------------
    function add2(uint256 _num1, uint256 _num2)
        public
        pure
        returns (uint256 total)
    {
        // 함수를 정의할때 return 명을 미리 정의 했을때
        total = _num1 + _num2;
        // 👉 total이라는 명의 타입이 뭔지 정의를 해줬기 때문에 그냥 적어도 된다
        return total;
    }

    //--------------------------------------------
    // function add3(uint256 _num1, uint256 _num2)
    //     public
    //     pure
    //     returns (uint256 total, uint256 age, uint256 result, uint256 size)
    // {
    //     // 함수를 정의할때 return 명을 미리 여러개도 정의 할수 있다
    //     total = _num1 + _num2;

    //     // 👉 리턴명의 타입이 뭔지 정의를 해줬기 때문에 그냥 적어도 된다
    //     return ;
    // }
}
