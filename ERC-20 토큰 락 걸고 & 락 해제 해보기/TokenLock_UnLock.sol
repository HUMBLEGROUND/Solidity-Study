// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

interface ERC20Interface {
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

//----------------------------------------------------------------

library SafeMath {
    // 👉 기존 ERC-20 코드에서 SafeMath 라이브러리를 추가
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

// 'internal'은 함수가 컨트랙트 내부에서만 사용될 수 있도록 제한할 때 사용한다
// 'pure' 는 함수가 상태 변수를 읽거나 쓰지 않을 때 사용한다
// 'SafeMath' 라이브러리의 함수에서는 단순 연산의 결과값을 반환하기 때문에 상태 변수를 읽거나 쓰지 않는다
// ⭐ 'assert'는 false를 리턴하지만 계약을 실행 시키기 전에 확인을 할 수 없고,
// ⭐ 'require'는 계약을 실행 시키기 전에 확인을 할 수 있는것으로 알 수 있다

//----------------------------------------------------------------
abstract contract OwnerHelper {
    // 👉 'OwnerHelper' 컨트랙트는 'abstract contract'라고 하는 추상 컨트랙트
    // abstract contract는 contract의 구현된 기능과 interface의 추상화 기능 모두를 포함한다
    // abstract contract는 만약 실제 contract에서 사용하지 않는다면 추상으로 표시되어 사용되지 않는다
    address private _owner;
    // 👉 _owner는 관리자를 나타냄

    event OwnershipTransferred(
        address indexed preOwner,
        address indexed nextOwner
    );
    // 👉 'OwnershipTransferred' 이벤트는 관리자가 변경되었을때 이전 관리자의 주소와 새로운 관리자의 주소 로그를 남긴다

    modifier onlyOwner() {
        require(msg.sender == _owner, "OwnerHelper: caller is not owner");
        _;
    }

    // 👉 'onlyOwner' 함수 변경자는 함수 실행 이전에 함수를 실행시키는 사람이 관리자인지 확인한다

    constructor() {
        _owner = msg.sender;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != _owner);
        require(newOwner != address(0x0));
        address preOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(preOwner, newOwner);
    }
}

//----------------------------------------------------------------

contract SimpleToken is ERC20Interface, OwnerHelper {
    using SafeMath for uint256;
    // 👉 메인 컨트랙트인 SimpleToken에서는 자료형 'uint256'에 대해서 'SafeMath' 라이브러리를 사용하도록 선언해준다
    // 'uint256'으로 선언된 함수에 대해서 'SafeMath Library'를 이용해서 'transferFrom'과 '_transfer' 함수를 사용을 할 수 있다

    // 'transferFrom'과 '_transfer'에서 사용되는 연산자(+, -)를 'SafeMath' 라이브러리 함수를 사용해 안전한 연산자로 변경할 수 있음

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) public _allowances;

    uint256 public _totalSupply;
    string public _name;
    string public _symbol;
    uint8 public _decimals;
    bool public _tokenLock;
    mapping(address => bool) public _personalTokenLock;

    constructor(string memory getName, string memory getSymbol) {
        _name = getName;
        _symbol = getSymbol;
        _decimals = 18;
        _totalSupply = 100000000e18;
        _balances[msg.sender] = _totalSupply;
        _tokenLock = true;
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

    function totalSupply() external view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account)
        external
        view
        virtual
        override
        returns (uint256)
    {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        external
        virtual
        override
        returns (bool)
    {
        // uint256 currentAllownace = _allowances[spender][msg.sender];  // 삭제
        uint256 currentAllowance = _allowances[msg.sender][spender]; // 추가
        require(
            _balances[msg.sender] >= amount,
            "ERC20: The amount to be transferred exceeds the amount of tokens held by the owner."
        );
        _approve(msg.sender, spender, currentAllowance, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        emit Transfer(msg.sender, sender, recipient, amount);
        uint256 currentAllowance = _allowances[sender][msg.sender];
        require(
            currentAllowance >= amount,
            "ERC20: transfer amount exceeds allowance"
        );
        // 다음의 코드에서 currentAllowance.sub(amount)이 SafeMath 라이브러리 함수를 사용한 예시
        _approve(
            sender,
            msg.sender,
            currentAllowance,
            currentAllowance - amount
        );
        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(
            isTokenLock(sender, recipient) == false,
            "TokenLock: invalid token transfer"
        );
        uint256 senderBalance = _balances[sender];
        require(
            senderBalance >= amount,
            "ERC20: transfer amount exceeds balance"
        );
        _balances[sender] = senderBalance.sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
    }

    // uint256 으로 선언했던 'currentAllowance'와 'senderBalance'에 'sub' 함수를 사용 가능한 모습을 볼 수 있다
    // 'Mapping' 으로 선언했던 '_balances' 도 uint256 으로 받아오는 값에서 add 함수를 사용 가능하다

    // 👉 '_transfer'에 검사를 추가해, 보내는 사람과 받는 사람 중 락이 걸려있다면 토큰은 이동이 불가능하다

    function isTokenLock(address from, address to)
        public
        view
        returns (bool lock)
    {
        // 👉 함수 'isTokenLock' 은 전체 락과, 보내는 사람의 락, 받는 사람의 락을 검사하여 락이 걸려 있는지 확인한다
        lock = false;

        if (_tokenLock == true) {
            lock = true;
        }

        if (
            _personalTokenLock[from] == true || _personalTokenLock[to] == true
        ) {
            lock = true;
        }
    }

    // 'tokenLock' 은 토큰의 전체 락에 대한 처리, 'tokenPersonalLock' 은 토큰의 개인 락에 대한 처리이다

    // 다음의 코드에서 함수로 전달되는 파라미터 브라켓 뒤에 오는 onlyOwner가 예시이다
    function removeTokenLock() public onlyOwner {
        require(_tokenLock == true);
        _tokenLock = false;
    }

    // 락들을 제거 할 수 있는 removeTokenLock

    // 다음의 코드에서 함수로 전달되는 파라미터 브라켓 뒤에 오는 onlyOwner가 예시이다
    function removePersonalTokenLock(address _who) public onlyOwner {
        require(_personalTokenLock[_who] == true);
        _personalTokenLock[_who] = false;
    }

    // 락들을 제거 할 수 있는 removePersonalTokenLock
    // 이 함수들은 'onlyOwner'를 적용하여 관리자만 락을 해제할 수 있도록 해야 한다
    // 이렇게 락을 적용하게 되면 모든 락을 해제할 때만 토큰의 이동이 가능하다

    function _approve(
        address owner,
        address spender,
        uint256 currentAmount,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        require(
            currentAmount == _allowances[owner][spender],
            "ERC20: invalid currentAmount"
        );
        _allowances[owner][spender] = amount; // 삭제
        emit Approval(owner, spender, currentAmount, amount);
    }
}
