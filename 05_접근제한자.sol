// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// public   👉 모두 접근 가능
// private  👉 private이 정의된 자기 컨트랙트에서만 접근 가능 / private를 상속받은 자식이어도 접근은 불가능

// external 👉 모두 접근 가능하나 / external이 정의된 컨트랙트에서는 접근 불가
// internal 👉 internal이 정의된 자기 컨트랙트에서만 가능 / internal이 정의된 컨트랙트를 상속

contract enter {
    uint256 public a = 5;
    // public은 모두 접근이 가능해서 👉 a = 5

    uint256 private a2 = 5;
    // 컨트랙트가 private으로 정의 되지 않아서 접근이 불가능
}

contract enter1 {
    uint256 public a = 5;
    // public은 모두 접근이 가능해서 👉 a = 5

    uint256 private a2 = 5;
    // 컨트랙트가 private으로 정의 되지 않아서 접근이 불가능
}
