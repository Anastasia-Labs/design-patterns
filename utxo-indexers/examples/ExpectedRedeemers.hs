import qualified PlutusTx.Builtins as BI
import qualified PlutusTx.Builtins.Internal as BI
import PlutusTx.Builtins.Internal (BuiltinData)


-- Plinth (formerly PlutusTx) implementation:
{-# INLINE enforceNSpendRedeemersSkipFirst #-}
enforceNSpendRedeemersSkipFirst :: Integer -> BuiltinData -> Bool
enforceNSpendRedeemersSkipFirst n b = isLastSpend (dropN (n - 1) (BI.unsafeDataAsMap b))
  where
    dropN :: Integer -> BI.BuiltinList a -> BI.BuiltinList a
    dropN 0 xs = xs
    dropN i xs = dropN (i - 1) (BI.tail xs)

    isNonSpend :: BuiltinData -> Bool
    isNonSpend red = BI.fst (BI.unsafeDataAsConstr (BI.fst $ BI.unsafeDataAsConstr red)) /= 1

    isLastSpend :: BI.BuiltinList (BI.BuiltinPair BI.BuiltinData BI.BuiltinData) -> Bool
    isLastSpend redeemers =
      let constrPair = BI.fst $ BI.head redeemers
          constrIdx = BI.fst (BI.unsafeDataAsConstr constrPair)
       in if constrIdx == 1
          then go (BI.tail redeemers)
          else False

    go :: BI.BuiltinList (BI.BuiltinPair BI.BuiltinData BI.BuiltinData) -> Bool
    go redeemers =
      if BI.fromOpaque $ BI.null redeemers
        then True
        else isNonSpend (BI.fst $ BI.head redeemers)

-- Plutarch implementation
penforceNSpendRedeemers :: forall {s :: S}. Term s PInteger -> Term s (AssocMap.PMap 'AssocMap.Unsorted PScriptPurpose PRedeemer) -> Term s PBool
penforceNSpendRedeemers n rdmrs =
    let isNonSpend :: Term _ (PAsData PScriptPurpose) -> Term _ PBool
        isNonSpend red = pnot # (pfstBuiltin # (pasConstr # (pforgetData red)) #== 1)
             
        isLastSpend :: Term _ (PBuiltinList (PBuiltinPair (PAsData PScriptPurpose) (PAsData PRedeemer)) :--> PBool)
        isLastSpend = plam $ \redeemers -> 
          let constrPair :: Term s (PAsData PScriptPurpose)
              constrPair = pfstBuiltin # (phead # redeemers)
              constrIdx = pfstBuiltin # (pasConstr # (pforgetData constrPair))
           in pif 
                (constrIdx #== 1) 
                (pelimList (\x _ -> isNonSpend (pfstBuiltin # x)) (pconstant True) (ptail # redeemers))
                perror
     in isLastSpend # (pdropFast # (n - 1) # (pto rdmrs))
