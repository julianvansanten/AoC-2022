module Day2.Parser where


import Text.ParserCombinators.Parsec hiding (spaces)

import Day2.EDSL


spaces :: Parser ()
spaces = skipMany1 space


-- TODO Implement a parser for a RPS game.