// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract data {
    // data type 에는 4가지가 있다
    // boolean / bytes / address / uint
    //--------------------------------------------

    // boolean 은 true 와 false 가 있다

    bool public b = false;
    // 👉 b라는 변수에 boolean 타입인 false가 담긴다는 뜻

    bool public b1 = !false; // true 라는 뜻
    bool public b2 = false || true; // true 라는 뜻
    bool public b3 = false == true; // false 라는 뜻
    bool public b4 = false && true; // false 라는 뜻

    // ! / || / == / && 👉 연산자 사용이 가능하다
    //--------------------------------------------

    // bytes 는 1에서 ~ 32 바이트까지 작성할수 있다

    bytes4 public bt = 0x12345678;
    // 4바이트로 크기를 명시를 해줘버릴수가 있다
    // 👉 bt라는 변수에 12 / 34 / 56 / 78 총 4바이트가 담긴다는 뜻

    bytes public bt2 = "STRING";
    // 👉bt2라는 변수에 문자를 그대로 담으면 솔리디티에서 '자동'으로 '바이트화'되어서 저장된다
    //--------------------------------------------

    // address는 입출금 주소 외에도 / 스마트컨트랙트를 배포 할때도 주소가 생긴다

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // 👉 address는 총 20바이트로 정해져있다 (총 길이40개)
    //--------------------------------------------

    // int vs uint
    // int 와 uint의 차이는 마이너스(음수)가 있느냐 없느냐에 차이이다

    // int8
    // -2^7 ~ 2^7 - 1  (마이너스 2의 7승 부터 ~ 2의 7승 마이너스 1)
    int8 public it = 4;

    // uint256 = uint8 / uint = uint8 = uint256 같은 의미 / 보통 uint256 으로 많이 쓰인다
    // 0 ~ 2^8 - 1 (0부터 ~ 2의 8승 마이너스 1)
    uint256 public unt = 123;
    uint256 public uit = 123;
}

// uint8 public uit2 = 256;
// 👉 255까지가 최대 범위라서 256은 범위초과로 오류가 난다
