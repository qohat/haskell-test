module TypeClasses.Begining 
    where

-- Overloading classes

-- elemBool :: Bool -> [Bool] -> Bool
-- elemBool x [] = False 
-- elemBool x (y:ys) = (x == Bool y) || elemBool x ys

-- elemInt :: Int -> [Int] -> Bool 
-- elemGem :: (a -> a -> Bool) -> a -> [a] -> Bool

-- elem :: Eq a => a -> [a] -> Bool


-- allEqual :: Eq a => a -> a -> a -> Bool
-- allEqual m n p = (m == n) && (n == p)


-- class Visible a where
    -- toString :: a -> String 
    -- size :: a -> Int 

-- instance Visible Char where
    -- toString ch = [ch]
    -- size _ = 1

-- instance Visible a => Visible [a] where
    -- toString = concat . map toString
    -- size = foldr (+) 1 . map size