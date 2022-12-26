module Day7.Parser (parseFile) where


import Text.Parsec.Language ( emptyDef )
import Text.Parsec.String (Parser)

import Day7.EDSL ( Listing(..), Command(..) )

import qualified Text.Parsec.Token as Token
import Text.Parsec ( many, space, lower, sepBy1, try, satisfy, spaces, parse )
import Control.Applicative ((<|>))
import Text.Parsec.Char (char)
import Data.Char (isLower)


{- | Language definition for this day's input
@identifier@ is used to identify filenames for ease of use

-}
languageDef = emptyDef {
    Token.reservedNames = [
        "cd"
        , "ls"
        , "dir"
    ]
    , Token.reservedOpNames = [
        "$"
    ]
    , Token.identStart = lower
    , Token.identLetter = satisfy (\x -> isLower x || x == '.')
}


lexer = Token.makeTokenParser languageDef


int :: Parser Int
int = fromIntegral <$> Token.integer lexer
reserved :: String -> Parser ()
reserved = Token.reserved lexer
symbol :: String -> Parser String
symbol = Token.symbol lexer
dollar :: Parser ()
dollar = Token.reservedOp lexer "$"
identifier :: Parser String
identifier = Token.identifier lexer



-- | Parse a file listing (on a single line as @{fileSize} {filename}.{ext}@)
file :: Parser Listing
file = do
    sz <- int
    _ <- space
    File sz <$> identifier


dir :: Parser Listing
dir = do
    reserved "dir"
    Folder <$> many lower


listing :: Parser Listing
listing = file <|> dir


ls :: Parser Command
ls = do
    reserved "ls"
    -- TODO Does this work?
    List <$> sepBy1 (try listing) (char '\n')


cd :: Parser Command
cd = do
    reserved "cd"
    Change <$> (many lower <|> symbol ".." <|> symbol "/")


command :: Parser Command
command = do
    dollar
    ls <|> cd


commands :: Parser [Command]
commands = do
    sepBy1 command spaces


parseFile :: String -> [Command]
parseFile str = do
    let res = parse commands "" str
    case res of
        Left pe -> error $ show pe
        Right cs -> cs
