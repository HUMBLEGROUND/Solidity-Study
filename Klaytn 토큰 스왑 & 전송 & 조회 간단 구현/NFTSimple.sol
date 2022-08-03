// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.24 <=0.5.6;

contract NFTSimple {
    string public name = "KlayLion"; // 토큰이름
    string public symbol = "KL"; // 토큰심볼

    mapping (uint256 => address) public tokenOwner; // 숫자를 넣으면 주소로 반환
    mapping (uint256 => string) public tokenURIs; // 숫자를 넣으면 문자로 반환

    mapping (address => uint256[]) private _ownedTokens; // 주소를 넣으면 숫자 배열로 반환

    function mintWithTokenURI (address to, uint256 tokenId, string memory tokenURI) public returns (bool) {
        // 토큰을 발행 하는 함수
        tokenOwner[tokenId] = to; // to는 소유주 이기때문에 👉 msg.sender 으로도 쓸수 있다
                                       // 토큰 번호를 입력하면 토큰 소유주의 주소가 나온다
        tokenURIs[tokenId] = tokenURI; // 토큰 번호를 입력하면 토큰의 이름이 나온다

        _ownedTokens[to].push(tokenId); // 주소를 입력하면 소유중인 토큰 번호들이 나온다

        return true; // 리턴
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        // 토큰을 전송하는 함수
        require(from == msg.sender, "Not from"); // 토큰을 보내는 사람이 소유주일때만 실행 👉 아니면 에러
        require(from == tokenOwner[tokenId], "NotTokenFrom"); // 토큰이 본인의 토큰일때만 실행 👉 아니면 에러

        _removeTokenFromList(from, tokenId);
        // 밑에서 정의한 함수를 여기서 사용 (토큰을 전송하면 내 목록에서 사라져야하기때문)
        _ownedTokens[to].push(tokenId);
        // 전송후에 상대방이 가지고 있는 토큰배열에 전송받은 토큰을 추가 해주기
        tokenOwner[tokenId] = to; // from은 내 주소(소유쥬) to는 받는사람 토큰의 번호를 입력한다
    }

    function _removeTokenFromList(address from, uint256 tokenId) private {
        // [10, 15, 20, 23] 👈 20번을 삭제하고 싶을때
        // [10, 15, 23, 20] 👈 20번과 23번을 스왑하고 
        // [10, 15, 23] 👈 배열의 마지막 제거
        uint256 lastTokenIndex = _ownedTokens[from].length -1;
        // 👆 배열의 마지막을 선택해주는 변수
        for (uint256 i=0; i< _ownedTokens[from].length; i++) {
            // 반복문실행 소유중인 토큰 번호(배열)
            if (tokenId == _ownedTokens[from][i]) {
                // 삭제하고싶은 토큰번호를 소유주의 배열에서 찾았다면
                // 스왑기능 실행
                _ownedTokens[from][i] = _ownedTokens[from][lastTokenIndex];
                // 배열과 = 배열의 마지막 위치는 같다 선언함으로써 위치 변경
                _ownedTokens[from][lastTokenIndex] = tokenId;
                // 배열의 마지막이 삭제하고 싶은 토큰번호로 스왑됨
                break;
            }
        }
        _ownedTokens[from].length--; // 👈 배열의 맨마지막 제거
    }

    function ownedTokens (address owner) public view returns (uint256[] memory) {
        // 내가 가지고 있는 토큰들 조회
        return _ownedTokens[owner]; // 조회하고자 하는 주소를 입력하면 토큰들(배열)이 나온다
    }

    function setTokenURI (uint256 id, string memory uri) public {
        // 토큰의 이름 바꾸기 함수
        tokenURIs[id] = uri; // 바꾸고자 하는 토큰번호을 입력하고 바꾸고자 하는 토큰명을 입력한다
    }
}

contract NFTMarket {
    function buyNFT(uint256 tokenId, address NFTAddress, address to) public returns (bool) {
        
        NFTSimple(NFTAddress).safeTransferFrom(address(this), to, tokenId);
        // NFTSimple 이 가진 함수들을 호출할수 있다 address(this)는 나의 주소(원래 컨트랙트주소)
        // 나의 주소에서부터 다른 주소(to)로 토큰을 보낼것이다
        // 지갑끼리말고도 컨트랙트끼리 주고 받기가 가능하다
        return true;
    }
}