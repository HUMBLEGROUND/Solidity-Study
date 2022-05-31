// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

// enum 👉 사람이 읽을 수 있게, 개발자에 의해 정의된 상수 세트 0 ~ 255 까지의 상수
// enum 이름명 { }

//--------------------------------------------

contract nums {
    enum CarStatus {
        TurnOff,
        TurnOn,
        Driving,
        Stop
    }

    CarStatus public car; // car 라는 변수를 하나 생성

    constructor() {
        car = CarStatus.TurnOff;
    } // 맨처음 자동차의 상태는 TurnOff

    event carCurrentStatus(CarStatus _car, uint256 _carInt);

    function turnOnCar() public {
        require(car == CarStatus.TurnOff, "Off!");
        // 자동차의 상태가 TurnOff일때 "Off!"
        // require는 (false 이면) 에러를 발생시킨다
        car = CarStatus.TurnOn;
        // true 상태(시동) 일때는 TurnOn
        emit carCurrentStatus(car, uint256(car));
    }
}
