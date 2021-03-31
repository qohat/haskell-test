module Adapter.RepoConfig 
    (getConf, ShippingConfig(..))
    where

import Data.Maybe (fromJust, fromMaybe)
import System.Environment (lookupEnv)

data ShippingConfig = ShippingConfig { inputFolder :: String, outputFolder :: String }

getConf :: IO ShippingConfig
getConf = do
    inputFolder <- lookupEnv "INPUT_FOLDER"
    outputFolder <- lookupEnv "OUTPUT_FOLDER"
    let inF = fromMaybe "/home/quziel/Repos/files/input" inputFolder
        ouF = fromMaybe "/home/quziel/Repos/files/output" outputFolder
    return $ ShippingConfig inF ouF

