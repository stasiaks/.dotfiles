{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}

import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spacing
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.BorderResize
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.Navigation2D
import Data.List

main			= xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig 

-- Status bar

myBar			= "xmobar"

myPP			= xmobarPP
			{ ppCurrent		= xmobarColor "#ff9942" ""
			, ppHiddenNoWindows	= xmobarColor "#444444" ""
			, ppUrgent		= xmobarColor "#ff2222" ""
			, ppLayout		= nostr
			, ppTitle		= nostr
			} where nostr x = ""

myTerminal		= "urxvt"

myModMask		= mod4Mask

altMask 		= mod1Mask

layoutDefault		= avoidStruts $ Tall 1 (3/100) (1/2)

myLayoutHook		= onWorkspace workspaceFloating simplestFloat
			$ borderResize(emptyBSP)

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
			<+> spawn "compton --active-opacity 1.0 --shadow-ignore-shaped"
			<+> spawn "nitrogen --restore &"
			<+> spawn "udiskie &"
			<+> spawn "twmnd &"
                        <+> spawn "uim-xim &"  

myAdditionalKeys	=
			[ ((myModMask,					xK_p)		, (spawn "rofi -show run")) 
			, ((myModMask,					xK_KP_Add)	, (spawn "amixer sset Master 5%+"))
			, ((myModMask,					xK_KP_Subtract)	, (spawn "amixer sset Master 5%-"))
			, ((myModMask .|. shiftMask,			xK_l)		, (spawn "i3lock-fancy -p -- scrot -z"))
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
			--- Swap windows
			, ((myModMask .|. controlMask,			xK_Right)	, windowSwap R False)
			, ((myModMask .|. controlMask,			xK_Left )	, windowSwap L False)
			, ((myModMask .|. controlMask,			xK_Up	)	, windowSwap U False)
			, ((myModMask .|. controlMask,			xK_Down	)	, windowSwap D False)
			]

myConfig 		= defaultConfig
	{ terminal		= myTerminal
	, modMask		= myModMask
	, layoutHook		= myLayoutHook
	, focusedBorderColor	= myFocusedBorderColor
	, normalBorderColor	= myNormalBorderColor
	, borderWidth		= myBorderWidth
	, workspaces		= myWorkspaces
	, manageHook		= myManageHook <+> manageHook defaultConfig
	, startupHook		= myStartupHook
	} `additionalKeys` myAdditionalKeys

toggleStrutsKey XConfig { XMonad.modMask = modMask } = (modMask, xK_b)

