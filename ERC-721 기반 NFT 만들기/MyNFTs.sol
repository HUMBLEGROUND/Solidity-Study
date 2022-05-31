//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFTs is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // 👉 함수 mintNFT 는 라이브러리 Counters 를 이용해 변수 토큰의 ID(_tokenIds)를 관리한다

    constructor() ERC721("MyNFTs", "MNFT") {}

    // 함수 mintNFT 는 컨트랙트 MyNFTs 에 포함된 함수이다
    // 이 함수는 컨트랙트의 오너(owner)만이 새로운 토큰을 생성할 수 있게하는 함수이다
    // 👉 함수 mintNFT 는 컨트랙트 Ownable 에 포함된 onlyOwner를 통해,
    // 👉 함수를 실행한 지갑의 주소와 오너의 주소가 같은지 검사한다
    // 👉 만약 함수를 실행한 지갑의 주소와 오너의 주소가 같다면, 함수를 정상적으로 실행한다
    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}
// NFT를 생성할 때, 파라미터 tokenURI 를 전달한다
// tokenURI 는 NFT에 적용할 정보를 담고 있는 json 객체의 엔드포인트이다
// 다시 말해, tokenURI 에 접근하면 NFT의 규칙에 맞는 json 객체를 불러올 수 있어야 함
