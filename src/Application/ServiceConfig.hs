module Application.ServiceConfig where

import Data.Maybe (fromJust, fromMaybe)
import System.Environment (lookupEnv)
    
data ServiceConfig = ServiceConfig { maxShipments :: Int, shippingCoverage :: Int }

getConfig :: IO ServiceConfig
getConfig = do
    maxShipments <- lookupEnv "MAX_SHIPMENTS"
    shippingCov <- lookupEnv "SHIPPING_COVERAGE"
    let mShip = fromMaybe "3" maxShipments
        shipCov = fromMaybe "10" shippingCov
    return $ ServiceConfig (toInt mShip) (toInt shipCov)

toInt :: String -> Int 
toInt v = read v :: Int