module Adapter.ShippingRepo 
    (ShippingRepository(..))
    where

import Control.Concurrent.Async (mapConcurrently)
import Adapter.RepoConfig (getConf, ShippingConfig(..))
import Domain.Shipping (ShippingRepository(..))
import Core.Move (run, Shipper(..), Location(..), X(..), Y(..), Direction(..), Id (Id))
import qualified Infra.FilesRW as F

toLocation :: F.Line -> Location 
toLocation line = run (show line) Location { _absc = X 0, _orde = Y 0, _dir = North}

toShipper :: F.File -> IO Shipper 
toShipper (F.File (F.Name n) []) = pure $ Shipper (Id n) []
toShipper (F.File (F.Name n) lines) = pure $ Shipper (Id n) $ map toLocation lines

toLine :: Location -> F.Line
toLine location = F.Line (show location) 

toFile :: Shipper -> F.File
toFile (Shipper (Id id) locations) = F.File (F.Name (id ++ ".txt")) $ map toLine locations

instance ShippingRepository IO where
  findAll = do
      config <- getConf
      files <- F.read (F.Folder $ inputFolder config)
      mapConcurrently toShipper files

  save s = do
      config <- getConf
      F.write (F.Folder $ outputFolder config) $ toFile s



