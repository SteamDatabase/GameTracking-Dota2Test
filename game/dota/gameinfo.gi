"GameInfo"
{
	game 		"Dota 2"
	title 		"Dota 2"

	gamelogo 1
	type		multiplayer_only

	nomodels 1
	nohimodel 1
	nocrosshair 0
	GameData	"dota.fgd"
	SupportsDX8	0
	nodegraph 0
	tonemapping 0 // Hide tonemapping ui in tools mode

	FileSystem
	{
		SteamAppId				205790

		//
		// The code that loads this file automatically does a few things here:
		//
		// 1. For each "Game" search path, it adds a "GameBin" path, in <dir>\bin
		// 2. For each "Game" search path, it adds another "Game" path in front of it with _<langage> at the end.
		//    For example: c:\hl2\cstrike on a french machine would get a c:\hl2\cstrike_french path added to it.
		// 3. For the first "Game" search path, it adds a search path called "MOD".
		// 4. For the first "Game" search path, it adds a search path called "DEFAULT_WRITE_PATH".
		//

		//
		// Search paths are relative to the exe directory\..\
		//
		SearchPaths
		{
			// These are optional language paths. They must be mounted first, which is why there are first in the list.
			// *LANGUAGE* will be replaced with the actual language name. If not running a specific language, these paths will not be mounted
			Game_Language		dota_*LANGUAGE*

			// These are optional low-violence paths. They will only get mounted if you're in a low-violence mode.
			Game_LowViolence	dota_lv

			Game				dota
			Game				core

			Mod					dota

			AddonRoot			dota_addons

			// Note: addon content is included in publiccontent by default.
			PublicContent		dota_core
			PublicContent		core
		}
	}

	MaterialSystem2
	{
		RenderModes
		{
			"game" "Default"
			"game" "DotaDeferred"
			"game" "DotaForward"
			"game" "Depth"

			"tools" "ToolsVis" // Visualization modes for all shaders (lighting only, normal maps only, etc.)
			"tools" "ToolsWireframe" // This should use the ToolsVis mode above instead of being its own mode
			"tools" "ToolsUtil" // Meant to be used to render tools sceneobjects that are mod-independent, like the origin grid
		}
	}
	 
	Engine2
	{
		"HasModAppSystems" "1"
		"Capable64Bit" "1"
		"UsesVGui" "0"
		"UsesScaleform" "1"
		"UsesPanorama" "1"
		"PanoramaUIClientFromClient" "1" // IPanoramaUIClient is implemented by client.dll
		"HasGameUI" "1" // dota uses gameui
		"GameUIFromClient" "1"  // AND that gameui comes from client.dll
		"URLName" "dota2"
		"MsaaOverrideType" "0"
		"UsesBink" "0"
        "MaxNetworkableEntities" "10000"
        "MaxNonNetworkableEntities" "10000"
        "DefaultDXVersion" "9"
        // The shader binary cache on Linux can be over 100MB so
        // we have to allow very large allocations.
		"AllocWarnMB_linuxsteamrt64" "200"
		// Also currently demo files are loaded entirely into
		// memory for 64-bit binaries so they can use well
		// over 100MB at load time.  Zoid is looking at
		// converting that to streaming.
		"AllocWarnMB_osx64" "200"
		"AllocWarnMB_pc64" "200"
		"AllocWarnMB" "64"
		// There are some known large virtual reservations, such as the SBH, which
		// bypass this limit so we can be fairly conservative.
		"ReserveWarnMB" "32"

		"RenderingPipeline"
		{
			"SkipPostProcessing" "1"
			"SupportsMSAA" "0"
		}
		
		"BugBait"
		{
			// Used by 'bug:' in chat to normalize report settings during playtests
			"Owner" "triage*" 
			"Severity" "high"
			"Priority" "none"
			"Category" "---"
			"Product" "dota"
			"Component" "dota"
		}
	}

	SceneFileCache
	{
		"ServerUsesSceneImageFile" "0"
	}

	SceneSystem
	{
		"NoSunLightManager" "1"
		"TransformTextureRowCount" "256"
		"CMTAtlasWidth" "512"
		"CMTAtlasHeight" "512"
		"CMTAtlasChunkSize" "128"
		"DrawParticleChildrenSeparateFromParents" "1"
	}

	ToolsEnvironment
	{
		"Engine"	"Source 2"
		"ToolsDir"	"../sdktools"	// NOTE: Default Tools path. This is relative to the mod path.
		"DeveloperHelpURL" "https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools"
		"ToolsProductName" "Dota2 Workshop Tools"
	}
	
	Hammer
	{
		"fgd"					"dota.fgd"	// NOTE: This is relative to the 'mod' path.
		"GameFeatureSet"		"Dota"
		"LoadScriptEntities"	"0"
		"DefaultTextureScale"	"0.250000"
		"DefaultSolidEntity"	"trigger_dota"
		"DefaultPointEntity"	"info_player_start_dota"
		"NavMarkupEntity"		"func_nav_markup"
		"EnableDotaTools"		"1"
		"DefaultGridTileSet"	"/maps/tilesets/radiant_basic.vmap"
		"DefaultGridTileSet2"	"/maps/tilesets/dire_basic.vmap"
		"DotaMaxTrees"			"8000"
		"AddonMapCommand"		"dota_launch_custom_game"
		"PostMapLoadCommands"	"jointeam good" // Commands sent to the console by hammer after it finishes building a map and loads it
		"RequiredGameEntities"	"info_player_start_goodguys|info_player_start_dota; info_player_start_badguys|info_player_start_dota; env_global_light; ent_dota_game_events"
		"UnitsFiles"			"scripts/npc/npc_units.txt; scripts/npc/npc_units_staging.txt; scripts/npc/npc_units_custom.txt; scripts/npc/npc_heroes.txt; scripts/npc/npc_heroes_staging.txt"
		"ItemsFiles"			"scripts/npc/items.txt; scripts/npc/items_staging.txt; scripts/npc/npc_items_custom.txt"
		"OverlayBoxSize"		"16"
	}

	MaterialEditor
	{
		"DefaultShader"			"global_lit_simple"
		"ExpressionHelpUrl"		"https://intranet.valvesoftware.com/index.php/Source_2.0/Shader_Format#Shader.2FMaterial_Expression_Syntax"
	}
	
	ResourceCompiler
	{
		// Overrides of the default builders as specified in code, this controls which map builder steps
		// will be run when resource compiler is run for a map without specifiying any specific map builder
		// steps. Additionally this controls which builders are displayed in the hammer build dialog.
		DefaultMapBuilders
		{			
			"light"		"0"	// Dota does not use baked lighting
			"envmap"	"0"	// Dota doesn't generate environment maps from the map
			"gridnav"	"1"	// Dota generates its grid navigation data by default
		}
	}

	RenderPipelineAliases
	{
		"Tools"			"Dota:Forward"
		"EnvMapBake"	"Dota"
	}
	
	Source1Import
	{
		"importmod"			"dota"
		"importdir"			"..\dota"
		"ignoreParticleManifest" "1"	
		"getSkinningFromLod0ByDefault" "0"
		"createStaticOverlays" "1"	// info_overlay entities will be converted to static overlay nodes instead of preserved as Info_overlay entities
		"changelist"	"2927753"	
		"oldchangelist"	"2926660"	
		"oldchangelist"	"2874269"
		"oldchangelist"	"2864317"
		"oldchangelist"	"2744452"
		"oldchangelist"	"2628240"
		"oldchangelist"	"2524630"
		"oldchangelist"	"2383509"
		"oldchangelist"	"2264042"
		"oldchangelist"	"2246563"
		"oldchangelist"	"2192759"
		"oldchangelist"	"2192468"
		"oldchangelist"	"2187054"
		"oldchangelist"	"2149856"
		"oldchangelist"	"2141840"
		"oldchangelist"	"2141113"
		"oldchangelist"	"2090590"
		"oldchangelist"	"2085272"
		"oldchangelist" "2067624"
		"oldchangelist" "2051272"
		"oldchangelist" "1803612"

		// These are files that are synced ahead of the current change list
		// To handle bug fixes from source 1

		// All exception files must be under the depot game or content root paths
		// These are needed to build a fake local filename to see if it is in 
		// the user's clientspec.
		depotRootPaths
		{
			"game"		"//dota/staging/game/dota/"
			"content"	"//dota/staging/content/dota/"
		}

		// Example
//		syncException
//		{
//			"changelist" "2729411"  (note -1 will sync to head)
//
//			"p4path" "//dota/staging/content/dota/models/items/drow/ice_cape.root"
//			"p4path" "//dota/staging/content/dota/models/items/drow/ice_cape/ice_cape.root"
//			"p4path" "//dota/staging/content/dota/models/items/drow/ice_cape/scripts/ice_cape.model"
//			"p4path" "//dota/staging/content/dota/models/items/drow/scripts/ice_cape.model"
//			"p4path" "//dota/staging/game/dota/models/items/drow/ice_cape.dx90.vtx"
//			"p4path" "//dota/staging/game/dota/models/items/drow/ice_cape.mdl"
//			"p4path" "//dota/staging/game/dota/models/items/drow/ice_cape.vvd"
//		}


		syncException
		{
			"changelist" "-1" 

			"p4path" "//dota/staging/game/dota/release.filelist"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/default_item/..."
			"p4path" "//dota/staging/game/dota/scripts/npc/npc_heroes..."
			"p4path" "//dota/staging/game/dota/scripts/npc/npc_units..."
			"p4path" "//dota/staging/game/dota/scripts/npc/npc_abilities..."
							 
			"p4path" "//dota/staging/game/dota/materials/models/items/earth_spirit/stone_tranquility_belt..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/earth_spirit/stone_tranquility_belt..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/ward/class_zero_moogle.txt"

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/..."	

			"p4path" "//dota/staging/game/dota/models/heroes/pedestal/..."
			"p4path" "//dota/staging/content/dota/models/heroes/pedestal/..."
		}


		// Morphling branded set for Era - temp name Skadi Rising
		syncException
		{
			"changelist" "-1" 
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/skadi_rising_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/morphling/skadi_rising..."
			"p4path" "//dota/staging/content/dota/models/items/morphling/skadi_rising..."
			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/skadi_rising_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/morphling/skadi_rising..."
			"p4path" "//dota/staging/game/dota/models/items/morphling/skadi_rising..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/morphling/skadi_rising..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/skadi_rising..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/skadi_rising.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/skadi_rising_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/bracers_of_skadi_rising.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/crown_of_skadi_rising.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/eye_of_skadi_rising.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/guards_of_skadi_rising.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/talons_of_skadi_rising.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/skadi_rising.txt"
		}	

		// Tidehunter executioner_ray_hood
		syncException
		{
			"changelist" "-1" 

			"p4path" "//dota/staging/content/dota/materialsrc/models/items/tidehunter/executioner_ray_hood/..."
			"p4path" "//dota/staging/content/dota/models/items/tidehunter/executioner_ray_hood/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/tidehunter/executioner_ray_hood/..."
			"p4path" "//dota/staging/game/dota/models/items/tidehunter/executioner_ray_hood/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/tidehunter/executioner_ray_hood/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/executioner_ray_hood.txt"
		}


		// Sniper feather hunter hat
		syncException
		{
			"changelist" "-1" 
		
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/sniper/feather_hunter_hat/..."
			"p4path" "//dota/staging/content/dota/models/items/sniper/feather_hunter_hat/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/sniper/feather_hunter_hat/..."
			"p4path" "//dota/staging/game/dota/models/items/sniper/feather_hunter_hat/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/sniper/hat_of_the_great_hunter.txt"
		}


		// Slark deep_madness mask
		syncException
		{
			"changelist" "-1" 

			"p4path" "//dota/staging/content/dota/materialsrc/models/items/slark/deep_madness/..."
			"p4path" "//dota/staging/content/dota/models/items/slark/deep_madness/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/slark/deep_madness/..."
			"p4path" "//dota/staging/game/dota/models/items/slark/deep_madness/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/slark/deep_madness/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/slark/deep_madness.txt"
		}


		// Skywrath Mage gatekeeper_heavenly_wings
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/skywrath_mage/gatekeeper_heavenly_wings/..."
			"p4path" "//dota/staging/content/dota/models/items/skywrath_mage/gatekeeper_heavenly_wings/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/skywrath_mage/gatekeeper_heavenly_wings/..."
			"p4path" "//dota/staging/game/dota/models/items/skywrath_mage/gatekeeper_heavenly_wings/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/skywrath_mage/gatekeeper_heavenly_wings/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/skywrath_mage/gatekeepers_heavenly_wings.txt"
		}


		// Faceless Void undoer_weapon
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/faceless_void/undoer_weapon/..."
			"p4path" "//dota/staging/content/dota/models/items/faceless_void/undoer_weapon/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/faceless_void/undoer_weapon/..."
			"p4path" "//dota/staging/game/dota/models/items/faceless_void/undoer_weapon/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/faceless_void/undoer_weapon/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/faceless_void/the_undoer.txt"
		}

		// ES Monolith Tusk head
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/earthshaker/monolith_tusk_head/..."
			"p4path" "//dota/staging/content/dota/models/items/earthshaker/monolith_tusk_head/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/earthshaker/monolith_tusk_head/..."
			"p4path" "//dota/staging/game/dota/models/items/earthshaker/monolith_tusk_head/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/earthshaker/vision_of_the_monolith.txt"
		}


		// Dazzle venom_herb_caduceus
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/dazzle/venom_herb_caduceus/..."
			"p4path" "//dota/staging/content/dota/models/items/dazzle/venom_herb_caduceus/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/dazzle/venom_herb_caduceus/..."
			"p4path" "//dota/staging/game/dota/models/items/dazzle/venom_herb_caduceus/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/dazzle/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dazzle/venomherb_caduceus.txt"
		}


		// Batrider emperor_batmoth
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/batrider/emperor_batmoth/..."
			"p4path" "//dota/staging/content/dota/models/items/batrider/emperor_batmoth/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/batrider/..."
			"p4path" "//dota/staging/game/dota/models/items/batrider/emperor_batmoth/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/batrider/emperor_batmoth/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/batrider/emperor_batmoth.txt"
		}

		// Axe infernal_storm
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/axe/infernal_storm/..."
			"p4path" "//dota/staging/content/dota/models/items/axe/infernal_storm/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/axe/infernal_storm/..."
			"p4path" "//dota/staging/game/dota/models/items/axe/infernal_storm/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/axe/infernal_storm/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/axe/infernal_storm.txt"
		}


		// Abaddon blackmist_blade
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/abaddon/blackmist_blade/..."
			"p4path" "//dota/staging/content/dota/models/items/abaddon/blackmist_blade/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/abaddon/blackmist_blade/..."
			"p4path" "//dota/staging/game/dota/models/items/abaddon/blackmist_blade/..."
			"p4path" "//dota/staging/game/dota/particles/models/items/abaddon/blackmist_blade/blackmist_blade.psf"
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/abaddon/blackmist_blade/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/abaddon/blackmist_blade.txt"
		}

		// Rick and morty fixes
		//dota/staging/game/dota/resource/dota_english.txt#4456 edit
		//"p4path" "//dota/staging/game/dota/scripts/npc/npc_heroes.txt"

		syncException
		{
			"changelist" "-1"

			"p4path" "//dota/staging/game/dota/scripts/voscripts/game_sounds_vo_announcer_dlc_rick_and_morty_phonemes.txt"
			"p4path" "//dota/staging/game/dota/resource/subtitles_announcer_dlc_rick_and_morty_english.dat"
			"p4path" "//dota/staging/game/dota/resource/subtitles_announcer_dlc_rick_and_morty_english.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/rick_and_morty_announcer_pack.txt"
			"p4path" "//dota/staging/game/dota/scripts/talker/response_rules_announcer_dlc_rick_and_morty.txt"
			"p4path" "//dota/staging/game/dota/scripts/voscripts/game_sounds_vo_announcer_dlc_rick_and_morty.txt"
		
			// .png
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/announcer/announcer_rickmorty..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/announcer/megakill_rickmorty..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/tools/rickmorty..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/announcer/announcer_rick_and_morty.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/announcer/megakills_rick_and_morty.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/rick_and_morty_announcer_pack.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/store_marketing.txt"
			"p4path" "//dota/staging/game/dota/scripts/npc/npc_heroes.txt"
		}

		// creep_radiant_melee_diretide fixes
		syncException
		{
			"changelist" "-1"

			"p4path" "//dota/staging/content/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/dmx/animation/death.dmx"
			"p4path" "//dota/staging/content/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/dmx/animation/idle.dmx"
			"p4path" "//dota/staging/content/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/dmx/animation/portrait.dmx"
			"p4path" "//dota/staging/content/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/dmx/animation/run.dmx"
			"p4path" "//dota/staging/content/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/dmx/animation/stun.dmx"
			"p4path" "//dota/staging/content/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/scripts/creep_radiant_melee_diretide.anim"
			"p4path" "//dota/staging/game/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/creep_radiant_melee_diretide.dx90.vtx"
			"p4path" "//dota/staging/game/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/creep_radiant_melee_diretide.mdl"
			"p4path" "//dota/staging/game/dota/models/creeps/lane_creeps/creep_radiant_melee_diretide/creep_radiant_melee_diretide.vvd"
		}

		// mechjaw_fixes fixes
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/models/courier/mechjaw/..."
			"p4path" "//dota/staging/game/dota/models/courier/mechjaw/..."
		}
		// Arneyb (Arnabus) rabbit courier, add alphatest to vmt, portrait fix, edit alphas
		
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/courier/arneyb_rabbit/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/courier/arneyb_rabbit/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/courier/arnabus_the_fairy_rabbit.txt"
		}
		
		// Lina Bewitching Flare set for Fall Major treasure
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/bewitching_flare_loadingscreen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/lina/bewitching_flame..."
			"p4path" "//dota/staging/content/dota/models/items/lina/bewitching_flame..."
			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/bewitching_flare_loadingscreen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/lina/bewitching_flame..."
			"p4path" "//dota/staging/game/dota/models/items/lina/bewitching_flame..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/lina/bewitching_flame..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/bewitching_flare..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/bewitching_flare.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/bewitching_flare_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/lina/corset_of_the_bewitching_flare.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/lina/dress_of_the_bewitching_flare.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/lina/style_of_the_bewitching_flare.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/lina/touch_of_the_bewitching_flare.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/bewitching_flare.txt"
		}
		
		
		// Ursa Ferocious Heart set for Fall Major treasure
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/fierce_heart_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/content/dota/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/fierce_heart_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/models/items/ursa/fierce_heart..."

			"p4path" "//dota/staging/game/dota/resource/flash3/spellicons/ursa/fierce_heart_icon..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/fierce_heart_loading_screen..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/ferocious_heart_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/bracers_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/claws_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/girdle_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/helm_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/mane_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/ferocious_heart.txt"
		}
		
		// Tusk Barrier Rogue set for Fall Major
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/barrier_rogue_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/tuskarr/barrierrogue_tusk..."
			"p4path" "//dota/staging/content/dota/models/items/tuskarr/barrierrogue_tusk..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/tuskarr/sigil/barrierrogue_tusk_sigil..."
			"p4path" "//dota/staging/content/dota/models/items/tuskarr/sigil/barrierrogue_tusk_sigil..."
			
			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/barrier_rogue_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/tuskarr/barrierrogue_tusk..."
			"p4path" "//dota/staging/game/dota/models/items/tuskarr/barrierrogue_tusk..."
			"p4path" "//dota/staging/game/dota/materials/models/items/tuskarr/sigil/barrierrogue_tusk_sigil..."
			"p4path" "//dota/staging/game/dota/models/items/tuskarr/sigil/barrierrogue_tusk_sigil..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/tuskarr/barrierrogue_tusk..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/tuskarr/sigil/barrierrogue_tusk_sigil..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/barrier_rogue..."
			
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/barrier_rogue_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/broken_tusk_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/cannon_punch_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/maul_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/pack_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/pauldron_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/scar_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tusk/sigil_of_the_barrier_rogue.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/barrier_rogue.txt"
		}
		
		// Leshrac Regalia set for Fall Major
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/regalia_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/leshrac/darkthorn_regalia..."
			"p4path" "//dota/staging/content/dota/models/items/leshrac/darkthorn_regalia..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/regalia_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/leshrac/darkthorn_regalia..."
			"p4path" "//dota/staging/game/dota/models/items/leshrac/darkthorn_regalia..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/leshrac/darkthorn_regalia..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/regalia_loading_screen..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/spirethorn_regalia.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/spirethorn_regalia_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/leshrac/brush_of_the_spirethorn.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/leshrac/dressings_of_the_spirethorn.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/leshrac/horns_of_the_spirethorn.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/leshrac/pauldrons_of_the_spirethorn.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/leshrac/spirethorn.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/spirethorn_regalia.txt"
		}
		
		// Serpent Warbler courier
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/serpent_warbler_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/courier/serpent_warbler/..."
			"p4path" "//dota/staging/content/dota/models/items/courier/serpent_warbler/..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/serpent_warbler_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/courier/serpent_warbler/..."
			"p4path" "//dota/staging/game/dota/models/items/courier/serpent_warbler/..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/courier/serpent_warbler/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/serpent_warbler..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/serpent_warbler_courier_bundle.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/courier/serpent_warbler.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/serpent_warbler_loading_screen.txt"
		}
		
		// QOP Demonic Affliction set for ESL
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/esl_demonic_affliction_loadingscreen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/queenofpain/esl_demonic_affliction..."
			"p4path" "//dota/staging/content/dota/models/items/queenofpain/esl_demonic_affliction..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/esl_demonic_affliction_loadingscreen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/queenofpain/esl_demonic_affliction..."
			"p4path" "//dota/staging/game/dota/models/items/queenofpain/esl_demonic_affliction..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/queenofpain/esl_demonic_affliction..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/esl_demonic_affliction..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/esl_demonic_affliction.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/esl_demonic_affliction_loadingscreen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/queenofpain/esl_demonic_affliction_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/queenofpain/esl_demonic_affliction_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/queenofpain/esl_demonic_affliction_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/queenofpain/esl_demonic_affliction_weapon.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/esl_demonic_affliction.txt"
		}
		
		// Juggernaut Dashing Blade Lord for ESL
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/esl_dashing_bladelord_loadingscreen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/juggernaut/esl_dashing_bladelord..."
			"p4path" "//dota/staging/content/dota/models/items/juggernaut/esl_dashing_bladelord..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/esl_dashing_bladelord_loadingscreen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/juggernaut/esl_dashing_bladelord..."
			"p4path" "//dota/staging/game/dota/models/items/juggernaut/esl_dashing_bladelord..."
			
			"p4path" "//dota/staging/game/dota/particles/models/items/juggernaut/esl_dashing_bladelord_weapon/esl_dashing_bladelord_weapon.psf"

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/juggernaut/esl_dashing_bladelord..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/esl_dashing_bladelord..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/esl_dashing_bladelord.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/esl_dashing_bladelord_loadingscreen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/juggernaut/esl_dashing_bladelord_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/juggernaut/esl_dashing_bladelord_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/juggernaut/esl_dashing_bladelord_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/juggernaut/esl_dashing_bladelord_legs.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/juggernaut/esl_dashing_bladelord_weapon.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/esl_dashing_bladelord.txt"
		}
		
		// Legion Commander ESL set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/esl_nether_star_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/legion_commander/esl_netherstar..."
			"p4path" "//dota/staging/content/dota/models/items/legion_commander/esl_netherstar..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/esl_nether_star_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/legion_commander/esl_netherstar..."
			"p4path" "//dota/staging/game/dota/models/items/legion_commander/esl_netherstar..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/legion_commander/esl_netherstar..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/esl_nether_star..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/esl_netherstar_bundle.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/esl_nether_star_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/legion_commander/esl_netherstar_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/legion_commander/esl_netherstar_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/legion_commander/esl_netherstar_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/legion_commander/esl_netherstar_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/legion_commander/esl_netherstar_weapon.txt"
		}
		// Storm Spirit ESL Harmony
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/esl_blossoming_harmony_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/storm_spirit/esl_harmony..."
			"p4path" "//dota/staging/content/dota/models/items/storm_spirit/esl_harmony..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/esl_blossoming_harmony_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/storm_spirit/esl_harmony..."
			"p4path" "//dota/staging/game/dota/models/items/storm_spirit/esl_harmony..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/storm_spirit/esl_harmony..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/esl_blossoming_harmony..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/esl_blossoming_harmony.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/esl_blossoming_harmony_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/storm_spirit/esl_harmony_armor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/storm_spirit/esl_harmony_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/storm_spirit/esl_harmony_head.txt"
		}
		
		// Magnus Avenging ESL set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/esl_avenging_crusader_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/magnataur/esl_avenging_crusader..."
			"p4path" "//dota/staging/content/dota/models/items/magnataur/esl_avenging_crusader..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/esl_avenging_crusader_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/magnataur/esl_avenging_crusader..."
			"p4path" "//dota/staging/game/dota/models/items/magnataur/esl_avenging_crusader..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/magnataur/esl_avenging_crusader..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/esl_avenging_crusader..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/esl_avenging_crusader.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/esl_avenging_crusader_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/magnataur/esl_avenging_crusader_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/magnataur/esl_avenging_crusader_belt.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/magnataur/esl_avenging_crusader_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/magnataur/esl_avenging_crusader_misc.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/magnataur/esl_avenging_crusader_weapon.txt"
		}
		
		// CM Frozen Lotus ESL set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/esl_frozen_lotus_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/crystal_maiden/esl_frozen_lotus..."
			"p4path" "//dota/staging/content/dota/models/items/crystal_maiden/esl_frozen_lotus..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/esl_frozen_lotus_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/crystal_maiden/esl_frozen_lotus..."
			"p4path" "//dota/staging/game/dota/models/items/crystal_maiden/esl_frozen_lotus..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/crystal_maiden/esl_frozen_lotus..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/esl_frozen_lotus..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/esl_frozen_lotus.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/esl_frozen_lotus_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/crystal_maiden/esl_frozen_lotus_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/crystal_maiden/esl_frozen_lotus_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/crystal_maiden/esl_frozen_lotus_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/crystal_maiden/esl_frozen_lotus_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/crystal_maiden/esl_frozen_lotus_weapon.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/esl_frozen_lotus.txt"
		}
		
		// Legion Commander Single Ray Sword
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/legion_commander/single_legioncommander_raysword/..."
			"p4path" "//dota/staging/content/dota/models/items/legion_commander/single_legioncommander_raysword/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/legion_commander/single_legioncommander_raysword/..."
			"p4path" "//dota/staging/game/dota/models/items/legion_commander/single_legioncommander_raysword/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/legion_commander/single_legioncommander_raysword/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/legion_commander/legionnaire_ray_sword.txt"
		}
		
		// Rubick Ornithomancer Cape
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/rubick/ornithomancer_back/..."
			"p4path" "//dota/staging/content/dota/models/items/rubick/ornithomancer_back/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/rubick/ornithomancer_back/..."
			"p4path" "//dota/staging/game/dota/models/items/rubick/ornithomancer_back/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/rubick/ornithomancer_back/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/rubick/ornithomancer_mantle.txt"
		}
		
		// Sniper Shatterhand Gun
		syncException
		{
			"changelist" "-1"
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/sniper/cunning_trappers_weapon/..."
			"p4path" "//dota/staging/content/dota/models/items/sniper/cunning_trappers_weapon/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/sniper/cunning_trappers_weapon/..."
			"p4path" "//dota/staging/game/dota/models/items/sniper/cunning_trappers_weapon/..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/sniper/cunning_trappers_weapon/..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/sniper/shatterhand_carbine.txt"
		}
		
		// Tidehunter Drowning Trench set for Fall Major treasure
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/drowning_trench_loadingscreen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/tidehunter/ancient_leviathan..."
			"p4path" "//dota/staging/content/dota/models/items/tidehunter/ancient_leviathan..."
			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/drowning_trench_loadingscreen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/tidehunter/ancient_leviathan..."
			"p4path" "//dota/staging/game/dota/models/items/tidehunter/ancient_leviathan..."
			"p4path" "//dota/staging/game/dota/particles/econ/items/tidehunter/tidehunter_ancient_leviathan.pcf"
			"p4path" "//dota/staging/game/dota/particles/models/items/tidehunter/ancient_leviathan_weapon/ancient_leviathan_weapon_fx.psf"

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/tidehunter/ancient_leviathan..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/drowning_trench..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/relics_of_the_drowning_trench.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/relics_of_the_drowning_trench_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/grip_of_the_drowning_trench.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/carapace_of_the_drowning_trench.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/belt_of_the_drowning_trench.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/aquemerald_blade.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/leashed_rockshark.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/tidehunter/headshell_of_the_drowning_trench.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/drowning_trench.txt"
		}
		// Ursa Ferocious Heart set for Fall Major treasure
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/fierce_heart_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/content/dota/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/fierce_heart_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/models/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/particles/econ/items/ursa/ursa_fierce_heart.pcf"
			"p4path" "//dota/staging/game/dota/particles/models/items/ursa/fierce_heart_weapon/..."

			"p4path" "//dota/staging/game/dota/resource/flash3/spellicons/ursa/fierce_heart_icon..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/ursa/fierce_heart..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/fierce_heart_loading_screen..."
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/ferocious_heart_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/bracers_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/claws_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/girdle_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/helm_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/ursa/mane_of_the_ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/ferocious_heart.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/items_effects.txt"
		}
		
		// Anti Mage Abolisher Set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/mage_eraser_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/antimage/mage_eraser..."
			"p4path" "//dota/staging/content/dota/models/items/antimage/mage_eraser.."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/mage_eraser_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/antimage/mage_eraser..."
			"p4path" "//dota/staging/game/dota/models/items/antimage/mage_eraser..."
			
			"p4path" "//dota/staging/game/dota/particles/models/items/antimage/mage_eraser..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/antimage/mage_eraser..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/mage_eraser_loading_screen..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/mage_abolisher_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/blade_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/bracers_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/helmet_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/offhand_blade_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/pauldron_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/sash_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/antimage/vest_of_the_mage_abolisher.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/mage_abolisher.txt"
		}
		
		// Gyro Airborne Assault set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/g17_flying_fortress_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/gyrocopter/g17_flying_fortress..."
			"p4path" "//dota/staging/content/dota/models/items/gyrocopter/g17_flying_fortress..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/g17_flying_fortress_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/gyrocopter/g17_flying_fortress..."
			"p4path" "//dota/staging/game/dota/models/items/gyrocopter/g17_flying_fortress..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/gyrocopter/g17_flying_fortress..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/g17_flying_fortress..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/airborne_assault_craft.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/airborne_assault_craft_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/gyrocopter/gatling_guns_of_the_airborne_assault_craft.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/gyrocopter/homing_missile_of_the_airborne_assault_craft.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/gyrocopter/pilots_hat_of_the_airborne_assault_craft.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/gyrocopter/propellor_of_the_airborne_assault_craft.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/gyrocopter/turret_of_the_airborne_assault_craft.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/airborne_assault_craft.txt"
		}
		
		// Timbersaw Molten set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/mad_destructor_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/shredder/mad_destructor..."
			"p4path" "//dota/staging/content/dota/models/items/shredder/mad_destructor..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/mad_destructor_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/shredder/mad_destructor..."
			"p4path" "//dota/staging/game/dota/models/items/shredder/mad_destructor..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/shredder/mad_destructor..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/mad_destructor_loading_screen..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/molten_destructor_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/chainsaw_of_the_molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/exhaust_of_the_molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/fins_of_the_molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/pull_drill_of_the_molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/suit_of_the_molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/wild_hair_of_the_molten_destructor.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/molten_destructor.txt"
		}


		// Dragon Knight Oblivion Blazer set
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/oblivion_blazer_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/dragon_knight/oblivion_blazer..."
			"p4path" "//dota/staging/content/dota/models/items/dragon_knight/oblivion_blazer..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/oblivion_blazer_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/dragon_knight/oblivion_blazer..."
			"p4path" "//dota/staging/game/dota/models/items/dragon_knight/oblivion_blazer..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/dragon_knight/oblivion_blazer..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/oblivion_blazer_loading_screen..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/blazing_oblivion_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/blade_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/bracers_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/cuirass_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/elder_drake_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/helm_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/shield_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/dragon_knight/skirt_of_blazing_oblivion.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/blazing_oblivion.txt"
		}
		
		// Spectre Phantasmal Flowering Shade set Fall Major
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/phantasmal_disruptions_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/spectre/phantasmal_disruptions..."
			"p4path" "//dota/staging/content/dota/models/items/spectre/phantasmal_disruptions..."
			"p4path" "//dota/staging/game/dota/particles/econ/items/spectre/spectre_phantasmal.pcf"

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/phantasmal_disruptions_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/spectre/phantasmal_disruptions..."
			"p4path" "//dota/staging/game/dota/models/items/spectre/phantasmal_disruptions..."
			"p4path" "//dota/staging/game/dota/particles/econ/items/spectre/spectre_phantasmal.pcf"

			"p4path" "//dota/staging/game/dota/resource/flash3/spellicons/spectre/phantasmal_disruptions_icons..."    //optional

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/spectre/phantasmal_disruptions..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/phantasmal_disruptions_loading_screen..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/flowering_shade.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/cursor_pack/flowering_shade_cursor_pack.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/flowering_shade_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/spectre/crest_of_the_flowering_shade.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/spectre/drape_of_the_flowering_shade.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/spectre/edge_of_the_flowering_shade.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/spectre/flow_of_the_flowering_shade.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/phantasmal_disruptions.txt"
		}
		
		// Portraits.txt import
		syncException
		{
			"changelist" "-1"
			
			"p4path" "//dota/staging/game/dota/scripts/npc/portraits.txt"
		}
		// Nayang Rubick Stellar Abyss
		syncException
		{
			"changelist" "-1"
			
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/vestments_of_stellar_abyss_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/rubick/vestments_of_stellar_abyss..."
			"p4path" "//dota/staging/content/dota/models/items/rubick/vestments_of_stellar_abyss..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/vestments_of_stellar_abyss_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/rubick/vestments_of_stellar_abyss..."
			"p4path" "//dota/staging/game/dota/models/items/rubick/vestments_of_stellar_abyss..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/rubick/vestments_of_stellar_abyss..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/vestments_of_stellar_abyss..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/vestments_of_stellar_abyss.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/vestments_of_stellar_abyss_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/rubick/vestments_of_stellar_abyss_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/rubick/vestments_of_stellar_abyss_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/rubick/vestments_of_stellar_abyss_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/rubick/vestments_of_stellar_abyss_weapon.txt"
			"p4path""//dota/staging/game/dota/scripts/items/unencrypted/item_sets/vestments_of_stellar_abyss.txt"
		}
		
		// Nayang Doom Blazing Lord
		syncException
		{
			"changelist" "-1"
			
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/blazing_lord_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/doom/blazing_lord..."
			"p4path" "//dota/staging/content/dota/models/items/doom/blazing_lord..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/blazing_lord_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/doom/blazing_lord..."
			"p4path" "//dota/staging/game/dota/models/items/doom/blazing_lord..."
			
			"p4path" "//dota/staging/game/dota/particles/models/items/doom/blazing_lord_weapon/blazing_lord_weapon.psf"

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/doom/blazing_lord..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/blazing_lord..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/blazing_lord.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/blazing_lord_loading_screen.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_belt.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_tail.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/doom_bringer/blazing_lord_weapon.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/blazing_lord.txt"
		}
		
		// Nayang Timbersaw Steam Woodcutter
		syncException
		{
			"changelist" "-1"
			
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/console/loadingscreens/steam_woodcutter_loading_screen/..."
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/shredder/steam_woodcutter..."
			"p4path" "//dota/staging/content/dota/models/items/shredder/steam_woodcutter..."

			"p4path" "//dota/staging/game/dota/materials/console/loadingscreens/steam_woodcutter_loading_screen/..."
			"p4path" "//dota/staging/game/dota/materials/models/items/shredder/steam_woodcutter..."
			"p4path" "//dota/staging/game/dota/models/items/shredder/steam_woodcutter..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/shredder/steam_woodcutter..."
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/loading_screens/steam_woodcutter..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/bundle/steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/saw_of_the_steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/seat_of_the_steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/furnace_of_the_steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/actuator_of_the_steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/cap_of_the_steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/shredder/claw_of_the_steamcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/steam_woodcutter.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/loading_screen/steam_woodcutter_loading_screen.txt"
		}
		
			// Nayang Morphling Absorption
		syncException
		{
			"changelist" "-1"
			
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/morphling/armor_of_pure_absorption..."
			"p4path" "//dota/staging/content/dota/models/items/morphling/armor_of_pure_absorption..."

			"p4path" "//dota/staging/game/dota/materials/models/items/morphling/armor_of_pure_absorption..."
			"p4path" "//dota/staging/game/dota/models/items/morphling/armor_of_pure_absorption..."
			
			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/morphling/armor_of_pure_absorption..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/armor_of_pure_absorption_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/armor_of_pure_absorption_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/armor_of_pure_absorption_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/armor_of_pure_absorption_misc.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/morphling/armor_of_pure_absorption_shoulder.txt"
		}
		
		// Nayang Disruptor Lightning
		syncException
		{
			"changelist" "-1"
			
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/disruptor/lightning_strike..."
			"p4path" "//dota/staging/content/dota/models/items/disruptor/lightning_strike..."

			"p4path" "//dota/staging/game/dota/materials/models/items/disruptor/lightning_strike..."
			"p4path" "//dota/staging/game/dota/models/items/disruptor/lightning_strike..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/disruptor/lightning_strike..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/disruptor/lightning_strike_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/disruptor/lightning_strike_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/disruptor/lightning_strike_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/disruptor/lightning_strike_legs.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/disruptor/lightning_strike_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/disruptor/lightning_strike_weapon.txt"
		}
		
		// Nayang Centaur Lord Wilderness
		syncException
		{
			"changelist" "-1"
			
			"changelist" "-1"
			
			"p4path" "//dota/staging/content/dota/materialsrc/models/items/centaur/lord_of_wilderness..."
			"p4path" "//dota/staging/content/dota/models/items/centaur/lord_of_wilderness..."

			"p4path" "//dota/staging/game/dota/materials/models/items/centaur/lord_of_wilderness..."
			"p4path" "//dota/staging/game/dota/models/items/centaur/lord_of_wilderness..."

			"p4path" "//dota/staging/game/dota/resource/flash3/images/econ/items/centaur/lord_of_wilderness..."

			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_arms.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_back.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_belt.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_head.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_shoulder.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_tail.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_definitions/wearable/centaur/lord_of_wilderness_weapon.txt"
			"p4path" "//dota/staging/game/dota/scripts/items/unencrypted/item_sets/lord_of_wilderness.txt"
		}
	}
}
