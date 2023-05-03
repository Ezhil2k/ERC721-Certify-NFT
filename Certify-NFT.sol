//SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

string constant name="CerfityNFT";
string constant symbol = "CNFT";

contract Certify is ERC721 (name, symbol) {
    struct TokenMetadata { 
        string product;
        string grading_criteria;
        string score;
        uint256 price;
    }
    mapping(uint256 => TokenMetadata) private _tokenMetadata;

    function create_token (address t_address, uint256 t_id) external {
        _safeMint (t_address, t_id);
    }

    function setTokenMetadata(uint256 tokenId, string memory _product, string memory _grading, string memory _score, uint256 _price) external {
        require(_exists(tokenId), "Mentioned token is not minted"); 
        _tokenMetadata[tokenId].product = _product;
        _tokenMetadata[tokenId].grading_criteria = _grading; 
        _tokenMetadata[tokenId].score = _score;
        _tokenMetadata[tokenId].price = _price;
    }

    function getTokenMetadata(uint256 tokenId) public view returns (TokenMetadata memory) { 
        require(_exists(tokenId), "Mentioned token is not minted"); 
        return _tokenMetadata[tokenId];
    }
    
    function transferOwner (address payable from_add, address payable to_add, uint256 t_id) external payable {
        require(msg.value== _tokenMetadata[t_id].price * 1 ether, "Transfer the required amount"); 
        from_add.transfer (msg.value); 
        safeTransferFrom(from_add, to_add, t_id);
    }
    
    function giveapproval (address add_to, uint256 t_id) external { 
        approve (add_to, t_id);
    }


}
