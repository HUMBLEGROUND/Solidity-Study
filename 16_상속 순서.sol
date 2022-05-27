// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

//--------------------------------------------

contract Father {
    event FatherName(string name);

    function who() public virtual {
        emit FatherName("KimJin");
    }
}

contract Mother {
    event MotherName(string name);

    function who() public virtual {
        emit MotherName("LeeSol");
    }
}

contract Son is Father, Mother {
    function who() public override(Father, Mother) {
        super.who(); // 👉 "LeeSol"
        // 👉 Mother의 이벤트만 가져온다
    } // 👉 Father, Mother중 마지막에 오는 걸 상속받는다
}
