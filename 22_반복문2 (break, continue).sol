// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//Javascript 이나 python 같은 언어들 처럼 반복문 개념은 똑같다
// continue 👉 다음 반복문으로 이동
// break 👉 반복문을 끝냄
//--------------------------------------------

contract loof {
    event CountryIndexName(uint256 indexed _index, string _name);
    // indexed를 적용시킨 event 생성
    // 👉 indexed를 이용하면 원하는 값만 필터하여 가져올수 있다

    string[] private countryList = ["Korea", "USA", "China", "Japan"];

    // string타입의 배열에 나라 이름을 넣음

    function useContinue() public {
        for (uint256 i = 0; i < countryList.length; i++) {
            // for 반복문
            if (i % 2 == 1) {
                // 5 % 2 => 5 - 4(=2*2) = 1
                // 7 % 2 => 7 - 6(=2*3) = 1
                //-------------------------
                // 4 % 2 => 4 - 4(=2*2) = 0
                continue;
            }
            // 홀수일때는 반복문이 계속 돌고
            // 👉 짝수일때만 리턴을 하는 구조
            emit CountryIndexName(i, countryList[i]);
        } // i번째 숫자와, i번째 나라 이름
    }

    //--------------------------------------------
    function useBreak() public {
        for (uint256 i = 0; i < countryList.length; i++) {
            // for 반복문
            if (i == 2) {
                break;
            }
            // 배열에서 2번 index가 나오면 중지
            // 👉 0번 1번만 리턴을 한다 ["Korea", "USA"]
            emit CountryIndexName(i, countryList[i]);
        }
    }
}
