module Application.ShippingService 
    where

import Control.Concurrent.Async (mapConcurrently)
import Core.Move (Shipper(..),X (X))
import Application.ServiceConfig (ServiceConfig (shippingCoverange, maxShipments), getConfig)
import qualified Adapter.ShippingRepo as R

class Monad m => ShippingService m where
    execute :: m ()

instance ShippingService IO where
    execute = do
        config <- getConfig
        shippers <- R.findAll
        mapConcurrently a -> IO b t a
        

coveredLocations :: ServiceConfig -> Shipper -> Shipper
coveredLocations config (Shipper id locations) = 
    Shipper id <$> filter (\l -> X l <= shippingCoverange config && Y l <= shippingCoverange config) locations

takeMaxLocations :: ServiceConfig -> Shipper -> Shipper
takeMaxLocations config (Shipper id locations) =
    Shipper id $ take (maxShipments config) locations