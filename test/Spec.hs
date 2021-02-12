import Test.Hspec
import Core.Move (Location(..), X(..), Y(..), Direction(..), run)

main :: IO ()
main = hspec $ do
    describe "Test for Move.run" $ do
        it "Should return (-1, 2) West" $ do
            run ['A', 'A', 'D', 'I', 'I', 'A'] Location { _absc = X 0, _orde = Y 0, _dir = North}
                `shouldBe` Location { _absc = X (-1), _orde = Y 2, _dir = West}

        it "Should return (0, 6) North" $ do
            run ['A', 'A', 'A', 'A', 'A', 'A'] Location { _absc = X 0, _orde = Y 0, _dir = North}
                `shouldBe` Location { _absc = X 0, _orde = Y 6, _dir = North }        

