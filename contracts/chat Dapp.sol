// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "hardhat/console.sol";
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
contract SocialMedia  {
    using SafeMath for uint256;
    address payable owner;
    
    struct user{
        uint256 id;
        string name;
        string details;
        address ad;
    }
    
    struct message{
        uint256 messageId;
        string text;
        string image;
        address to;
        address from;
        uint256 time;
    }
    event userAdded( uint256 id,string name,string details);
    event messageAdded(uint256 messageId,string text,address to,address from,uint256 time);
    event messageEdited(uint256 messageId,string text);

    user[] public users;
    message[] public messages;
    constructor() {
    owner = payable(msg.sender);
    }
      function getUsers()  public  view returns (user[] memory) {
        return users;
    }
    function getMessages() public view returns (message[] memory){
        return messages;
    }
    function addUser(string memory _name,string memory _details ) public {
    
    for(uint i=0; i<users.length; i++){
        require(users[i].ad != msg.sender,"already registered");
    }
        users.push();
        uint256 index = users.length-1;
        users[index].id=index+1;
        users[index].name=_name;
         users[index].ad=msg.sender;
        users[index].details=_details;
        emit userAdded(users[index].id,users[index].name,users[index].details);
    } 
    function getuser(uint256 _ad)public view returns(user memory) {
    return users[_ad];
    }
    function sendMessage(string memory _text,string memory _image , address _to) public{
        messages.push();
        uint256 index = messages.length-1;
        messages[index].messageId=index+1;
        messages[index].text=_text;
        messages[index].image=_image;
        messages[index].to=_to;
        messages[index].from=msg.sender;
        messages[index].time=block.timestamp;
        emit messageAdded(messages[index].messageId,messages[index].text,messages[index].to,messages[index].from,messages[index].time);
    }

    function editMessage(uint256 id,string memory _text) public{
        require(id<messages.length,"message does not exist");
        require(messages[id].from == msg.sender,"You should have send the message to edit it");
        messages[id].text=_text;
        emit messageEdited(messages[id].messageId,messages[id].text);
    }
}