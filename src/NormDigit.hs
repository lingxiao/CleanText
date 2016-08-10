-----------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
-- | 
-- | Module  : Utilities to normalize numbers
-- | Author  : Xiao Ling
-- | Date    : 8/9/2016
-- |             
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


module NormDigit where


--import qualified Data.Text as T
--import qualified Data.Text.ICU as ICU
 
{-----------------------------------------------------------------------------
  TODOs: 
  
  Decision: Use parsec to build up a tokenizer library


  consider parsec or this:
    https://hackage.haskell.org/package/regex-applicative

  Note these functions should be pure and can be verified
  both ad hocly and also using quick check
------------------------------------------------------------------------------}








{-----------------------------------------------------------------------------
	Depricated

-- * each number is replaced by a 0
normDigit :: Monad m => Conduit T.Text m T.Text
normDigit = undefined

-- * each sequence of numbers is replaced by some token `a`
tokDigit :: Monad m => T.Text -> Conduit T.Text m T.Text
tokDigit  = undefined

re1', re2', re3' :: T.Text
re1' = T.pack "\\d"
re2' = T.pack "\\d+\\.?\\d+"
re3' = T.pack "(\\d{1,3},)+\\d{3}(\\.\\d{1,3})?"

re1, re2, re3 :: ICU.Regex
re1 = ICU.regex [] re1'
re2 = ICU.regex [] re2'
re3 = ICU.regex [] re3'

re :: ICU.Regex
re = undefined

fnd :: ICU.Regex -> String -> Maybe ICU.Match
fnd re = ICU.find re . T.pack

-- * the way this works is that any
-- * sequence of text with digits will be replaced
-- * wholly by the output of `f`
replace :: ICU.Regex -> T.Text -> Maybe ICU.Match
replace re xs = ICU.find re xs


digits :: ICU.Regex
digits = ICU.regex [] $ T.pack "\\d+(\\.\\d+)?"


-- * todo: quick check this stuff
(Just m1) = ICU.find digits $ T.pack "12.34"
(Just m2) = ICU.find digits $ T.pack "kworld123"
(Just m3) = ICU.find digits $ T.pack "133kworld"

------------------------------------------------------------------------------}



