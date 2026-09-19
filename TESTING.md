# Verification

Verified in Roblox Studio 0.739 on 20 September 2026 (Sydney time).

## Runtime results

- Initial checkpoint is zero: passed.
- Touching lava causes death and respawn at Start: passed.
- Checkpoint activation and lava respawn at stages 4, 8 and 12: passed.
- Touching an earlier checkpoint does not lower progress: passed.
- Touching Goal before the final checkpoint does not award completion: passed.
- Red hurdle death returns the character to checkpoint 12: passed.
- Goal after the final checkpoint sets completion: passed.
- Celebration HUD was visually observed in the client viewport.
- All 16 platform-to-platform transitions, including Goal: passed using actual Humanoid movement and jump physics.
- Hurdles at stages 6, 10 and 14: passed.

Output markers: `OBBY_QA ALL PASS` and `OBBY_JUMP ALL PASS`.

An initial character-teleport respawn implementation failed runtime verification and was replaced with SpawnLocation and Player.RespawnLocation before the successful tests and publication. The initial center-distance assertion was also corrected to account for Roblox spawning within the platform area.

## Reproduce

1. Open the place in Studio and start a fresh single-player Play session.
2. Select the Server tab and paste `runtime-qa.luau` into the Studio command bar. Run with Ctrl+Enter. Wait for `OBBY_QA ALL PASS` in Output.
3. In the same session, run `jump-qa.luau` from the Server command bar. Wait for `OBBY_JUMP ALL PASS`.
4. Inspect the client HUD, then stop Play. Do not add the QA files to ServerScriptService or publish them.

The checkpoint test teleports the avatar to trigger actual touch/death/respawn events. The jump test positions the avatar at each take-off edge, then uses Humanoid movement and jumping to cross each gap. This checks each segment; it is not a continuous keyboard-only playthrough. Production multiplayer, mobile, and a separate live Roblox client session have not been tested.

## Export checks

The standalone server and HUD sources match the source embedded in the saved place. The place contains four SpawnLocations (Start, Stage4, Stage8, Stage12) and only the two production scripts.
