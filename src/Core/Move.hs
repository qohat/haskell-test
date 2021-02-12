{-# LANGUAGE TemplateHaskell #-}

module Core.Move
    (Location(..), X(..), Y(..), Direction(..), run)
    where

import Control.Lens

newtype Id = Id {_id :: String}

newtype X = X {_x :: Int} deriving (Show, Eq)
makeLenses ''X

newtype Y = Y {_y :: Int} deriving (Show, Eq)
makeLenses ''Y

data Direction = North | South | West | East deriving (Show, Eq)

data Location = Location { _absc :: X, _orde :: Y, _dir :: Direction } deriving (Show)
makeLenses ''Location
instance Eq Location where
    (==) l1 l2 = _absc l1 == _absc l2 && _orde l1 == _orde l2 && _dir l1 == _dir l2
    (/=) l1 l2 = _absc l1 /= _absc l2 && _orde l1 /= _orde l2 && _dir l1 /= _dir l2

data Shipper = Shipper { id :: Id, locations :: [Location] }

turnRight :: Location -> Location
turnRight l @ (Location _ _ North) = l & dir .~ East
turnRight l @ (Location _ _ East) = l & dir .~ South
turnRight l @ (Location _ _ South) = l & dir .~ West
turnRight l @ (Location _ _ West) = l & dir .~ North

turnLeft :: Location -> Location
turnLeft l @ (Location _ _ North) = l & dir .~ West
turnLeft l @ (Location _ _ West) = l & dir .~ South
turnLeft l @ (Location _ _ South) = l & dir .~ East
turnLeft l @ (Location _ _ East) = l & dir .~ North

forward :: Location -> Location
forward l @ (Location _ y North) = l & orde .~ Y (_y y + 1)
forward l @ (Location _ y South) = l & orde .~ Y (_y y - 1)
forward l @ (Location x _ East) = l & absc .~ X (_x x + 1)
forward l @ (Location x _ West) = l & absc .~ X (_x x - 1)
 
move :: Char -> Location -> Location 
move 'A' l = forward l
move 'D' l = turnRight l
move 'I' l = turnLeft l
move _ l = l

run :: [Char] -> Location -> Location
--run [] l = l
--run (h:t) l = run t (move h l)
run t l = foldl (flip move) l t
