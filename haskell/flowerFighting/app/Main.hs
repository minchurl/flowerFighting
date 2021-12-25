module Main where

import Lib
import           Data.Map                      as Map


main :: IO ()
main = do 
   putStr "Hello world!\n"
   putStr "please see the readme page to see the command :)\n"
   loop (PlayerScoreMap Map.empty)

   where
      loop playerScoreMap = do 


