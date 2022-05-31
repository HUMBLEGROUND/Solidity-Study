// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// fallback 👉 대비책 함수
// 1. 이름이 없는 함수 이다 (무기명 함수)
// 2. external 을 필수로 사용해야한다
// 3. payable 을 꼭 붙여서 사용해야한다

// 👉 스마트컨트랙트가 이더리움을 받을수 있게 한다
// 👉 이더리움을 받고 난 후 어떠한 행동을 취하게 할 수 있다
// 👉 call 함수로 없는 함수가 불려질때, 어떠한 행동을 취하게 할 수 있다
//--------------------------------------------
/*
⭐ ~ 0.6 버전에서 사용법
function() external payable { }

//--------------------------------------------
⭐ 0.6 ~ 버전에서 사용법

0.6 이후에서는 fallback 과 recevie 로 두가지로 나뉜다

recevie 👉 순수하게 이더리움만 받을때 작동
fallback 👉 함수를 실행하면서 이더리움을 보낼때, 불려진 함수가 없을때 작동
//--------------------------------------------
fallback() external { }

fallback() external payable { }
// 👉 이더리움을 받을수도 있고 fallback 함수도 작동된다

recevie() external payable { }

*/

contract Bank {
    event Funds(address _from, uint256 _value, string message);

    function() external payable {
        emit Funds(msg.sender, msg.value, "Funds is called");
    } // 사용자주소, 보낼 금액, 메세지
}

//--------------------------------------------
contract You {
    function DepositSend(address payable _to) public payable {
        bool success = _to.send(msg.value);
        require(success, "Failed!");
    }

    //--------------------------------------------
    function DepositTransfer(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    //--------------------------------------------
    // ~ 0.7 버전
    function DepositCall(address payable _to) public payable {
        (bool sent, ) = _to.call.value(msg.value)("");
        require(sent, "Failed!");
    }

    //--------------------------------------------
    // ~ 0.7 버전
    function JustMessage(address _to) public {
        (bool sent, ) = _to.call("HI");
        require(sent, "Failed!");
    }

    //--------------------------------------------
    // ~ 0.7 버전
    function JustFunds(address payable _to) public payable {
        (bool sent, ) = _to.call.value(msg.value)("HI");
        require(sent, "Failed");
    }
}
