// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    event FatherName(string name);

    function who() public virtual {
        emit FatherName("KimDong");
        emit FatherName("LeeDong");
        emit FatherName("ParkDong");
    } // 👉 event가 여러개 일경우
}

contract Son is Father {
    event SonName(string name);

    function who() public override {
        super.who();
        // 👉 super를 쓰면 여러개여도 한번에 상속받아온다

        emit SonName("KimJin");
    }
}
