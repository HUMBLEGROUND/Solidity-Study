// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// 1 eth = 10^9 Gwei = 10^18 wei
// 1이더는 = 10의 9승 쥐웨이 = 10의 18승 웨이
// 0.01 eth = 10^16 wei
// 1 wei = 1^-18 = 0.00000000000000001 eth (0이 16개뒤에 1)

contract eth {
    uint256 public value1 = 1 wei;

    uint256 public value2 = 1 gwei;

    uint256 public value = 1 ether;
}

// 1 wei = 1
// 1 gwei = 1,000,000,000
// 1 eth = 1,000,000,000,000,000,000
