// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.5.6;

// KIP-7은 ERC-20을 기반으로 만들어졌다
// 솔리디티에서 'Interface'는 사용할 함수의 형태를 선언한다
// 실제 함수의 내용은 Contract에서 사용한다
// 기본적인 KIP-7의 인터페이스 목록이다 👇

contract IKIP {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function transferFrom(
        address spender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    // 함수(function)는 이더리움에서 제공하는 함수이며, event는 이더리움에서 제공하는 로그이다
    // 'function'과 'event'를 선언할 때는 입력값과 반환값은 선택할 수 있으나,
    // 'function'의 자료형 / 이름 / 순서를 주의해야 한다

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Transfer(
        address indexed spender,
        address indexed from,
        address indexed to,
        uint256 amount
    );
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 oldAmount,
        uint256 amount
    );
}

// 'IKIP'의 ⭐ 'Transfer' 이벤트는 토큰이 이동할 때마다 로그를 남기고,
// ⭐ 'Approval' 이벤트는 'approve' 함수가 실행 될 때 로그를 남긴다

//----------------------------------------------------------

// 👉 'IKIP'는 'SimpleKlaytnToken' 컨트랙트에서 사용할 함수의 형태를 선언하며,
// 'KIP-7' 에서 사용하는 함수들의 형태를 선언한 것을 확인할 수 있다

contract SimpleKlaytnToken is IKIP {
    // contract SimpleKlaytnToken 뒤에 'is IKIP'를 붙여서
    // SimpleKlaytnToken 컨트랙트가 'IKIP' 함수를 사용할 수 있다고 선언한다
    // 이렇게 사용하면 'SimpleKlaytnToken' 안에서 'IKIP'에 선언된 함수와 이벤트를 사용할 수 있다

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) public _allowances;
    // 이중으로 매핑된 approvals를 확인할 수 있다

    uint256 public _totalSupply; // 토큰 총발행량
    string public _name; // 토큰 이름
    string public _symbol; // 토큰 약자
    uint8 public _decimals; // 18진수

    constructor(string memory getName, string memory getSymbol) public {
        _name = getName;
        _symbol = getSymbol;
        _decimals = 18;
        _totalSupply = 100000000e18; // 토큰 총발행량 설정
        _balances[msg.sender] = _totalSupply; // 추가
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // 👉 totalSupply는 토큰의 총 발행량을 반환한다

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    // 👉 balanceOf는 매핑된 값인 '_balanceOf'에서 입력한
    //    address인 account가 가지고있는 토큰의 수를 리턴한다

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // 👉 transfer는 내부 함수인 '_transfer'를 호출한다
    // 호출이 정상적으로 완료되었을 경우 Transfer event를 발생시킴

    function allowance(address owner, address spender)
        public
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    // allowance는 입력한 두개의 주소값에 대한 '_allowances'값,
    // 다시말해 '내가(owner)'가 '토큰을 양도할 상대방(spender)'에게 토큰을 등록한 양을 반환한다

    function approve(address spender, uint256 amount) public returns (bool) {
        uint256 currentAllownace = _allowances[msg.sender][spender];
        require(
            currentAllownace >= amount,
            "ERC20: Transfer amount exceeds allowance"
        );
        _approve(msg.sender, spender, currentAllownace, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        _transfer(sender, recipient, amount);
        emit Transfer(msg.sender, sender, recipient, amount);
        uint256 currentAllowance = _allowances[sender][msg.sender];
        require(
            currentAllowance >= amount,
            "ERC20: transfer amount exceeds allowance"
        );
        _approve(
            sender,
            msg.sender,
            currentAllowance,
            currentAllowance - amount
        );
        return true;
    }

    // 👉 transferFrom은 양도를 수행하는 거래 대행자(msg.sender)가 sender가 허락해준 값만큼 상대방(recipient)에게 토큰을 이동한다
    // 이동을 위해 _transfer 함수를 실행시킨다
    // '_transfer' 에서는 양도를 하는 sender의 잔고를 amount만큼 줄이고, recipient의 잔고를 amount만큼 늘린다
    // '_transfer' 함수 실행이 완료되고, require를 모두 통과한다면 currentAllowance를 체크하여 _approve 함수를 실행한다

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 senderBalance = _balances[sender];
        require(
            senderBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
    }

    // _transfer는 require를 통해 세가지 조건을 검사한다
    // 1. 보내는 사람의 주소가 잘못되었는지 체크한다
    // 2. 받는사람의 주소가 잘못되었는지 체크한다
    // 3. transfer 함수를 실행한 사람(sender)이 가진 토큰(senderBalance)이 신청한 값(amount)보다 많은 토큰을 가지고 있는지 체크한다
    // 👉 위의 세 조건을 충족하는 경우,
    // 실행한 사람(sender)이 가진 토큰의 지갑에서 토큰을 개수만큼 빼고,
    // 받을 사람(recipient)의 토큰 지갑에 개수만큼 더해준다

    function _approve(
        address owner,
        address spender,
        uint256 currentAmount,
        uint256 amount
    ) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        require(
            currentAmount == _allowances[owner][spender],
            "ERC20: invalid currentAmount"
        );
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, currentAmount, amount);
    }
    // 내부 함수인 _approve를 호출한다
    //_approve에서는 내가 토큰을 양도할 상대방(spender)에게 양도할 값(amount)를 allowances에 기록한다
    // 그리고 Approval event를 호출하여 기록한다
    // 이 상태에서는 양도가 실제로 이루어진 것이 아니라, 양도를 할 주소와 양을 정한 것이다
    // 👉 approve는 단순 변경을 위한 함수이기 때문에 내부적으로 값을 올리고,
    // 내리는 'increaseApproval'과 / 'decreaseApproval' 함수를 사용하기도 한다
    // approve 는 spender 가 당신의 계정으로부터 amount 한도 하에서 여러 번 출금하는 것을 허용합니다.
    // 이 함수를 여러번 호출하면, 단순히 허용량을 amount 으로 재설정한다
}
