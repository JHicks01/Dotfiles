{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Reflect
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.ThreeColumns

myFocusedBorderColor = "#51afef"
myNonFocusedBorderColor = "#282c34"
myUrgentBorderColor = "#dc322f"
myUrgentTextColor = "#b58900"
myXmobarTitleColor = "#51afef"
myXmobarLayoutColor = "#98be65"
myTextColor = "#bbc2cf"
myNonFocusedTextColor = "#5B6268"

myBorderWidth = 1

myModifier = mod4Mask

myFont = "xft:Droid Sans:size=11:antialias=true"

myTerminal = "urxvt"

myScreensaver = "i3lock -u -i ~/wallpapers/yosemite1920.png"

myLauncher = "$(dmenu_path | yeganesh -x -- -fn 'Iosevka-12' -nb '#282c34')"

myWorkspaces = map show [1::Int ..9]

myLayoutHook = smartBorders $ avoidStruts $ bsp ||| tall ||| threeCols
  where bsp = named "BSP" $ reflectHoriz emptyBSP
        tall = named "Tall" $ Tall 1 (3/100) (1/2)
        threeCols = named "3Columns" $ ThreeColMid 1 (3/100) (1/2)
        
myKeys =
    [ ((myModifier, xK_BackSpace), kill)
    , ((myModifier, xK_d), spawn myLauncher)
    , ((myModifier, xK_e), spawn "emacs")
    , ((myModifier, xK_c), spawn "google-chrome-stable")
    , ((myModifier, xK_s), spawn "spotify")
    , ((myModifier .|. shiftMask, xK_x), spawn myScreensaver)
    , ((myModifier .|. shiftMask, xK_n), spawn "~/Scripts/sp next")
    , ((myModifier .|. shiftMask, xK_p), spawn "~/Scripts/sp prev")
    , ((myModifier .|. shiftMask, xK_s), spawn "~/Scripts/sp play")
    ]
    
defaults = def
    { modMask = mod4Mask
    , terminal = myTerminal
    , workspaces = myWorkspaces
    , focusedBorderColor = myFocusedBorderColor
    , normalBorderColor = myNonFocusedBorderColor
    , borderWidth = myBorderWidth
    , handleEventHook = fullscreenEventHook
    , manageHook = manageDocks
    , layoutHook = myLayoutHook
    }

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad $ docks $ defaults
        { logHook = fadeInactiveLogHook 1 >> dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc . pad
            , ppTitle = xmobarColor myXmobarTitleColor "" . shorten 75
            , ppLayout = xmobarColor myXmobarLayoutColor ""
            , ppCurrent = xmobarColor myTextColor ""
            , ppHidden = xmobarColor myNonFocusedTextColor ""
            }
        }
        `additionalKeys`
        myKeys
