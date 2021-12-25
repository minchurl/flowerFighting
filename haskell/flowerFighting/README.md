# Flower Fighting

## Welcome!
This is a simple haskell drill after the KAIST class CS220. In this project, I will use IO monad to implement the score-counting in 화투 (Hanafuda, Hwatu).  

Actually, I tried to use "StateT PlayerScoreState IO" Monad Transformer. However, I think it is wasteful to implement simplely. Therefore, I just use "Maybe Monad" property and other things. (In src/temp.hs, you can see the "StateT ..." monad code).  

It is just a drill to review monad after the cs220 class. Therefore, you can see the many immature part in my code (even in the README.md file, since I'm still not good at english.) Feel free to contact me via email (minchurl@kaist.ac.kr) or PR requests. welcome!

## TODO list
- refactoring the error handling!
- change the input interface!

## Commands

You can execute the program by the script.
```
stack build
stack exec flowerFighting-exe
```

Ther exists many commands.
You can input the command in this form. 

```
(what type of command?)
(instance 1 and proper messages..)
(instance 2 and proper messages..)
...
```


### "start" or "restart"
The command initialize score state into 0 and delete all player.


### "exit"
The command will halt the program.

### "add \n (player's name)"
The command will add (player's name) player into the name-score map and initialize the player's score as 0

If there exists a player which has the same name, the program will not add the player and print an error message.

### "delete \n (player's name)"
The command will delete (player's name) player from the name-score map.

If there is no player whose name is (player's name), the program will print an error message.

### "addScore \n (player's name) \n (player's score change)"
The command will add (player's score change) to (play's name)'s score.

If there is no player whose name is (player's name), the program will print an error message.

### "transmit \n (loser's name) \n (winner's name) \n (score change)"

The command will transmit (score change) from (loser's score) to (winner's score)

If there is no player whose name is (loser's name) or whose name is (winner's name), the program will print an error message.




