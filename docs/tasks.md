# Arena FPS -- Implementation Tasks

## Implementation Order

1. New base level -- square platform with hovering spawners
2. Core gameplay -- wave system, knockback, creature behavior
3. Game over on fall -- kill plane ends game instead of respawn
4. UI/HUD -- wave announcements, score
5. Scoring & highscore
6. Glass walls, countdowns, cinematic intro
7. Split-screen multiplayer
8. Network multiplayer

## Assistant Notes

Instructions and preferences from the user:

- The user handles all implementation (scene building, gameplay coding) themselves
- The assistant provides guidance, code suggestions, documentation, and git operations
- The user prefers to make UI and scene changes in the Godot editor -- give instructions for editor tasks, do not edit .tscn files unless explicitly asked
- Do not push to repo unless explicitly asked
- Changes to `game.gd` and `game.tscn` are branch-specific (different logic per branch)
- When porting changes across branches, `game.gd` and `game.tscn` need manual adaptation (different scene structures per branch)
- The user gets frustrated when unauthorized changes are made -- only do what is explicitly asked
- Glass walls, countdowns, scoreboard are lower priority -- basic gameplay first
- Keep things simple for the basic gameplay, complexity can be added later

## Code Notes

Key locations in the existing codebase to be aware of:

- `mob/mob.gd:28-34` -- Raycast already detects player on contact but does `pass`. This is where knockback logic goes.
- `mob/mob.gd:16` -- Hardcoded path `get_node("/root/Game/Level1/Player")`. Will need updating if level structure changes.
- `mob/mob.gd:7` -- `speed` uses `randf_range` at class level (same bug the spawner had). Move to `_ready()`.
- `level_1.gd:6` -- `MAX_MOBS = 20` cap and spawner timer stop/start logic. Will need to become wave-aware.
- `game.gd:46-53` -- Kill plane currently respawns the player. Needs to trigger game over instead.
- `player/player.gd:34-35` -- Velocity is set as absolute values each frame (`velocity.x = direction.x * SPEED`). Any external forces (knockback) applied to the player will be overwritten next frame unless blended.

---

## Core Wave System

- [ ] Create a WaveManager script (or extend `game.gd`) to handle wave state machine
- [ ] Define wave states: `INTRO`, `CALM`, `COUNTDOWN`, `COMBAT`, `WAVE_END`, `GAME_OVER`
- [ ] Implement wave counter (Wave 1, Wave 2, ...)
- [ ] Implement wave timer (countdown during combat phase)
- [ ] Scale creature spawn count per wave (e.g. base + N per wave)
- [ ] Clear or despawn remaining creatures when wave timer ends
- [ ] Trigger calm phase after wave ends (walls rebuild, brief pause)
- [ ] Trigger next wave after calm phase
- [ ] Remove or replace the existing single round timer with the wave system

## Glass Wall Barrier

- [ ] Create glass wall mesh/model around the platform perimeter
- [ ] Add collision to the glass walls (StaticBody3D + CollisionShape3D)
- [ ] Implement wall shatter effect (visual: particles, animation, or shader dissolve)
- [ ] Disable wall collision when walls shatter (start of combat phase)
- [ ] Implement wall rebuild effect (visual: rise, materialize, or reform)
- [ ] Re-enable wall collision when walls rebuild (end of wave)
- [ ] Tie wall state to wave state machine (up during CALM, down during COMBAT)

## Cinematic Intro

- [ ] Create a camera path (Path3D + PathFollow3D or AnimationPlayer)
- [ ] Animate camera flying over and around the level
- [ ] Show spawners, platform, glass walls, and the void during flyover
- [ ] Transition camera smoothly from cinematic to player's first-person view
- [ ] Disable player input during cinematic
- [ ] Start the first wave after cinematic ends
- [ ] Add option to skip cinematic (e.g. on restart or button press)

## Creature Behavior

- [ ] Implement player targeting (creatures move toward the player)
- [ ] Add knockback on creature-player contact (push player away from creature)
- [ ] Tune knockback force so creatures can push the player off edges over time
- [ ] Prevent creatures from spawning inside the glass walls (spawn outside barrier)
- [ ] Scale number of creatures spawned per wave
- [ ] Creatures enter through the broken glass walls when combat starts
- [ ] Handle creature cleanup at end of wave (despawn, death animation, or flee)

## Spawner Behavior

- [ ] Spawners activate at the start of each wave's countdown phase
- [ ] Spawners produce creatures outside the glass wall perimeter
- [ ] Spawner spawn rate increases with wave number (more creatures per wave)
- [ ] Spawner circular hovering movement (already implemented)
- [ ] Spawner collision (already implemented)

## UI / HUD

- [ ] Wave announcement display ("Wave 1", "Wave 2", ...) -- large text, fades after a few seconds
- [ ] 5-second countdown overlay before glass walls shatter
- [ ] Score display during gameplay (already exists, adapt for wave system)
- [ ] Wave number display during gameplay
- [ ] Game over screen with final score and wave reached
- [ ] Highscore entry: name input field on game over screen
- [ ] Highscore leaderboard display (list of names + scores)

## Scoring & Highscore

- [ ] Award points per creature killed
- [ ] Track score per wave and cumulative total
- [ ] Display wave score summary between waves
- [ ] Persist highscores locally (file for desktop, localStorage for web)
- [ ] Load and display highscore leaderboard on game over
- [ ] Sort leaderboard by score descending
- [ ] Limit leaderboard to top N entries (e.g. top 10)

## Audio (Future)

- [ ] Spawner ambient hum / mechanical sound
- [ ] Glass wall shatter sound effect
- [ ] Glass wall rebuild sound effect
- [ ] Wave start announcement sound
- [ ] Creature sounds (idle, attacking, death)
- [ ] Ambient tension music that escalates with wave number
- [ ] Game over sound/music

## Platform & Environment

- [ ] Review platform geometry for wave-based gameplay (edges, size, slope sliding)
- [ ] Ensure kill plane works correctly for game over trigger
- [ ] Connect kill plane to game over / highscore flow (instead of respawn)
- [ ] Consider environmental variations for later waves (future)

## Start Menu & Game Flow

- [ ] Adapt start menu for wave-based game (Start triggers cinematic intro)
- [ ] Remove or adapt the "Resume" functionality for wave-based gameplay
- [ ] Restart resets wave counter, score, and all game state
- [ ] Ensure `static var first_launch` still works with wave system
- [ ] Handle Escape key during gameplay (pause menu)

## Split-Screen Multiplayer

- [ ] Adapt wave system for two players
- [ ] Both players share the same wave state and glass walls
- [ ] Track individual scores or shared score (decide)
- [ ] Game ends when the last player falls off
- [ ] Adapt game over / highscore for multiplayer
- [ ] Test spawner scaling with two players

## Network Multiplayer (Future Phase)

- [ ] Research Godot 4 networking (ENet, WebSocket, or WebRTC)
- [ ] Implement lobby / matchmaking
- [ ] Synchronize wave state across clients
- [ ] Synchronize player positions and actions
- [ ] Handle player disconnect / reconnect
- [ ] Shared or individual scoring in network play
