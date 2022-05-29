// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// pragma solidity 0.4.22 ~ 0.7.x 버전에서 적용하는 버전

// 에러핸들러 (assert, revert, require)
// assert 👉 gas를 다 소비한 후 / 특정한 조건에 부합하지 않으면 (⭐ false 일 때) 에러를 발생시킨다
// revert 👉 조건없이 에러를 발생시키고 / gas를 환불 시켜준다
// require 👉 특정한 조건에 부합하지 않으면 에러를 발생시키고 (⭐ false 일 때) / gas를 환불 시켜준다
//--------------------------------------------

contract erh {
    function assertNow() public pure {
        assert(false);
    } // assert가 false 여서 에러를 발생시킨다

    // 3,000,000 gas 소모 (gas 환불안해줌)
    // 👉 가스를 소모 한 후에 함수를 실행시켜 에러인지 확인 하기때문에 환불을 안해준다
    // 👉 필요없는 가스가 나오니때문에 실제로는 거의 안쓰고 ⭐ test에서는 많이 쓴다

    function assertNow2() public pure {
        assert(false);
    } // 버전이 pragma solidity 0.8.1 ~ 부터는

    // ⭐ assert도 가스를 환불해준다 👉 assert를 실행한 가스값만 내고 나머지 가스는 환불해준다
    //--------------------------------------------
    function revertNow() public pure {
        revert("Error!");
    } // revert 는 그냥 에러를 발생시킨다

    // 21,322 gas 소모 (revert 실행 gas 가격) (나머지 gas는 환불해줌)
    // 👉 가스를 소모 한 후에 / revert를 실행한 가스값만 내고 나머지 가스는 환불해준다
    // 👉 그냥 에러를 발생시키기 때문에 딱히 쓸곳은 많지 않다 만약 쓸때는 ⭐ if문과 같이 사용
    //--------------------------------------------
    function requireNow() public pure {
        require(false, "Error!");
    } // require가 false 여서 에러를 발생시킨다

    // 21,338 gas 소모 (require 실행 gas 가격) (나머지 gas는 환불해줌)
    // 👉 require를 실행한 가스값만 내고 나머지 가스는 환불해준다
    //--------------------------------------------
    function onlyAdults(uint256 _age) public pure returns (string memory) {
        if (_age < 19) {
            revert("No smoke!");
        } // 만약 19살 미만이라면(true) revert 그냥 에러발생시킴
        // 👉 19살 이상이면 if문을 빠져나온다
        return "Ok smoke!";
    }

    function onlyAdults2(uint256 _age) public pure returns (string memory) {
        require(_age > 19, "No smoke!");
        // // require가 false 이면 에러를 발생시킨다 (if문은 true 이면 에러를 발생이킨다)
        return "Ok smoke!";
    }
}
