module Test.Main where

import Prelude

import Effect (Effect)
import Foreign (unsafeToForeign)
import Jest (expectToEqual, test)
import SVGO as SVGO

raw :: String
raw = """
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
  <path fill="#000" fill-rule="nonzero" d="M11.252 11.422C13.912 9.426 15 7.96 15 6c0-2.283-1.18-4-3.5-4-.144 0-.338.044-.569.136-.347.14-.743.373-1.155.673a10.275 10.275 0 0 0-1.069.898L8 4.414l-.707-.707a10.275 10.275 0 0 0-1.069-.898c-.412-.3-.808-.533-1.155-.673A1.623 1.623 0 0 0 4.5 2C2.18 2 1 3.717 1 6c0 1.959 1.087 3.426 3.748 5.422.436.327 2.206 1.582 3.252 2.339 1.046-.757 2.816-2.012 3.252-2.339zM8 3s2-2 3.5-2C15 1 16 4 16 6c0 4-4 6-8 9-4-3-8-5-8-9 0-2 1-5 4.5-5C6 1 8 3 8 3z"/>
</svg>
"""

optimized :: String
optimized = """<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"><path d="M11.252 11.422C13.912 9.426 15 7.96 15 6c0-2.283-1.18-4-3.5-4a1.63 1.63 0 0 0-.569.136c-.347.14-.743.373-1.155.673a10.275 10.275 0 0 0-1.069.898L8 4.414l-.707-.707a10.275 10.275 0 0 0-1.069-.898c-.412-.3-.808-.533-1.155-.673A1.623 1.623 0 0 0 4.5 2C2.18 2 1 3.717 1 6c0 1.959 1.087 3.426 3.748 5.422.436.327 2.206 1.582 3.252 2.339 1.046-.757 2.816-2.012 3.252-2.339zM8 3s2-2 3.5-2C15 1 16 4 16 6c0 4-4 6-8 9-4-3-8-5-8-9 0-2 1-5 4.5-5C6 1 8 3 8 3z"/></svg>"""

main :: Effect Unit
main =
  test "optimize works" $ do
    svgo <- SVGO.newSvgo $ unsafeToForeign
      { plugins:
          [ unsafeToForeign {
              removeViewBox: false
            }
          , unsafeToForeign {
              removeAttrs: {
                attrs: ["fill"]
              }
            }
          ]
      }
    out <- SVGO.optimize raw svgo
    expectToEqual out optimized
