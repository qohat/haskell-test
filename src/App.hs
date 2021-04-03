module App
    ( app
    ) where

import qualified Application.ShippingService as S

app :: IO ()
app = do
    _ <- S.execute
    putStrLn "Service Was Executed Successfully"
