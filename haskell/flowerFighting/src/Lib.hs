{-# LANGUAGE FlexibleInstances, TupleSections, DeriveGeneric #-}

module Lib
    (
      isPlayerExist
    , getPlayerScore
    , addPlayer
    , deletePlayer
    , addPlayerScore
    , transmitScore
    , todo
    , someFunc
    , (|>)
    ) where


import System.IO.Unsafe ()
import           GHC.Generics                   ( Generic, D )

import           Control.Monad.State.Lazy
import           Data.Bits
import           Data.Map                      as Map
import           Data.Maybe
import           Data.Word
import           Prelude                 hiding ( read )

newtype Name = Name String deriving (Eq, Ord, Show)
newtype Score = Score Int deriving (Eq, Ord, Show)
newtype PlayerScoreMap = PlayerScoreMap (Map Name Score) deriving (Eq, Ord, Show, Generic)

isPlayerExist :: PlayerScoreMap -> Name -> Maybe ()
isPlayerExist playerScoreMap name = do
    let (PlayerScoreMap m) = playerScoreMap
    Map.lookup name m
    return ()

getPlayerScore :: PlayerScoreMap -> Name -> Maybe Score
getPlayerScore playerScoreMap name = do
    let (PlayerScoreMap m) = playerScoreMap
    Map.lookup name m

addPlayer :: PlayerScoreMap -> Name -> Maybe PlayerScoreMap
addPlayer playerScoreMap name = do
    reverseMaybe $ isPlayerExist playerScoreMap name
    let (PlayerScoreMap m) = playerScoreMap
    let mm = Map.insert name (Score 0) m
    return (PlayerScoreMap mm)

deletePlayer :: PlayerScoreMap -> Name -> Maybe PlayerScoreMap
deletePlayer playerScoreMap name = do
    isPlayerExist playerScoreMap name
    let (PlayerScoreMap m) = playerScoreMap
    let mm = Map.delete name m
    return (PlayerScoreMap mm)

addPlayerScore :: PlayerScoreMap -> Name -> Score -> Maybe PlayerScoreMap
addPlayerScore playerScoreMap name scoreChange = do
    presentScore <- getPlayerScore playerScoreMap name
    let (PlayerScoreMap m) = playerScoreMap
    let mm = Map.insert name (addScore presentScore scoreChange) m
    return (PlayerScoreMap mm)

transmitScore :: PlayerScoreMap -> Name -> Name -> Score -> Maybe PlayerScoreMap
transmitScore playerScoreMap loser winner scoreChange = do
    isPlayerExist playerScoreMap loser
    isPlayerExist playerScoreMap winner
    m <- addPlayerScore playerScoreMap loser (minusScore scoreChange)
    addPlayerScore m winner scoreChange


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

reverseMaybe :: Maybe () -> Maybe ()
reverseMaybe x =
    case x of
        Just () -> Nothing
        Nothing -> Just ()

todo :: t
todo = error "todo"