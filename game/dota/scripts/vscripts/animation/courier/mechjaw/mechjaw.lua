--============ Copyright (c) Valve Corporation, All rights reserved. ==========
--
-- source1import auto-generated animation script
-- local changes will be overwritten if source1import if run again on this asset
--
-- mdl: models\courier\mechjaw\mechjaw.mdl
--
--=============================================================================



-- AsLookLayer
model:CreateSequence(
	{
		name = "@mechjaw_turns_lookFrame_0",
		snap = true,
		delta = true,
		hidden = true,
		cmds = {
			{ cmd = "fetchframe", sequence = "@mechjaw_turns", frame = 0, dst = 0 },
			{ cmd = "fetchframe", sequence = "@mechjaw_turns", frame = 1, dst = 1 },
			{ cmd = "subtract", dst = 0, src = 1 }
		}
	}
)

model:CreateSequence(
	{
		name = "@mechjaw_turns_lookFrame_1",
		snap = true,
		delta = true,
		hidden = true,
		cmds = {
			{ cmd = "fetchframe", sequence = "@mechjaw_turns", frame = 1, dst = 0 },
			{ cmd = "fetchframe", sequence = "@mechjaw_turns", frame = 1, dst = 1 },
			{ cmd = "subtract", dst = 0, src = 1 }
		}
	}
)

model:CreateSequence(
	{
		name = "@mechjaw_turns_lookFrame_2",
		snap = true,
		delta = true,
		hidden = true,
		cmds = {
			{ cmd = "fetchframe", sequence = "@mechjaw_turns", frame = 2, dst = 0 },
			{ cmd = "fetchframe", sequence = "@mechjaw_turns", frame = 1, dst = 1 },
			{ cmd = "subtract", dst = 0, src = 1 }
		}
	}
)

model:CreateSequence(
	{
		name = "mechjaw_turns",
		delta = true,
		poseParamX = model:CreatePoseParameter( "turn", -1, 1, 0, false ),
		sequences = {
			{ "@mechjaw_turns_lookFrame_0", "@mechjaw_turns_lookFrame_1", "@mechjaw_turns_lookFrame_2" }
		}
	}
)

-- AsTurningRun

model:CreateSequence(
	{
		name = "mechjaw_run",
		sequences = {
			{ "@mechjaw_run" }
		},
		addlayer = {
			"mechjaw_turns"
		},
		activities = {
			{ name = "ACT_DOTA_RUN", weight = 1 }
		}
	}
)


-- AsTurningRun

model:CreateSequence(
	{
		name = "mechjaw_run_B",
		sequences = {
			{ "@mechjaw_run_B" }
		},
		addlayer = {
			"mechjaw_turns"
		},
		activities = {
			{ name = "ACT_DOTA_RUN", weight = 1 }
		}
	}
)
