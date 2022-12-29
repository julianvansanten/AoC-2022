module Day4.Parser (
    parseStr
) where


import Text.ParserCombinators.Parsec
import Day4.EDSL


int :: Parser Int
int = read <$> many1 digit


-- | Parse the range an Elf is responsible for
parseElf :: Parser Elf
parseElf = Elf <$> int <* char '-' <*> int


parsePair :: Parser Pair
parsePair = Pair <$> parseElf <* char ',' <*> parseElf


parsePairs :: Parser Pairs
parsePairs = Pairs <$> parsePair `sepBy1` newline


parseStr :: String -> Either ParseError Pairs
parseStr = parse parsePairs ""