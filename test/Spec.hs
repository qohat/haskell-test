import Test.Hspec
import Core.Move (Location(..), X(..), Y(..), Direction(..), run)
import System.FilePath ( takeExtension )

main :: IO ()
main = hspec $ do
    describe "Test for Move.run" $ do
        it "Should return (0, 6) North" $ do
            run ['A', 'A', 'A', 'A', 'A', 'A'] Location { _absc = X 0, _orde = Y 0, _dir = North}
                `shouldBe` Location { _absc = X 0, _orde = Y 6, _dir = North } 

        it "Should return (-1, 2) West" $ do
            run ['A', 'A', 'D', 'I', 'I', 'A'] Location { _absc = X 0, _orde = Y 0, _dir = North}
                `shouldBe` Location { _absc = X (-1), _orde = Y 2, _dir = West}

    describe "Test building filePath" $ do    
        it "Should build paths" $ do
            buildPath "/home/quziel/Repos/shipping/" ["hello.txt", "hola.txt", "hi.pdf"]
              `shouldBe` ["/home/quziel/Repos/shipping/hello.txt", "/home/quziel/Repos/shipping/hola.txt"]

buildPath :: FilePath -> [FilePath] -> [FilePath]
buildPath path [] = []
buildPath path fPaths = (path ++) <$> filter (\a -> takeExtension a == ".txt") fPaths
