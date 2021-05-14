pragma solidity ^0.8.2;

contract Token {
    
    // total supply available
    uint public totalSupply = 10000 * 10 ** 18;
    string public name = "NickNDrewTestToken";
    string public symbol = "NDT";
    uint public decimals = 18;
    
    // mapping for holder balances
    mapping(address => uint) public balances;
    // mapping to allow for external transfer of token by addresses who are not the owner
    mapping(address => mapping(address=> uint)) public allowance;
    
    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed ownder, address indexed spender, uint amount);
    
    // constructor called on token deployment
    constructor() {
        // on creation of token send totalSupply to owner
        balances[msg.sender] = totalSupply;
    }
    
    // function to read balances            view == readOnly
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    }
    
    // function to transfer tokens
    function transfer(address to, uint amount) public returns(bool) {
        // check balance of sender for enough in wallet
        require(balanceOf(msg.sender) >= amount, 'Balance too low');
        // tranfer to then deduct from
        balances[to] += amount;
        balances[msg.sender] -= amount;
        // emit transfer event after balance updates
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    // function to transfer tokens from one address to another
    function transferFrom(address from, address to, uint amount) public returns(bool) {
        require(balanceOf(from) >= amount, "Balance too low");
        require(allowance[from][msg.sender] >= amount, "Allowance too low");
        balances[to] += amount;
        balances[from] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
    
    // function to approve the spending of tokens
    function approve(address spender, uint amount) public returns(bool) {
        // SPENDER has an allowance of AMOUNT of MSG.SENDER's wallet balance
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
}
