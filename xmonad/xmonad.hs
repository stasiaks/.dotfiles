{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spacing
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.BorderResize
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.NamedScratchpad
import XMonad.Actions.Navigation2D
import Data.List
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W

main			= xmonad . ewmh $ docks $ myConfig 

myTerminal		= "urxvt"

myModMask		= mod4Mask

altMask 		= mod1Mask


myLayoutHook		= onWorkspace workspaceFloating simplestFloat
			$ borderResize $ emptyBSP

myFocusedBorderColor	= "#7c7c7c"

myNormalBorderColor 	= "#3f3f3f"

myBorderWidth 		= 1

-- Workspaces

workspaceTerminal	= "\xf120"

workspaceCode		= "\xf121"

workspaceWeb		= "\xf0c2"

workspaceMail		= "\xf0e0"

workspaceDocument	= "\xf044"

workspaceFloating	= "\xf2d2"

myWorkspaces :: [String]= workspaceTerminal
			: workspaceCode
			: workspaceWeb
			: workspaceMail
			: workspaceDocument
			: workspaceFloating
			: []

myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                ]
    where
        spawnTerm = myTerminal ++ " -name scratchpad"
        findTerm  = resource =? "scratchpad"
        manageTerm = customFloating $ W.RationalRect l t w h
                     where
                         h = 0.9
                         w = 0.9
                         t = 0.95 - h
                         l = 0.96 - w

myManageHook		= composeAll
			[ className =? "Opera developer"		--> doShift workspaceWeb
			, className =? "Vivaldi-stable"			--> doShift workspaceWeb
			, className =? "jetbrains-clion"		--> doShift workspaceCode
			, className =? "jetbrains-jetbrains-rider"	--> doShift workspaceCode
			, className =? "jetbrains-idea"			--> doShift workspaceCode
			, className =? "jetbrains-datagrip"		--> doShift workspaceCode
			, className =? "Texmaker" 			--> doShift workspaceDocument
			, manageDocks
			]

myStartupHook		=   setWMName "LG3D"
                        <+> spawn "$HOME/.xmonad/scripts/autostart.sh"
			<+> spawn "compton --active-opacity 1.0 --shadow-ignore-shaped"
			<+> spawn "udiskie &"
			<+> spawn "twmnd &"
                        <+> spawn "uim-xim &"  
                        <+> spawn "wal -i ~/Pictures/Wallpapers -a 90 &"  

myAdditionalKeys	=
			[ ((myModMask,					xK_p    )	, (spawn "rofi -show run")) 
			, ((myModMask .|. shiftMask,			xK_l    )       , (spawn "i3lock-fancy"))
                        , ((myModMask,                                  xK_b    )       , sendMessage ToggleStruts)
			-- Media
                        , ((0,  xF86XK_AudioMute                                )     	, (spawn "amixer sset Master toggle"))
                        , ((0,  xF86XK_AudioRaiseVolume                         )     	, (spawn "amixer sset Master 5%+"))
			, ((0  ,xF86XK_AudioLowerVolume                         )       , (spawn "amixer sset Master 5%-"))
            -- Named Scratchpads
            , ((myModMask, xK_grave), namedScratchpadAction myScratchPads "terminal")
			-- BSP
			--- Window resizing
			, ((myModMask .|. altMask,			xK_Right)	, sendMessage $ ExpandTowards R)
			, ((myModMask .|. altMask,			xK_Left	)	, sendMessage $ ExpandTowards L)
			, ((myModMask .|. altMask,			xK_Down	)	, sendMessage $ ExpandTowards D)
			, ((myModMask .|. altMask,			xK_Up	)	, sendMessage $ ExpandTowards U)
			, ((myModMask .|. altMask .|. controlMask,	xK_Right)	, sendMessage $ ShrinkFrom R)
			, ((myModMask .|. altMask .|. controlMask,	xK_Left	)	, sendMessage $ ShrinkFrom L)
			, ((myModMask .|. altMask .|. controlMask,	xK_Down	)	, sendMessage $ ShrinkFrom D)
			, ((myModMask .|. altMask .|. controlMask,	xK_Up	)	, sendMessage $ ShrinkFrom U)
			--- Window resizing [VI]
			, ((myModMask .|. altMask,			xK_l    )	, sendMessage $ ExpandTowards R)
			, ((myModMask .|. altMask,			xK_h	)	, sendMessage $ ExpandTowards L)
			, ((myModMask .|. altMask,			xK_j	)	, sendMessage $ ExpandTowards D)
			, ((myModMask .|. altMask,			xK_k	)	, sendMessage $ ExpandTowards U)
			, ((myModMask .|. altMask .|. controlMask,	xK_l    )	, sendMessage $ ShrinkFrom R)
			, ((myModMask .|. altMask .|. controlMask,	xK_h	)	, sendMessage $ ShrinkFrom L)
			, ((myModMask .|. altMask .|. controlMask,	xK_j	)	, sendMessage $ ShrinkFrom D)
			, ((myModMask .|. altMask .|. controlMask,	xK_k	)	, sendMessage $ ShrinkFrom U)
			--- Window moving
			, ((myModMask,					xK_r	)	, sendMessage Rotate)
			, ((myModMask,					xK_s	)	, sendMessage Swap)
			, ((myModMask,					xK_n	)	, sendMessage FocusParent)
			, ((myModMask .|. controlMask,			xK_n	)	, sendMessage SelectNode)
			, ((myModMask .|. shiftMask,			xK_n	)	, sendMessage MoveNode)
			, ((myModMask,	 				xK_a	)	, sendMessage Balance)
			, ((myModMask .|. shiftMask,			xK_a	)	, sendMessage Equalize)
			-- Navigation2D
			, ((myModMask,					xK_space)	, switchLayer)
			--- Directional navigation
			, ((myModMask,					xK_Right)	, windowGo R False)
			, ((myModMask,					xK_Left	)	, windowGo L False)
			, ((myModMask,					xK_Up	)	, windowGo U False)
			, ((myModMask,					xK_Down )	, windowGo D False)
			--- Directional navigation [VI]
			, ((myModMask,					xK_l    )	, windowGo R False)
			, ((myModMask,					xK_h	)	, windowGo L False)
			, ((myModMask,					xK_k	)	, windowGo U False)
			, ((myModMask,					xK_j    )	, windowGo D False)
			--- Swap windows
			, ((myModMask .|. controlMask,			xK_Right)	, windowSwap R False)
			, ((myModMask .|. controlMask,			xK_Left )	, windowSwap L False)
			, ((myModMask .|. controlMask,			xK_Up	)	, windowSwap U False)
			, ((myModMask .|. controlMask,			xK_Down	)	, windowSwap D False)
			--- Swap windows [VI]
			, ((myModMask .|. controlMask,			xK_l    )	, windowSwap R False)
			, ((myModMask .|. controlMask,			xK_h    )	, windowSwap L False)
			, ((myModMask .|. controlMask,			xK_k	)	, windowSwap U False)
			, ((myModMask .|. controlMask,			xK_j	)	, windowSwap D False)
			]

myConfig 		= defaultConfig
	{ terminal		= myTerminal
	, modMask		= myModMask
	, layoutHook		= avoidStruts $ myLayoutHook
	, focusedBorderColor	= myFocusedBorderColor
	, normalBorderColor	= myNormalBorderColor
	, borderWidth		= myBorderWidth
	, workspaces		= myWorkspaces
	, manageHook		= myManageHook <+> namedScratchpadManageHook myScratchPads <+> manageHook defaultConfig
	, startupHook		= myStartupHook
        , handleEventHook       = handleEventHook def <+> fullscreenEventHook
	} `additionalKeys` myAdditionalKeys

