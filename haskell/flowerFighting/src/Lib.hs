{-# LANGUAGE FlexibleInstances, TupleSections, DeriveGeneric #-}

module Lib
    ( PlayerScoreState(..)
    , test
    , todo
    , someFunc
    , (|>)
    ) where


import System.IO.Unsafe ()
import           GHC.Generics                   ( Generic )
import           Generic.Random
import           Test.Tasty.QuickCheck         as QC
                                         hiding ( (.&.) )

import           Control.Monad.State.Lazy
import           Data.Bits
import           Data.Map                      as Map
import           Data.Maybe
import           Data.Word
import           Prelude                 hiding ( read )

newtype Name = Name String deriving (Eq, Ord, Show)
newtype Score = Score Integer deriving (Eq, Ord, Show)

class Monad m => PlayerScoreState m where
    isPlayerExist :: Name -> m (Maybe ())
    addPlayer :: Name -> m (Maybe ())
    deletePlayer :: Name -> m (Maybe ())
    addPlayerScore :: Name -> Score -> m (Maybe ())
    transmitScore :: Name -> Name -> Score -> m (Maybe ())
    printPlayerScore :: Name -> m (Maybe ())
    printAllPlayerScore :: m ()

newtype PlayerScore = PlayerScore (Map Name Score) deriving (Eq, Ord, Show, Generic)

-- same implementation with PlayerScoreState (State PlayerScore)
instance PlayerScoreState (StateT PlayerScore IO) where
    isPlayerExist name = do
        PlayerScore playerScore <- get
        let isExist = playerScore  |> Map.lookup name
        case isExist of
            Just _ -> return $ Just ()
            Nothing -> return Nothing

    addPlayer name = do
        PlayerScore playerScore <- get
        let isExist = playerScore |> Map.lookup name
        case isExist of
            Just _ -> return Nothing
            Nothing -> do
                playerScore |> Map.insert name (Score 0) |> PlayerScore |> put
                return $ Just ()

    deletePlayer name = do
        PlayerScore playerScore <- get
        let isExist = playerScore  |> Map.lookup name
        case isExist of
            Nothing -> return Nothing
            _ -> do
                playerScore |> Map.delete name |> PlayerScore |> put
                return $ Just ()

    addPlayerScore name score = do
        PlayerScore playerScore <- get
        let playerState = playerScore |> Map.lookup name
        case playerState of
            Nothing -> return Nothing
            Just currentScore -> do
                deletePlayer name
                playerScore |> Map.insert name (addScore currentScore score) |> PlayerScore |> put
                return $ Just ()

    transmitScore name1 name2 score = do
        -- trash code... need to refactoring!
        res1 <- isPlayerExist name1
        res2 <- isPlayerExist name2
        case res1 of
            Nothing -> return  Nothing
            _ ->
                case res2 of
                    Nothing -> return Nothing
                    _ -> do
                        addPlayerScore name1 (minusScore score)
                        addPlayerScore name2 score
                        return $ Just ()

    printPlayerScore name = do
        PlayerScore playerScore <- get
        let isExist = playerScore |> Map.lookup name
        case isExist of 
            Nothing -> return Nothing 
            Just score -> do 
                lift $ print score
                return $ Just ()


    printAllPlayerScore = do
        PlayerScore playerScore <- get
        lift $ print playerScore


(|>) :: v1 -> (v1 -> v2) -> v2
x |> f = f x

addScore :: Score -> Score -> Score
addScore a b = Score $ c + d
    where
        Score c = a
        Score d = b
minusScore :: Score -> Score
minusScore a = Score (-b)
    where Score b = a

someFunc :: IO ()
someFunc = do
   putStrLn "someFunc"

todo :: t
todo = error "todo"


testState :: (StateT PlayerScore IO) ()
testState = do
    addPlayer (Name "a")
    addPlayer (Name "b")
    addPlayer (Name "c")
    addPlayerScore (Name "a") (Score 100)
    printAllPlayerScore
    printPlayerScore (Name "a")
    return ()


test = runStateT testState (PlayerScore Map.empty)

