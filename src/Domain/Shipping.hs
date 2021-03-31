module Domain.Shipping 
    (ShippingRepository(..))
    where

import Core.Move (Shipper(..))

class (Monad a) => ShippingRepository a where
    findAll :: a [Shipper]
    save :: Shipper -> a ()