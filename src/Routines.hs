-----------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- | 
-- | Module  : Subroutines for specific file formats
-- | Author  : Xiao Ling
-- | Date    : 8/10/2016
-- |             
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
 
module Routines where

import Utils

import Control.Monad.Trans.Resource
import Data.ByteString (ByteString)
import Data.Conduit.Binary (sinkFile, sourceFile)
import Data.Conduit(Conduit, ($$), (=$), ($=))
import qualified Data.Conduit.List as C


-- * TODO: twokenize
-- * TODO: number mapping
-- * TOOD: json files
-- * TODO: get rid of the exception and make it into an Either a b thing
path1 :: FilePath
path1 = "/Users/lingxiao/Documents/NLP/Datasets/Toy/imdb_words_short.txt"


{-----------------------------------------------------------------------------
  Clean IMDB Data
------------------------------------------------------------------------------}

imdb :: FilePath -> FilePath -> IO ()
imdb f1 f2 = runResourceT $ sourceFile f1 $$ process =$ sinkFile f2

process :: Monad m => Conduit ByteString m ByteString
process  = fromByte =$ (C.map foldStrip) =$ toByte


{-----------------------------------------------------------------------------
  Clean Yelp Data
------------------------------------------------------------------------------}

yelp :: FilePath -> FilePath -> IO ()
yelp = undefined


{-----------------------------------------------------------------------------
  No conduit

mainSimple :: FilePath -> FilePath  -> IO ()
mainSimple f1 f2 = do
  xxs  <- readFile f1
  let xxs' = unpack . preprocess . pack $ xxs
  writeFile f2 xxs'
    where preprocess = toCaseFold . strip

------------------------------------------------------------------------------}


