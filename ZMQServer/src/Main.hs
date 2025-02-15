{-# LANGUAGE CPP, TemplateHaskell #-}
-----------------------------------------------------------------------------
--
-- Module      :  Main
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Main (
    main
) where
import System.ZMQ4
import Control.Monad
import qualified Data.ByteString.Char8 as BS hiding ( putStrLn )
import qualified Data.ByteString.Lazy.Internal as BL
import Control.Concurrent ( threadDelay )
import System.Random
import RTLParser
import Data.Aeson

main = do
     c <- context
     publisher <- socket c Pub
     bind publisher "tcp://127.0.0.1:5556"
     forever $ do
             rtlStream <- RTLParser.getStream "1431"
             putStrLn $ show $ toJSON rtlStream
             send' publisher [] ( BL.packChars $ show $ toJSON rtlStream )
             threadDelay 5000000
     close publisher
--     destroy c
     return ()
