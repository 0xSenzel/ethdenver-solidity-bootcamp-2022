# Team Game Solution
1. Start by registering team and enter team password at this [site](https://lottery.extropy.live/)

Given two smart contract, first is [Lottery.sol](./Lottery.sol) for us to make guessing and win payout. The second is [Oracle.sol](./Oracle.sol) which is interface contract used by Lottery.sol to get random number as answer of guessing

2. Our team managed to play around and figured out once our score hits 0 and make a wrong guess again, the score would underflow and give us the max value of said integer of the score.

3. Once our score is underflow / equal to 100 we can call `payoutWinningTeam()` to get our ether. We tried to write an attack contract to exploit this flaws by using the logic of: underflow to obtain score eligible to win payout > withdraw payout > rinse and repeat. However we ran out of time.

## Standard Approach
Shared by instructor, our standard approach (if this contract is designed with no such flaws mentioned above) we should find out the seed which the Oracle.sol used to generate random number since the generation of random number is through `block.number % seed` formula.

We can easily find the seed in block explorer as the seed is initialized during contract creation so we can obtain the value and write a contract to compute the outcome of random number when calling the guessing function.

Side Note:

There are also alot of play pattern not just our own score that is the focus of the game. We can also:
-  Make wrong guesses by using other team address 
- Reset other team's score by registering them again
