// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// mapping
// 👉 key 값을 넣어주면 그에 대응되는 value값을 얻게 해주는것
//--------------------------------------------

contract mapp {
    mapping(uint256 => uint256) private ageList;
    mapping(string => uint256) private priceList;
    mapping(uint256 => string) private nameList;

    // 키값의 타입 => 밸류값의 타입  / 접근제한자 / mapping 이름

    function setAgeList(uint256 _index, uint256 _age) public {
        // 순번번호(숫자)와 나이(숫자)를 매칭(셋팅), 지정 시켜주는 함수
        ageList[_index] = _age;
        // 👉 ex) 3번 = 23살
    }

    function getAge(uint256 _index) public view returns (uint256) {
        // 순번번호(숫자)를 적으면 나이(숫자)가 리턴되는 함수
        return ageList[_index];
        // 👉 ex) 3번을 적으면 23 이 나온다(리턴된다)
    }

    //--------------------------------------------
    function setNameList(uint256 _index, string memory _name) public {
        // 순번번호와 이름을 매칭(셋팅), 지정 시켜주는 함수
        nameList[_index] = _name;
        // 👉 ex) 2번 = 철수
    }

    function getName(uint256 _index) public view returns (string memory) {
        // 순번번호(숫자)를 적으면 이름(string)이 리턴되는 함수
        return nameList[_index];
        // 👉 ex) 2번을 적으면 철수가 나온다(리턴된다)
    }

    //--------------------------------------------
    function setPriceList(string memory _itemName, uint256 _price) public {
        // item 이름과 가격을 매칭(셋팅), 지정 시켜주는 함수
        priceList[_itemName] = _price;
        // 👉 ex) 딸기 = 1,000원 / 으로 지정한다
    }

    function getPriceList(string memory _index) public view returns (uint256) {
        // item 이름(string)을 적으면 가격(숫자)이 리턴되는(나오는) 함수
        return priceList[_index];
        // 👉 ex) 딸기를 적으면 1,000 이 나온다(리턴된다)
    }
}
