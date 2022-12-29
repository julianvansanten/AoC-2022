module Day7.Parser ( parseFile ) where


import Text.Parsec.Language ( emptyDef )
import Text.Parsec.String (Parser)

import Day7.EDSL ( Listing(..), Command(..) )

import qualified Text.Parsec.Token as Token
import Text.Parsec
    ( lower,
      try,
      satisfy,
      parse,
      oneOf )
import Control.Applicative ((<|>))
import Data.Char (isLower)
import Text.Parsec.Combinator (many1)
import Text.Parsec.Char (spaces)
import qualified Data.Functor.Identity


{- | Language definition for this day's input
@identifier@ is used to identify filenames for ease of use

-}
languageDef :: Token.GenLanguageDef String u Data.Functor.Identity.Identity
languageDef = emptyDef {
    Token.opLetter = oneOf "$"
    , Token.reservedNames = [
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


lexer :: Token.GenTokenParser String u Data.Functor.Identity.Identity
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

folderName :: Parser String
folderName = many1 lower <* spaces



-- | Parse a file listing (on a single line as @{fileSize} {filename}.{ext}@)
file :: Parser Listing
file = do
    sz <- int
    File sz <$> identifier


-- | Parse a directory listing (on a single line as @dir {folderName}@)
dir :: Parser Listing
dir = do
    reserved "dir"
    Folder <$> folderName


-- | Parse a listing of a directory
ls :: Parser Command
ls = do
    reserved "ls"
    List <$> many1 (try file <|> dir)


-- | Parse a directory change
-- Can be entering a named folder, moving up one folder (denoted by @..@) or the root folder (denoted by @/@)
cd :: Parser Command
cd = do
    reserved "cd"
    Change <$> (symbol ".." <|> symbol "/" <|> folderName)


-- | Parse a single command, starting with a dollar and then either a cd or ls
command :: Parser Command
command = do
    dollar
    ls <|> cd


-- | Parse all commands and put them in a list
commands :: Parser [Command]
commands = do
    many1 command


-- | Wrapper around the parser, which will always succeed with the result or crash the program with an error
parseFile :: String -> [Command]
parseFile str = do
    let res = parse commands "" str
    case res of
        Left pe -> error $ show pe
        Right cs -> cs
