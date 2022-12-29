module Day9.Parser
    (parseFile)
    where


import Text.Parsec
import Text.Parsec.String (Parser)
import Day9.EDSL (Direction(..), Move(..))


-- | Parse numbers as int, skipping trailing whitespace
digits :: Parser Int
digits = read <$> many1 alphaNum <* spaces


-- | Run the moves parser
-- Return the result or just fail if the parser fails
parseFile :: String -> [Move]
parseFile str = do
    let res = parse moves "" str
    case res of
        Left pe -> error $ show pe
        Right mos -> mos


-- | Parse a list of moves
moves :: Parser [Move]
moves = many1 move


-- | Parse a single move
-- Example: "U 2"
move :: Parser Move
move = Move <$> direction <*> digits


-- | Parse a single direction, skipping trailing whitespace
-- Example: "U"
direction :: Parser Direction
direction = (up <|> down <|> left <|> right) <* spaces


up :: Parser Direction
up = char 'U' >> return RUp

down :: Parser Direction
down = char 'D' >> return RDown

left :: Parser Direction
left = char 'L' >> return RLeft

right :: Parser Direction
right = char 'R' >> return RRight