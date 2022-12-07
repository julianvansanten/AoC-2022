module Day5.CrateLogic (
    Stack(..),
    executeMoves,
    getTopChars
) where


import Day5.EDSL ( Move(..), Crate(..) )


newtype Stack = Stack [Crate]
    deriving (Eq, Show)


-- | Get the characters at the top of each stack
getTopChars :: [Stack] -> String
getTopChars = map getTopChar


-- | Get the character at the top of a stack
getTopChar :: Stack -> Char
getTopChar (Stack cs) = getCrateChar $ last cs


-- | Get the character in a crate
getCrateChar :: Crate -> Char
getCrateChar (Crate a) = a
getCrateChar EmptyCrate = error "An empty crate is at the top, although there should not be any empty crates in the stack!"


-- | Filter empty crates from the stack
filterEmpty :: Stack -> Stack
filterEmpty (Stack cs) = Stack $ filter (EmptyCrate /=) cs


-- | Take in a Move, a Stack and return the resulting Stack in combination with the crates that were removed.
pickFromStack :: Move -> Stack -> (Stack, [Crate])
pickFromStack (Move c _ _) (Stack cs) = (Stack rs, rest)
    where
        rs = take (length cs - c) cs
        rest = take c (reverse cs)


-- | Add a list of crates to the end of a stack
addToStack :: [Crate] -> Stack -> Stack
addToStack cs (Stack ss) = Stack $ cs ++ ss


-- | Replace a stack at a given index
replaceStack :: Int -> Stack -> [Stack] -> [Stack]
replaceStack i st oldStack = fst ++ st : snd
    where
        -- TODO find out if this is a bad thing
        (fst, _:snd) = splitAt i oldStack


{-  | Execute a given move in a list of stacks
    | Use with `foldr executeMove beginStack listOfMoves`
-}
executeMove :: Move -> [Stack] -> [Stack]
executeMove m@(Move _ f s) st = replaceStack s newToStack fromStack
    where
        oldFromStack = st !! f
        (newFromStack, removed) = pickFromStack m oldFromStack
        oldToStack = st !! s
        newToStack = addToStack removed oldToStack
        fromStack = replaceStack f newFromStack st


-- | Execute a list of moves on a collection of stacks
executeMoves :: [Move] -> [Stack] -> [Stack]
executeMoves mvs st = foldr executeMove st mvs
