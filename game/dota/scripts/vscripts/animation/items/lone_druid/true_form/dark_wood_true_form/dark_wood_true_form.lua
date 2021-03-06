model:CreateWeightlist(
	"upperbody_rabid",
	{
		{ "Spine_0", 1 },
		{ "Root_0", 0 },
		{ "thigh_R", 0 },
		{ "Bum6_0", 0 },
		{ "thigh_L", 0 }
	}
)

model:CreateSequence(
	{
		name = "anim_override_ability2",
		sequences = {
			{ "@anim_override_ability2" }
		},
		weightlist = "upperbody_rabid",
		activities = {
			{ name = "ACT_DOTA_OVERRIDE_ABILITY_2", weight = 1 }
		}
	}
)



-- Workshop Importer [run_anims]: Pose sequence
model:CreateSequence(
		  {
				name = "turn_center",
				delta = true,
				fadeInTime = 0,
				fadeOutTime = 0,
				fps = 30,
				framerangesequence = "center_pose",
				cmds = {
					 { cmd = "sequence", sequence = "center_pose", dst = 1 },
					 { cmd = "fetchframe", sequence = "center_pose", frame = 0, dst = 2 },
					 { cmd = "subtract", dst = 1, src = 2 },
					 { cmd = "slerp", dst = 0, src = 1 }
				}
		  }
)
-- Workshop Importer [run_anims]: Pose sequence
model:CreateSequence(
		  {
				name = "turn_left",
				delta = true,
				fadeInTime = 0,
				fadeOutTime = 0,
				fps = 30,
				framerangesequence = "left_pose",
				cmds = {
					 { cmd = "sequence", sequence = "left_pose", dst = 1 },
					 { cmd = "fetchframe", sequence = "center_pose", frame = 0, dst = 2 },
					 { cmd = "subtract", dst = 1, src = 2 },
					 { cmd = "slerp", dst = 0, src = 1 }
				}
		  }
)
-- Workshop Importer [run_anims]: Pose sequence
model:CreateSequence(
		  {
				name = "turn_right",
				delta = true,
				fadeInTime = 0,
				fadeOutTime = 0,
				fps = 30,
				framerangesequence = "right_pose",
				cmds = {
					 { cmd = "sequence", sequence = "right_pose", dst = 1 },
					 { cmd = "fetchframe", sequence = "center_pose", frame = 0, dst = 2 },
					 { cmd = "subtract", dst = 1, src = 2 },
					 { cmd = "slerp", dst = 0, src = 1 }
				}
		  }
)
-- Workshop Importer [run_anims]: Turns sequence
model:CreateSequence(
	  {
			name = "turns",
			delta = true,
		    fadeInTime = 0.2,
			fadeOutTime = 0.2,
			poseParamX = model:CreatePoseParameter( "turn", -1, 1, 0, false ),
			sequences = {
				 { "turn_left", "turn_center", "turn_right" }
			}
	  }
)
-- Workshop Importer [run_anims]: Run sequence
model:CreateSequence(
	{
		name = "run",
		looping = true,
		sequences = {
			{ "@run" }
		},
		addlayer = { "turns" },
		activities = {
				{ name = "ACT_DOTA_RUN", weight = 1 }
		}
	}
)
-- Workshop Importer [run_anims]: Run sequence
model:CreateSequence(
	{
		name = "run_injured",
		looping = true,
		sequences = {
			{ "@run_injured" }
		},
		addlayer = { "turns" },
		activities = {
				{ name = "ACT_DOTA_RUN", weight = 1 },
				{ name = "injured", weight = 1 }
		}
	}
)
-- Workshop Importer [run_anims]: Run sequence
model:CreateSequence(
	{
		name = "run_haste",
		looping = true,
		sequences = {
			{ "@run_haste" }
		},
		addlayer = { "turns" },
		activities = {
				{ name = "ACT_DOTA_RUN", weight = 1 },
				{ name = "haste", weight = 1 }
		}
	}
)
