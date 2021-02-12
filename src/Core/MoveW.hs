{-# LANGUAGE TemplateHaskell #-}

module Core.MoveW where

import Control.Lens

data Direction = North | South | East | West deriving (Show)

newtype X = X {_x :: Int}
makeLenses ''X

newtype Y = Y {_y :: Int}
makeLenses ''Y

data Coordinates = Coordinates {_cx :: X, _cy :: Y}
makeLenses ''Coordinates

data Position = Position {_coord :: Coordinates, _dir :: Direction}
makeLenses ''Position

data Cmd
  = Init {next :: Cmd}
  | End {previous :: Maybe Position}
  | A {previous :: Maybe Position, next :: Cmd}
  | I {previous :: Maybe Position, next :: Cmd}
  | D {previous :: Maybe Position, next :: Cmd}
makePrisms ''Cmd


update :: Cmd -> Position -> Cmd
update a@(A _ n) p = a & (_A . _1) ?~ p -- (_A . _1) .~ (Just p) $ a

fromNorth :: Cmd -> Coordinates -> Position
fromNorth (A _ _) c = Position (c & (cy . y) %~ (+ 1)) North