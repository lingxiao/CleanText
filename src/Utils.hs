-----------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- | 
-- | Module  : Utility Functions
-- | Author  : Xiao Ling
-- | Date    : 8/10/2016
-- |             
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

module Utils where


import Data.ByteString (ByteString)
import Data.Conduit(Conduit, ($$), (=$), ($=), await, yield)
import Data.Text.Encoding (decodeUtf8, encodeUtf8)
import Data.Text (Text, toCaseFold, strip)


{-----------------------------------------------------------------------------
  Text Processing
------------------------------------------------------------------------------}

foldStrip :: Text -> Text
foldStrip = toCaseFold . strip

{-----------------------------------------------------------------------------
  Conduit Bytestring to Text conversion
------------------------------------------------------------------------------}

fromByte :: Monad m => Conduit ByteString m Text
fromByte = awaitWith decodeUtf8

toByte :: Monad m => Conduit Text m ByteString
toByte   = awaitWith encodeUtf8


{-----------------------------------------------------------------------------
  Conduit utils
------------------------------------------------------------------------------}

-- * await input `i` from upstream and apply `g` and output `o`
awaitWith :: Monad m => (i -> o) -> Conduit i m o
awaitWith g = do
  mxs <- await
  case mxs of
    Just xs -> yield (g xs) >> awaitWith g
    Nothing -> return ()

