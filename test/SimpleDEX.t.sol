// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/SimpleDEX.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1000000 * 10**18);
    }
}

contract SimpleDEXTest is Test {
    SimpleDEX public dex;
    MockERC20 public token1;
    MockERC20 public token2;
    address user = address(1);

    function setUp() public {
        dex = new SimpleDEX();
        token1 = new MockERC20("Token1", "TK1");
        token2 = new MockERC20("Token2", "TK2");
    }

    function testDeposit() public {
        uint256 amount = 100 * 10**18;
        token1.transfer(user, amount);
        
        vm.startPrank(user);
        token1.approve(address(dex), amount);
        dex.deposit(address(token1), amount);
        vm.stopPrank();

        assertEq(dex.tokenBalances(user, address(token1)), amount);
    }

    // TODO: Add more tests for withdraw and swap functions
}