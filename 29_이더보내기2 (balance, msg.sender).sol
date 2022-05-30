// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// 주소.balance 는 👉 해당하는 특정주소의 현재 이더리움 잔액을 나타낸다
// (msg.value) 는 송금하고자 하는 이더리움 값(갯수)

// msg.sender 👉 스마트컨트랙트를 사용하는 주체

//--------------------------------------------

contract Bank {
    event SendInfo(address _msgSender, uint256 _currentValue);
    event MyCurrentValue(address _msgSender, uint256 _value);
    event CurrentValueOfSomeone(
        address _msgSender,
        address _to,
        uint256 _value
    );

    function sendEther(address payable _to) public payable {
        // _to는 '이더리움을 받을 주소' 마지막에는 payable를 써줘야한다
        require(msg.sender.balance >= msg.value, "not enough");
        // msg.sender.balance 는 사용자의 잔액이 없을때 "not enough"
        // require는 (false 이면) 에러를 발생시킨다
        _to.transfer(msg.value);
        // 에러가 아니라면 (true 이면)
        // _to 👉 이더리움을 받을 주소에 몇 이더를 보낼지 입력
        emit SendInfo(msg.sender, (msg.sender).balance);
        // SendInfo 이벤트 실행 (사용자주소, 사용자의 잔액)
    }

    function checkValueNow() public {
        emit MyCurrentValue(msg.sender, msg.sender.balance);
    } // 사용자주소, 사용자의 잔액

    function checkUserMoney(address _to) public {
        emit CurrentValueOfSomeone(msg.sender, _to, _to.balance);
    } // 사용자주소, 보낼 주소, 보낸 주소의 잔액
}
