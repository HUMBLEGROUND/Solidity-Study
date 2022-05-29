// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract strc {
    struct Character {
        uint256 age;
        string name;
        string job;
    }

    mapping(uint256 => Character) public CharacterMapping;
    // 원래 Character라는 타입은 없지만 struct로 타입을 정의 해줌으로써
    // 👉 Character라는 타입을 mapping에 정의해줄수 있다

    Character[] public CharacterArray;

    // 👉 배열도 마찬가지로 Character타입 배열을 만들수 있다
    //--------------------------------------------
    function createCharacter(
        uint256 _age,
        string memory _name,
        string memory _job
    ) public pure returns (Character memory) {
        return Character(_age, _name, _job);
    } // 👉 위에서 정의한 Character 타입들을 타입에 맞게 리턴하는 함수

    //--------------------------------------------
    function createCharacterMapping(
        uint256 _key,
        uint256 _age,
        string memory _name,
        string memory _job
    ) public {
        CharacterMapping[_key] = Character(_age, _name, _job);
    } // 👉 CharacterMapping에 _key를 추가로 정의해 줘서

    // 👉 _key 번호를 입력하면 그에 맞는 _age, _name, _job 를 반환하도록 하는 함수
    // ex) 1 = 22, 'Kim', 'doctor'
    // ex) 2 = 33, 'Lee', 'Engineer'

    function getCharacterMapping(uint256 _key)
        public
        view
        returns (Character memory)
    {
        return CharacterMapping[_key];
    } // 👉 ex) 2번을 적으면 33, 'Lee', 'Engineer'를 리턴

    //--------------------------------------------
    function createCharacterArray(
        // 배열은 빈배열부터 시작하니까 _key 값을 따로 정의 하지 않아도 된다
        uint256 _age,
        string memory _name,
        string memory _job
    ) public {
        CharacterArray.push(Character(_age, _name, _job));
    } // 👉 CharacterArray 배열에 값을 넣어주는 함수

    function getCharacterArray(uint256 _index)
        public
        view
        returns (Character memory)
    {
        return CharacterArray[_index];
    } // 👉 배열에서 찾고자하는 length 순번
}
