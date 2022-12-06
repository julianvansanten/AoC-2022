module Parser () where


import Text.Parsec

import Day5.EDSL

-- | Parse a crate with a 
charCrate :: Parser Crate
charCrate = Crate <$> between (char '[') (char ']') letter


-- | Parse a slot with no crate
emptyCrate :: Parser Crate
emptyCrate = EmptyCrate <$ count 3 ' '


-- | Parse a crate or an empty slot
crate :: Parser Crate
crate = charCrate <|> emptyCrate


-- | Parse a line of crates
crateLine :: Parser [Crate]
crateLine = sepBy1 crate (char ' ')


-- | Parse all rows of crates
crateMatrix :: Parser [[Crate]]
crateMatrix = sepEndBy1 crateLine newline


-- | Index list
indexList :: Parser ()
indexList = skipMany1 $ sepBy1 (between (char ' ') (char ' ') (many1 digit)) char ' '