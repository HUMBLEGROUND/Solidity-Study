// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// 함수를 정의할때 return 명을 미리 정의 해줄수 있다

//--------------------------------------------

contract func {
    modifier onlyAdults() {
        revert("No smoke!");
        _;
    } // _ 가 표시된 자리에 function 이 들어가는 자리이다

    function BuyCigarette() public onlyAdults returns (string memory) {
        return "No smoke!";
    }

    // modifier onlyAdults() {
    //     revert("No smoke!");
    // 👉 function BuyCigarette() public onlyAdults returns (string memory) {
    //     return "No smoke!";
    //    }
    // }
    //--------------------------------------------
    modifier onlyAdults2(uint256 _age) {
        require(_age > 18, "No smoke!");
        _;
    } // _ 가 표시된 자리에 function 이 들어가는 자리이다

    // 파라미터 값을 정해줬을 경우

    function BuyCigarette2(uint256 _age)
        public
        onlyAdults2(_age)
        returns (string memory)
    {
        return "No smoke!";
    }
}
