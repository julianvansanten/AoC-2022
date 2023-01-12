{-# OPTIONS_GHC -Wincomplete-uni-patterns #-}

module Day5.CrateLogic (
    Stack(..),
    executeMoves,
    getTopChars
) where


import Day5.EDSL ( Move(..), Crate(..), Stack(..))


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


-- | Take in a Move, a Stack and return the resulting Stack in combination with the crates that were removed.
pickFromStack :: ([Crate] -> [Crate]) -> Move -> Stack -> (Stack, [Crate])
pickFromStack order (Move c _ _) (Stack cs) = (Stack rs, rest)
    where
        rs = take (length cs - c) cs
        rest = order $ take c (reverse cs)


-- | Add a list of crates to the end of a stack
addToStack :: [Crate] -> Stack -> Stack
addToStack cs (Stack ss) = Stack $ ss ++ cs


-- | Replace a stack at a given index
replaceStack :: Int -> Stack -> [Stack] -> [Stack]
replaceStack i st oldStack = f ++ st : s
    where
        (f, _:s) = splitAt i oldStack


{-  | Execute a given move in a list of stacks
    | Use with `foldr executeMove beginStack listOfMoves`
-}
executeMove :: ([Crate] -> [Crate]) -> [Stack] -> Move -> [Stack]
executeMove order st m@(Move _ f s) = replaceStack s newToStack fromStack
    where
        oldFromStack = st !! f
        (newFromStack, removed) = pickFromStack order m oldFromStack
        oldToStack = st !! s
        newToStack = addToStack removed oldToStack
        fromStack = replaceStack f newFromStack st


-- | Execute a list of moves on a collection of stacks
executeMoves :: ([Crate] -> [Crate]) -> [Move] -> [Stack] -> [Stack]
executeMoves order mvs st = foldl (executeMove order) st mvs
