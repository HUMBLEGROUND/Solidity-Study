// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract CredentialBox {
    address private issuerAddress;
    uint256 private idCount;
    mapping(uint8 => string) private alumniEnum;

    struct Credential {
        uint256 id; // index순서를 표기하는 idCount
        address issuer;
        // 발급자, 하나 혹은 그 이상의 주체에 대한 클레임을 주장하고,
        // 그 클레임으로부터 검증가능한 크리덴셜을 생성하며 검증가능한 크리덴셜을 보유자에게 전달하는 엔터티의 역할
        uint8 alumniType; // 졸업증명서 타입
        string value;
        // 크리덴셜에 포함되어야하는 암호화된 정보.
        // 중앙화된 서버에서 제공하는 신원, 신원 제공자, 엔터티, 서명 등이 JSON 형태로 저장한다.
    }
    // 👆 위 코드는 검증가능한 크리덴셜인 VC를 구현하기 위한 구조체이다

    mapping(address => Credential) private credentials;

    constructor() {
        issuerAddress = msg.sender;
        idCount = 1;
        alumniEnum[0] = "SEB";
        alumniEnum[1] = "BEB";
        alumniEnum[2] = "AIB";
    }

    // claimCredential 함수로 Credential을 발행하고,
    // getCredential 함수를 통해 Credential을 발행한 주소에서 VC를 확인하는 간단한 구조이다
    function claimCredential(
        address _alumniAddress,
        uint8 _alumniType,
        string calldata _value
    ) public returns (bool) {
        require(issuerAddress == msg.sender, "Not Issuer");
        Credential storage credential = credentials[_alumniAddress];
        require(credential.id == 0);
        credential.id = idCount;
        credential.issuer = msg.sender;
        credential.alumniType = _alumniType;
        credential.value = _value;

        idCount += 1;

        return true;
    }

    // claimCredential 함수를 통해 발급자(issuer)는
    // 어떠한 주체(_alumniAddress)에게 크리덴셜(Credential)을 발행(claim)이 가능하게 된다

    // getCredential 함수를 통해 Credential을 발행한 주소에서 VC를 확인하는 간단한 구조이다
    function getCredential(address _alumniAddress)
        public
        view
        returns (Credential memory)
    {
        return credentials[_alumniAddress];
    }
    // getCredential 함수를 통해 어떠한 주체(_alumniAddress)를 통하여
    // 발행(claim)한 크리덴셜(Credential)을 확인할 수 있다
}

// JWT 로 암호화된 토큰
// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWRwIjoiY29kZSBzdGF0ZXMiLCJ0eXBlIjoiYmViIiwidG9rZW4iOiJ0ZXN0IiwidmFsdWUiOiLsvZTrk5zsiqTthYzsnbTsuKAgRElEIOyImOujjOymnSDrsJzquInsnYQg7JyE7ZWcIO2BrOumrOuNtOyFnCDthYzsiqTtirgifQ.qXTgkPcK43uZ4_FBLBTFjaTsnmV9sAAekgK8BUZBt1g
