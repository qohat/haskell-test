import Test.Hspec
import System.FilePath ( takeExtension )
import qualified Infra.FilesRW as F

main :: IO ()
main = hspec $ do
    describe "Test building filePath" $ do    
        it "Should build paths" $ do
            buildPath "/home/quziel/Repos/shipping/" ["hello.txt", "hola.txt", "hi.pdf"]
              `shouldBe` ["/home/quziel/Repos/shipping/hello.txt", "/home/quziel/Repos/shipping/hola.txt"]

        it "Should read a file" $ do
            F.read (F.Folder "/home/quziel/Repos/files") `shouldBe` 
                      


buildPath :: FilePath -> [FilePath] -> [FilePath]
buildPath path [] = []
buildPath path fPaths = (path ++) <$> filter (\a -> takeExtension a == ".txt") fPaths