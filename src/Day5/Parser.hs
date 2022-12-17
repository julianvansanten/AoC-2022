module Day5.Parser (parseFile) where


import Data.List (transpose, isInfixOf, intercalate)
import Data.Char (isLetter)

import Day5.EDSL

import Text.Parsec.String
import Text.Parsec.Language
import qualified Text.Parsec.Token as Token
import Text.Parsec ( sepBy1, parse, char )


-- | Parse the stacks
stacks :: String -> [Stack]
stacks = convert . filter ("" /=) . map (reverse . filter isLetter) . transpose . filter ('[' `elem`) . lines


-- | Convert an array of strings into an array of Stacks
convert :: [String] -> [Stack]
convert = map (Stack . map Crate)


languageDef = emptyDef {
    Token.reservedNames = [
        "move",
        "from",
        "to"
    ]
}

lexer = Token.makeTokenParser languageDef


int = fromIntegral <$> Token.integer lexer

reserved = Token.reserved lexer


move :: Parser Move
move = do
    reserved "move"
    c <- int
    reserved "from"
    from <- (\x -> x - 1) <$> int
    reserved "to"
    Move c from . (\x -> x - 1) <$> int


moves :: Parser [Move]
moves = sepBy1 move (char ',')


-- | Filter all strings that do not contain the keyword "move"
filterMoves :: String -> String
filterMoves = intercalate "," . filter (isInfixOf "move") . lines


-- | Run the parser
runMoves :: String -> [Move]
runMoves str = do
    let res = parse moves "" str
    case res of
        Left pe -> error $ show pe
        Right mos -> mos


parseFile :: String -> ([Stack], [Move])
parseFile str = (sts, mvs)
    where
        sts = stacks str
        mvs = runMoves (filterMoves str)
