module Application.ShippingService 
    (ShippingService(..))
    where

import Control.Concurrent.Async (mapConcurrently)
import Core.Move (Shipper(..),X (X, _x), Y (Y, _y), Location (_orde, _absc))
import Application.ServiceConfig (ServiceConfig (shippingCoverage, maxShipments), getConfig)
import qualified Adapter.ShippingRepo as R

class Monad m => ShippingService m where
    execute :: m [()]

instance ShippingService IO where
    execute = do
        config <- getConfig
        shippers <- R.findAll
        let coveredShippers = coveredLocations config <$> shippers
        let shippersTaken = takeMaxLocations config <$> coveredShippers
        saveAll shippersTaken
        where
            saveAll :: [Shipper] -> IO [()]
            saveAll shippers = sequence $ R.save <$> shippers
        

coveredLocations, takeMaxLocations :: ServiceConfig -> Shipper -> Shipper
coveredLocations config (Shipper id locations) = 
    Shipper id $ filterLocations config locations

takeMaxLocations config (Shipper id locations) =
    Shipper id $ take (maxShipments config) locations

filterLocations :: ServiceConfig -> [Location] -> [Location]
filterLocations config = filter
      (\ l
         -> abs (_x (_absc l)) <= shippingCoverage config
              && abs (_y (_orde l)) <= shippingCoverage config)

