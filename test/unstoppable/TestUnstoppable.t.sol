// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/DamnValuableToken.sol";
import "src/unstoppable/UnstoppableVault.sol";
import "src/unstoppable/ReceiverUnstoppable.sol";

/**
 * @dev run "forge test -vvv --match-contract Unstoppable"
 */
contract TestUnstoppable is Test {

    // ether = 10**18    
    uint256 constant TOKENS_IN_VAULT = 1_000_000 ether;
    uint256 constant INITIAL_PLAYER_TOKEN_BALANCE = 10 ether;

    // makeAddr signature:
    // function makeAddr(string memory name) internal returns(address addr);
    // Creates an address derived from the provided name
    // A label is created for the derived address with the provided name used as the label value.
    // https://book.getfoundry.sh/reference/forge-std/make-addr#makeaddr

    // label Signature:
    // function label(address addr, string calldata label) external;
    // Sets a label label for addr in test traces
    // If an address is labelled, the label will show up in test traces instead of the address

    address deployer = makeAddr("deployer");
    address player = makeAddr("player");
    address someUser = makeAddr("someUser");

    ReceiverUnstoppable receiverContract;
    DamnValuableToken token;
    UnstoppableVault vault;
    
    function setUp() public {
        /* SETUP EXERCISE - DON'T CHANGE ANYTHING HERE */
        vm.startPrank(deployer);

        // Deploy DamnValuableToken Contract
        token = new DamnValuableToken();
        vault = new UnstoppableVault(token, deployer /* owner*/, deployer /* fee recipient*/);

        assertEq(address(vault.asset()), address(token));

        token.approve(address(vault), TOKENS_IN_VAULT);
        vault.deposit(TOKENS_IN_VAULT, deployer);

        assertEq(token.balanceOf(address(vault)), TOKENS_IN_VAULT);
        assertEq(vault.totalAssets(), TOKENS_IN_VAULT);
        assertEq(vault.totalSupply(), TOKENS_IN_VAULT);
        assertEq(vault.maxFlashLoan(address(token)),TOKENS_IN_VAULT);
        assertEq(vault.flashFee(address(token), TOKENS_IN_VAULT - 1), 0);
        assertEq(vault.flashFee(address(token), TOKENS_IN_VAULT), 50_000 ether);

        token.transfer(player, INITIAL_PLAYER_TOKEN_BALANCE);
        assertEq(token.balanceOf(player), INITIAL_PLAYER_TOKEN_BALANCE);

        vm.stopPrank();

        // Show it's possible for someUser to take out a flash loan
        vm.startPrank(someUser);
        receiverContract = new ReceiverUnstoppable(address(vault));
        receiverContract.executeFlashLoan(100 ether);
        vm.stopPrank();
    }

    function testUnstoppable() public {
        /** CODE YOUR SOLUTION HERE */

        /** SUCCESS CONDITIONS - NO NEED TO CHANGE ANYTHING HERE */
        // It is no longer possible to execute flash loans
        vm.startPrank(someUser);
        vm.expectRevert();
        receiverContract.executeFlashLoan(100 ether);
        vm.stopPrank();
    }
}