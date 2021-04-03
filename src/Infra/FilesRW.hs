module Infra.FilesRW 
    where

import System.FilePath ( takeExtension, takeBaseName )
import System.Directory ( listDirectory, doesDirectoryExist, createDirectory, createDirectoryIfMissing, removeDirectoryRecursive )

newtype Name = Name String
newtype Line = Line String
instance Show Line where
    show (Line l) = l
newtype Folder = Folder String

data File = File Name [Line]

class Monad m => FilesRW m where 
    read :: Folder -> m [File]
    write :: Folder -> File -> m ()
    create :: Folder -> m FilePath

toFile :: FilePath -> String -> File
toFile fp s = File (Name $ takeBaseName fp) (map Line (lines s))

instance FilesRW IO where
    read (Folder path) = do
        fPaths <- listDirectory path
        let fullPaths = buildPath path fPaths
        readFiles fullPaths
        where
        buildPath :: FilePath -> [FilePath] -> [FilePath]
        buildPath path [] = []
        buildPath path fPaths = (path ++) <$> filter (\a -> takeExtension a == ".txt") fPaths

        readFiles :: [FilePath] -> IO [File]
        readFiles [] = pure []
        readFiles fps = sequence $ (\fps' -> toFile fps' <$> readFile fps') <$> fps

    write (Folder folder) (File (Name n) lns) = do
        path <- create (Folder folder)
        writeFile (folder ++ n) (unlines (map show lns))  
  
    create (Folder path) = do
        _ <- removeFolder path
        _ <- createDirectoryIfMissing True path
        pure path
        where 
        removeFolder :: FilePath -> IO ()
        removeFolder path = do 
            exists <- doesDirectoryExist path
            if exists
                then removeDirectoryRecursive path
                else pure ()
