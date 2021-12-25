{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_flowerFighting (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/sinmincheol/Desktop/minchurl/local/flowerFighting/haskell/flowerFighting/.stack-work/install/x86_64-osx/b99519a9cd8fc2eed3bde6b1e530b99f9a60dd6e7785f4cd55646cf819e6b001/8.10.7/bin"
libdir     = "/Users/sinmincheol/Desktop/minchurl/local/flowerFighting/haskell/flowerFighting/.stack-work/install/x86_64-osx/b99519a9cd8fc2eed3bde6b1e530b99f9a60dd6e7785f4cd55646cf819e6b001/8.10.7/lib/x86_64-osx-ghc-8.10.7/flowerFighting-0.1.0.0-DErUl8SdOiiCqFB9LCkb4k-flowerFighting-exe"
dynlibdir  = "/Users/sinmincheol/Desktop/minchurl/local/flowerFighting/haskell/flowerFighting/.stack-work/install/x86_64-osx/b99519a9cd8fc2eed3bde6b1e530b99f9a60dd6e7785f4cd55646cf819e6b001/8.10.7/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/sinmincheol/Desktop/minchurl/local/flowerFighting/haskell/flowerFighting/.stack-work/install/x86_64-osx/b99519a9cd8fc2eed3bde6b1e530b99f9a60dd6e7785f4cd55646cf819e6b001/8.10.7/share/x86_64-osx-ghc-8.10.7/flowerFighting-0.1.0.0"
libexecdir = "/Users/sinmincheol/Desktop/minchurl/local/flowerFighting/haskell/flowerFighting/.stack-work/install/x86_64-osx/b99519a9cd8fc2eed3bde6b1e530b99f9a60dd6e7785f4cd55646cf819e6b001/8.10.7/libexec/x86_64-osx-ghc-8.10.7/flowerFighting-0.1.0.0"
sysconfdir = "/Users/sinmincheol/Desktop/minchurl/local/flowerFighting/haskell/flowerFighting/.stack-work/install/x86_64-osx/b99519a9cd8fc2eed3bde6b1e530b99f9a60dd6e7785f4cd55646cf819e6b001/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "flowerFighting_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "flowerFighting_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "flowerFighting_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "flowerFighting_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "flowerFighting_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "flowerFighting_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
