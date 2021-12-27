module Main where

import Lib
import Text.Read
import System.IO
import Control.Monad
import GHC.IO.Handle
import           GHC.Generics                   ( Generic, D )

import           Control.Monad.State.Lazy
import           Data.Bits
import           Data.Map                      as Map
import           Data.Maybe
import           Data.Word
import           Prelude                 hiding ( read )


addPlayerHandler :: PlayerScoreMap -> IO PlayerScoreMap
addPlayerHandler playerScoreMap = do 
    putStr "(player's name): "
    nameString <- getLine
    let userName = Name nameString
    case addPlayer playerScoreMap userName of 
        Just newPlayerScoreMap -> do 
            putStr nameString
            putStrLn " is successfully added in the player-score map!"
            return newPlayerScoreMap
        Nothing -> do 
            putStr nameString
            putStrLn " already exists in the player-score map!"
            return playerScoreMap

deletePlayerHandler :: PlayerScoreMap -> IO PlayerScoreMap
deletePlayerHandler playerScoreMap = do 
    putStr "(player's name): "
    nameString <- getLine
    let userName = Name nameString
    case deletePlayer playerScoreMap userName of 
        Just newPlayerScoreMap -> do 
            putStr nameString
            putStrLn " is successfully deleted in the player-score map!"
            return newPlayerScoreMap
        Nothing -> do 
            putStr nameString
            putStrLn " is not exist in the player-score map!"
            return playerScoreMap

addPlayerScoreHandler :: PlayerScoreMap -> IO PlayerScoreMap
addPlayerScoreHandler playerScoreMap = do 
    putStr "(player's name): "
    nameString <- getLine
    putStr "(player's score change): "
    scoreString <- getLine
    let userName = Name nameString

    case (readMaybe scoreString :: Maybe Int) of 
        Just scoreInt -> do 
            let scoreChange = Score scoreInt
            case addPlayerScore playerScoreMap userName scoreChange of 
                Just newPlayerScoreMap -> do 
                    putStr nameString
                    putStrLn "'s score is successfully changed!"
                    return newPlayerScoreMap
                Nothing -> do 
                    putStr nameString
                    putStrLn " is not exist in the player-score map!"
                    return playerScoreMap
        Nothing -> do 
            putStr scoreString
            putStrLn " is not a number!"
            return playerScoreMap

transmitScoreHandler :: PlayerScoreMap -> IO PlayerScoreMap
transmitScoreHandler playerScoreMap = do
    putStr "(loser's name): "
    loserString <- getLine
    putStr "(winner's name): "
    winnerString <- getLine

    putStr "(score change): "
    scoreString <- getLine
    let loserName = Name loserString
    let winnerName = Name winnerString

    case (readMaybe scoreString :: Maybe Int) of 
        Just scoreInt -> do 
            let scoreChange = Score scoreInt
            case transmitScore playerScoreMap loserName winnerName scoreChange of 
                Just newPlayerScoreMap -> do 
                    putStrLn "The transmition is successfully reflected!"
                    return newPlayerScoreMap
                Nothing -> do 
                    putStrLn "loser's or winner's name is wrong!"
                    return playerScoreMap
        Nothing -> do 
            putStr scoreString
            putStrLn " is not a number!"
            return playerScoreMap

printScoreHandler :: PlayerScoreMap -> IO ()
printScoreHandler playerScoreMap = do 
    putStr "(player's name): "
    nameString <- getLine
    let userName = Name nameString

    case getPlayerScore playerScoreMap userName of 
        Just score -> do 
            putStr nameString
            putStr "'s score is "
            print score
            return ()
        Nothing -> do 
            putStr nameString
            putStrLn " is not exist in the player-score map!"
            return ()

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    loop (PlayerScoreMap Map.empty)
    return ()
    where
        loop playerScoreMap = do 
            putStr "\n\n"
            putStrLn "please input the type of command!"
            commandType <- getLine 
            case commandType of 
                "exit" -> return ()

                "restart" -> loop (PlayerScoreMap Map.empty)

                "addPlayer" -> do 
                    newPlayerScoreMap <- addPlayerHandler playerScoreMap
                    loop newPlayerScoreMap

                "deletePlayer" -> do 
                    newPlayerScoreMap <- deletePlayerHandler playerScoreMap
                    loop newPlayerScoreMap

                "addPlayerScore" -> do 
                    newPlayerScoreMap <- addPlayerScoreHandler playerScoreMap 
                    loop newPlayerScoreMap

                "transmitScore" -> do 
                    newPlayerScoreMap <- transmitScoreHandler playerScoreMap 
                    loop newPlayerScoreMap

                "printScore" -> do 
                    printScoreHandler playerScoreMap
                    loop playerScoreMap
                
                "printAllScore" -> do 
                    print playerScoreMap
                    loop playerScoreMap

                _ -> do 
                    putStrLn "The command is not valid..."
                    loop playerScoreMap
