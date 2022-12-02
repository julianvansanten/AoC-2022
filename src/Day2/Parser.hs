module Day2.Parser where


import Text.ParserCombinators.Parsec hiding (spaces)

import Day2.EDSL


spaces :: Parser ()
spaces = skipMany1 space


-- TODO test if implementation correct.
-- TODO implement game parser.

parseOpponentDraw :: Parser Draw
parseOpponentDraw = parseORock <|> parseOPaper <|> parseOScissors


parseMeDraw :: Parser Draw
parseMeDraw = parseMRock <|> parseMPaper <|> parseMScissors


parseORock :: Parser Draw
parseORock = char 'A' >> return Rock

parseOPaper :: Parser Draw
parseOPaper = char 'B' >> return Paper

parseOScissors :: Parser Draw
parseOScissors = char 'C' >> return Scissors


parseMRock :: Parser Draw
parseMRock = char 'X' >> return Rock

parseMPaper :: Parser Draw
parseMPaper = char 'Y' >> return Paper

parseMScissors :: Parser Draw
parseMScissors = char 'Z' >> return Scissors