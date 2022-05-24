// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// string 종류

// storage  👉 대부분의 변수 / 함수 들이 영속적으로 저장된다 / 가스비용이 비싸다
// memory   👉 함수의 파라미터 / 리턴값 / 레퍼런스 타입이 저장된다
//              영속적으로 저장되지는 않고 / 함수 내에서만 유효하다 / 가스비용이 싸다

// colldata 👉 주로 external function 의 파라미터에서 사용된다
// stack    👉 EVM 에서 stack data를 관리할때 쓰는 영역 / 1024Mb 제한
//--------------------------------------------

contract str {
    function getstr(string memory str1) public pure returns (string memory) {
        return str1;
    }

    //--------------------------------------------

    function getuint(uint256 ui) public pure returns (uint256) {
        return ui;
    }
    //function getuint(uint256 memory ui) public pure returns (uint256 memory) {
    //  return ui;
    //} 👉 data 타입은 memory가 기본값으로 들어가 있기 때문에 memory를 생략한다
}
