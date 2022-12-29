module Day5.Parser (parseFile) where


import Data.List (transpose, isInfixOf, intercalate)
import Data.Char (isLetter)

import Day5.EDSL

import Text.Parsec.String ( Parser )
import Text.Parsec.Language ( emptyDef )
import qualified Text.Parsec.Token as Token
import Text.Parsec ( sepBy1, parse, char )
import qualified Data.Functor.Identity
import qualified Text.Parsec.Prim


-- | Parse the stacks
stacks :: String -> [Stack]
stacks = convert . filter ("" /=) . map (reverse . filter isLetter) . transpose . filter ('[' `elem`) . lines


-- | Convert an array of strings into an array of Stacks
convert :: [String] -> [Stack]
convert = map (Stack . map Crate)


languageDef :: Token.GenLanguageDef String u Data.Functor.Identity.Identity
languageDef = emptyDef {
    Token.reservedNames = [
        "move",
        "from",
        "to"
    ]
}

lexer :: Token.GenTokenParser String u Data.Functor.Identity.Identity
lexer = Token.makeTokenParser languageDef


int :: Text.Parsec.Prim.ParsecT String u Data.Functor.Identity.Identity Int
int = fromIntegral <$> Token.integer lexer

reserved :: String -> Text.Parsec.Prim.ParsecT String u Data.Functor.Identity.Identity ()
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
