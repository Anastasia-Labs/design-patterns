import qualified PlutusTx.Builtins as BI
import qualified PlutusTx.Builtins.Internal as BI
import Language.Haskell.TH

-- A template haskell function that generates `n` inlined tail applications ie:
-- $(genInlinedTails 3 'xs)
--
-- compiles into:
--
-- (BI.tail (BI.tail (BI.tail xs)))
--  
genInlinedTails :: Int -> Name -> Q Exp
genInlinedTails n xs = foldr (\_ acc -> [| BI.tail $acc |]) (varE xs) [1..n]

-- Recursively compute the count of elements in a list (the count starts at `acc`)
-- ie: builtinListLength 3 [1,2] == 5 
-- the list has a length of 2 and `acc` is 3, so we have 2 + 3 = 5.
builtinListLength :: forall a. Integer -> BI.BuiltinList a -> Integer
builtinListLength acc xs = 
  BI.chooseList xs
      -- if the list is empty we return `acc` 
      acc
      -- if the list is non-empty we increase the counter and recurse
      (\_ ys -> builtinListLength (acc + 1) ys)
      ()

-- An efficient length function that takes as a parameter the expected length and uses that knowledge
-- to avoid unnecessary recursion and checks. 
builtinListLengthFast :: forall a. Integer ->  BI.BuiltinList a -> Integer
builtinListLengthFast n xs = go n 0 xs  
  where 
   go :: Integer -> Integer -> BI.BuiltinList a -> Integer
   go remainingExpected currentCount xs 
    | 30 <= remainingExpected = go (remainingExpected - 30) (currentCount + 30) $(genInlinedTails 30 'xs)
    | 20 <= remainingExpected = go (remainingExpected - 20) (currentCount + 20) $(genInlinedTails 20 'xs)
    | 10 <= remainingExpected = go (remainingExpected - 10) (currentCount + 10) $(genInlinedTails 10 'xs)
    | otherwise = builtinListLength 0 xs
