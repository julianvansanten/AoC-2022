{-# OPTIONS_GHC -Wmissing-signatures #-}
module Day5.Parser (runElvenCrates) where


import Text.Parsec.String (Parser)
import Text.Parsec.Language

import Control.Monad (void)

import Day5.EDSL
import Text.Parsec
import qualified Text.Parsec.Token as Token


languageDef = emptyDef {
    Token.reservedNames = [
        "move",
        "from",
        "to"
    ]
}

lexer = Token.makeTokenParser languageDef

reserved = Token.reserved lexer
brackets = Token.brackets lexer
integer = Token.integer lexer


-- | Convert any integral to Int
toInt :: (Integral a) => a -> Int
toInt = fromIntegral


-- | Int parser
int :: Parser Int
int = toInt <$> integer


-- | Parse a single crate with a character in it
charCrate :: Parser Crate
charCrate = Crate <$> brackets letter


-- | Parse a slot with no crate
emptyCrate :: Parser Crate
emptyCrate = EmptyCrate <$ count 3 (char ' ')


-- | Parse a crate or an empty slot
crate :: Parser Crate
crate = charCrate <|> emptyCrate


-- | Parse a line of crates
crateLine :: Parser [Crate]
crateLine = sepBy1 crate (char ' ')


-- | Parse all rows of crates
crateMatrix :: Parser [[Crate]]
crateMatrix = sepEndBy1 crateLine newline


-- | Ignore the index list
indexList :: Parser ()
indexList = void $ many (space <|> digit)



-- | Parse a move
move :: Parser Move
move = do
    reserved "move"
    c <- int
    reserved "from"
    from <- int
    reserved "to"
    Move c from <$> int


-- | Parse all moves and put them in a list
moves :: Parser [Move]
moves = sepEndBy1 move newline


-- | Parse the entire elven crates
elvenCrates :: Parser ElvenCrates
elvenCrates = do
    matrix <- crateMatrix
    indexList
    ElvenCrates matrix <$> moves


{- | Run the parser ElvenCrate and return the result as a string
    If the result is a ParseError, just error the entire program
-}
runElvenCrates :: String -> ElvenCrates
runElvenCrates str = do
    let res = parse elvenCrates "" str
    case res of
        Left pe -> error $ show pe
        Right ec -> ec
