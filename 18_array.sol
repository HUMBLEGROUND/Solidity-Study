// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// array <ㅡ> mapping
// 👉 배열안에 값들을 추가하고 삭제할수 있다
// 👉 length를 구할수있다 (mapping은 length를 못구함)
// 👉 배열안에 있는 값들을 순회 할수도 있다

// ⭐ 그러나 '솔리디티'에서는 array보단 mapping을 선호한다
// (디도스 공격을 방지히기 위하여 mapping 선호)
//--------------------------------------------

contract arr {
    uint256[] public ageArray;
    // 빈배열로 정의
    uint256[] public ageArray2 = [22, 33, 35];
    // 배열안의 값들을 아예 정의 할수도 있다
    string[] public ageArray3 = ["one", "two", "three"];
    // 배열안의 값들을 string 타입으로 아예 정의 할수도 있다
    uint256[10] public ageArray4;

    // 배열의 수를 10개로 (0번째~9번째) 정의 할수도 있다

    // 배열의 타입(숫자) / [] 어디에 담을지 괄호 / 접근자 / 배열의 이름
    //--------------------------------------------
    function AgeLength() public view returns (uint256) {
        return ageArray.length;
    } // ageArray 배열의 길이(담겨있는 수)를 구하는 함수

    // 👉 지금은 빈배열 []

    //--------------------------------------------
    function AgePush(uint256 _age) public {
        ageArray.push(_age);
    } // ageArray 배열에 값(숫자)을 넣어주는 함수

    // 👉 ex) [20, 30, 40]

    //--------------------------------------------
    function AgeGet(uint256 _index) public view returns (uint256) {
        return ageArray[_index];
    } // 배열에서 찾고자하는 length 순번

    // 👉 ex) 1번 => [30]

    //--------------------------------------------
    function AgePop() public {
        ageArray.pop();
    } // 배열에서 맨뒤부터 순서대로 제거

    // 👉 ex) pop한번 실행 시 => [20, 30] / 맨뒤에 40은 제거됨

    //--------------------------------------------
    function AgeDelete(uint256 _index) public {
        delete ageArray[_index];
    } // 배열에서 삭제할 값을 순번입력을 해서 제거 (아예 없어지지 않고 값을 0으로 만든다)

    // 👉 ex) 0 번=> [0, 30, 40]
    // 👉 length는 그대로 / 0번째 값이 20 ㅡ> 0으로 바뀜

    //--------------------------------------------
    function AgeChange(uint256 _index, uint256 _age) public {
        ageArray[_index] = _age;
    } // 배열에서 바꾸고싶은 값을 어디에 넣을지 순서도 선택해서 바꿀수 있다
    // 👉 ex) 0 번에 22 => [22, 30, 40]
    // 👉 0번째 값이 22 로 바뀜 (Change)

    // ⭐ 5번째 값을 70 으로 바꾸려고 한다면 에러가 난다
    // ⭐ 배열은 지금 0 1 2 번째 까지밖에 없어서 에러 발생 (5번째는 없기때문에)
}
