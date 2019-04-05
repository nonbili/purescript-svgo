module SVGO where

import Prelude

import Control.Promise (Promise, toAffE)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Uncurried (EffectFn1, EffectFn2, runEffectFn1, runEffectFn2)
import Foreign (Foreign)

data SVGO

newSvgo :: Foreign -> Aff SVGO
newSvgo = liftEffect <<< runEffectFn1 svgo_
foreign import svgo_ :: EffectFn1 Foreign SVGO

optimize :: String -> SVGO -> Aff String
optimize = (compose toAffE) <<< runEffectFn2 optimize_
foreign import optimize_ :: EffectFn2 String SVGO (Promise String)
