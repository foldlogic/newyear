{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.Trans (liftIO)
import Data.Time

import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html.Renderer.Text (renderHtml)
import Text.Blaze.Html5.Attributes (class_, href, rel)
import Web.Scotty

getCurrentYear :: IO Integer
getCurrentYear = do
    (year, _, _) <- fmap (toGregorian . localDay . zonedTimeToLocalTime) getZonedTime
    return year

main :: IO ()
main = scotty 3001 $ do
    get "/" $ do
        year <- liftIO getCurrentYear
        let answer = if year == 2015 then "Yes! Open the champagne!" else "No, not yet."
        html $ renderHtml $
            H.html $ do
                H.head $ do
                    H.title "Is it 2015 yet?"
                    H.link H.! href "//maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css" H.! rel "stylesheet"
                H.body $ do
                    H.div H.! class_ "container" $ do
                        H.div H.! class_ "jumbotron" $ do
                            H.h1 "Is it 2015 yet?"
                            H.p answer

