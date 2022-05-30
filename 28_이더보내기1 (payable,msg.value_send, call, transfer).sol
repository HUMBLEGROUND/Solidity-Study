// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// payable 👉 토큰 상호작용 시 필요한 키워드
// ex) 이더리움을 전송하거나 받을때 payable 이라는 키워드가 필요하다
// 이더리움을 보내는 함수를 만든다고 했을때 / 그 함수에는 payable를 꼭 붙여줘야한다
// 👉 payable 은 send / transfer / call 과 같이 사용된다

// msg.value 👉 송금보낸 코인의 값

// 1. send 👉 2300 gas를 소비 / 에러를 발생시키지 않고 true 또는 false로 리턴한다
// 2. call 👉 가변적인 gas를 소비(gas값을 지정가능) / 에러를 발생시키지 않고 true 또는 false로 리턴한다
// ⭐ 이더리움의 가격이 오르면 가변적인 gas값인 call 이 효율적일수가 있다

// 3. transfer 👉 2300 gas를 소비 / 실패시 에러를 발생시킨다
// ⭐ 보통 transfer을 많이 쓴다
//--------------------------------------------

contract payab {
    event howMuch(uint256 _value);

    function sendNow(address payable _to) public payable {
        // _to는 '이더리움을 받을 주소' 또는 '스마트컨트랙트 주소' 마지막에는 payable를 써줘야한다
        bool sent = _to.send(msg.value); // 결과를 true 와 false 로 반환을 한다
        require(sent, "Failed"); // false 일때는 require을 반환
        emit howMuch(msg.value); // true 일때는 이벤트를 실행
    }

    // ⭐ msg.value 👉 송금보낸 코인의 값
    //--------------------------------------------
    function transferNow(address payable _to) public payable {
        // _to는 '이더리움을 받을 주소' 또는 '스마트컨트랙트 주소' 마지막에는 payable를 써줘야한다
        _to.transfer(msg.value);
        // transfer는 에러를 발생할수 있어서 따로 에러핸들러를 추가 하지 않아도 된다
        emit howMuch(msg.value);
    }

    //--------------------------------------------
    function callNow(address payable _to) public payable {
        // ~ 0.7 버전에서 사용시
        // (bool sent, ) = _to.call.gas(1000).value(msg.value)("");
        // require(sent, "Failed!");
        //--------------------------------------------
        // 0.7 ~ 버전에서 사용시
        (bool sent, ) = _to.call{value: msg.value, gas: 1000}("");
        require(sent, "Failed!");
        emit howMuch(msg.value);
    }
}
