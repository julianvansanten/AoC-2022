module Day2.Parser (
        runGames1,
        runGames2
    )
    where


import Text.ParserCombinators.Parsec hiding (spaces)

import Day2.EDSL


spaces :: Parser ()
spaces = skipMany1 space

runGames1 :: String -> Either ParseError Games1
runGames1 = parse parseGames1 ""

runGames2 :: String -> Either ParseError Games2
runGames2 = parse parseGames2 ""

parseGames1 :: Parser Games1
parseGames1 = Games1 <$> parseGame1 `sepBy1` many newline

parseGames2 :: Parser Games2
parseGames2 = Games2 <$> parseGame2 `sepBy1` many newline


parseGame1 :: Parser Game1
parseGame1 = Game1 <$> parseOpponentDraw <* spaces <*> parseMeDraw


parseGame2 :: Parser Game2
parseGame2 = Game2 <$> parseOpponentDraw <* spaces <*> parseResult


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


parseResult :: Parser Result
parseResult = parseLoss <|> parseDraw <|> parseWin

parseLoss :: Parser Result
parseLoss = char 'X' >> return Loss

parseDraw :: Parser Result
parseDraw = char 'Y' >> return Draw

parseWin :: Parser Result
parseWin = char 'Z' >> return Win