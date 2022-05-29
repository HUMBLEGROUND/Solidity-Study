// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//Javascript 이나 python 같은 언어들 처럼 반복문 개념은 똑같다
//--------------------------------------------

contract loof {
    event CountryIndexName(uint256 indexed _index, string _name);
    // indexed를 적용시킨 event 생성
    // 👉 indexed를 이용하면 원하는 값만 필터하여 가져올수 있다

    string[] private countryList = ["Korea", "USA", "China", "Japan"];

    // string타입의 배열에 나라 이름을 넣음

    function forLoopEvent() public {
        for (uint256 i = 0; i < countryList.length; i++) {
            // for 반복문
            emit CountryIndexName(i, countryList[i]);
        } // i번째 숫자와, i번째 나라 이름
    }

    //--------------------------------------------
    function whileLoopEvent() public {
        // while 반복문
        uint256 i = 0;
        while (i < countryList.length) {
            emit CountryIndexName(i, countryList[i]);
            i++;
        } // i번째 숫자와, i번째 나라 이름
    }

    //--------------------------------------------
    function doWhileLoopEvent() public {
        uint256 i = 0;
        do {
            emit CountryIndexName(i, countryList[i]);
            i++;
        } while (i < countryList.length);
    } // i번째 숫자와, i번째 나라 이름

    function doWhileLoopEvent2() public {
        uint256 i = 7;
        // 👉 do-while의 단점은 초기값을 배열 length보다 더 크게 정해도 동작한다
        do {
            emit CountryIndexName(i, countryList[i]);
            i++; // 배열은 3번 "Japan"까지 밖에 없는데
            // 4, "" / 5, "" / 6, "" / 7, "" 이런식으로 index만 반환하는 현상
        } while (i < countryList.length);
    }
}
