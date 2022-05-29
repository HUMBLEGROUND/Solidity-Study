// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// 찾고자 하는 값을 배열을 순회하면서 Search 한다
//--------------------------------------------

contract loof {
    event CountryIndexName(uint256 indexed _index, string _name);
    // indexed를 적용시킨 event 생성
    // 👉 indexed를 이용하면 원하는 값만 필터하여 가져올수 있다

    string[] private countryList = ["Korea", "USA", "China", "Japan"];

    function linearSearch(string memory _search)
        public
        view
        returns (uint256, string memory)
    {
        for (uint256 i = 0; i < countryList.length; i++) {
            if (keccak256(bytes(countryList[i])) == keccak256(bytes(_search))) {
                // 솔리디티 에서는 countryList 배열안에 값을 / 바이트화 시킨 후에 해쉬화를 시켜줘야 한다
                // ⭐ bytes 👉 바이트화 시켜주는 내장함수
                // ⭐ keccak256 👉 해쉬화 시켜주는 내장함수
                return (i, countryList[i]);
                // ex) "Paris" 를 배열에서 search
            }
        }
        return (0, "Nothing");
        // 👉 "Paris"가 없다면 "Nothing" 을 반환)
    }
}
