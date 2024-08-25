// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/**
 * Anyone can send the native token to the piggy bank but only the OWNER can withdraw it
 */
contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}