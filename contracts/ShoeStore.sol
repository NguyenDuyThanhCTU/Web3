// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ShoeStore {
    struct Shoe {
        address owner;
        uint256 id;
        string name;
        string description;
        string introduction;
        string url;
        string color;
        string image;
        uint256 price;
        address[] buyers;
        string[] functions;
        bool state;
        string typeurl;
        string parenturl;
        uint256 discount;
        uint256 newprice;
        uint256 limitspeed;
        uint256 limitdistance;
        uint256 limitcoinearning;
        uint256 limittime;
        bool nightmode;
        bool test;
    }

    mapping(uint256 => Shoe) public shoes;

    uint256 public numberOfShoes = 0;

    function createShoe(
        address _owner,
        string memory _name,
        string memory _description,
        string memory _introduction,
        string memory _url,
        string memory _color,
        string memory _image,
        uint256 _price,
        string memory _typeurl,
        string memory _parenturl,
        uint256 _discount,
        uint256 _newprice,
        uint256 _limitspeed,
        uint256 _limitdistance,
        uint256 _limitcoinearning,
        uint256 _limittime,
        bool _nightmode,
        bool _test
    ) public returns (uint256) {
        Shoe storage shoe = shoes[numberOfShoes];

        shoe.owner = _owner;
        shoe.name = _name;
        shoe.description = _description;
        shoe.introduction = _introduction;
        shoe.url = _url;
        shoe.color = _color;
        shoe.image = _image;
        shoe.price = _price;
        shoe.typeurl = _typeurl;
        shoe.parenturl = _parenturl;
        shoe.discount = _discount;
        shoe.newprice = _newprice;
        shoe.limitspeed = _limitspeed;
        shoe.limitdistance = _limitdistance;
        shoe.limitcoinearning = _limitcoinearning;
        shoe.limittime = _limittime;
        shoe.nightmode = _nightmode;
        shoe.test = _test;

        numberOfShoes++;
        return numberOfShoes - 1;
    }

    function buyShoe(uint256 _id) public payable {
        uint256 price = msg.value;
        Shoe storage shoe = shoes[_id];
        shoe.buyers.push(msg.sender);

        if (shoe.discount > 0) {
            price = shoe.newprice;
        }
        (bool sent, ) = payable(shoe.owner).call{value: price}("");
        require(sent, "Failed to send Ether");
    }

    function getShoeBuyers(uint256 _id) public view returns (address[] memory) {
        return shoes[_id].buyers;
    }

    function getShoe(uint256 _id) public view returns (Shoe memory) {
        return shoes[_id];
    }

    function getShoeCount() public view returns (uint256) {
        return numberOfShoes;
    }

    function getAllShoes() public view returns (Shoe[] memory) {
        Shoe[] memory _shoes = new Shoe[](numberOfShoes);
        for (uint256 i = 0; i < numberOfShoes; i++) {
            _shoes[i] = shoes[i];
        }
        return _shoes;
    }
}
