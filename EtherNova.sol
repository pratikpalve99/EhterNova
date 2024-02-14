// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface ERC20Interface{
    function totalSupply() external view returns (uint);

    function balanceOf(address tokenOwner) external view returns (uint balance);

    function transfer(address to, uint tokens) external returns (bool success);


    function allowance(address tokenOwner, address spender) external view returns (uint remaining);

    function approve(address spender, uint tokens) external returns (bool success);

    function transferFrom(
        address from,
        address to,
        uint tokens
    ) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

 contract EtherNova is ERC20Interface{
    string public  name = "EtherNova";
    string public symbol = "ENO";
    int public decimal = 0; 
    uint public override totalSupply;  

    address public founder;
    mapping(address => uint) public balances; 
    mapping(address =>mapping(address=>uint)) allowed;

    constructor(){
        totalSupply=10000;
        founder=msg.sender;
        balances[founder]=totalSupply;  
    }

    function balanceOf(address tokenOwner) public view override returns (uint balance){
            return balances[tokenOwner];
        }

    function transfer(address to, uint tokens) public override returns (bool success){
            require(balances[msg.sender]>=tokens, "You have insuffficient balance");
            balances[to]+=tokens;
            balances[msg.sender]-=tokens;
            emit Transfer(msg.sender, to , tokens);
            return true;
        }
    
    function allowance(address tokenOwner, address spender) public view override returns (uint remaining){
            return allowed[tokenOwner][spender];
    }


    
    function approve(address spender, uint tokens) public override returns (bool success){
            require(balances[msg.sender]>=tokens, "Insufficient balance");
            require(tokens>0, "Cannot send zero tokens");

            allowed[msg.sender][spender]=tokens;
            emit Approval(msg.sender, spender, tokens);
            return true;
    }

    function transferFrom(address from, address to, uint tokens) public override returns (bool success){
            require(allowed[from][msg.sender]>=tokens, "allowed token amount is less");
            require(balances[from]>=tokens, "Insufficient token balance!");
            balances[from] -= tokens;
            allowed[from][msg.sender] -= tokens;
            balances[to] +=tokens;

            emit Transfer(from, to , tokens);
            return true;
    }

}