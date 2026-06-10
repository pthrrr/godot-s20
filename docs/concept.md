# Arena FPS -- Game Concept

## Overview

A wave-based first-person survival game set on a floating platform in an unknown space. The player must defend against increasingly large waves of hostile creatures while avoiding being pushed off the platform's edges. Between waves, glass walls provide temporary protection. The game ends when the player falls off the platform, and a highscore leaderboard tracks the best runs.

## Game Story

You wake up standing on a platform, suspended in a vast, empty void. There is nothing else -- no ground, no sky, no horizon. Just the platform beneath your feet and silence all around.

At first it seems harmless. Still. Almost peaceful.

Then you hear it. A low, mechanical hum, faint at first, growing louder. You look around and see them: strange machines, hovering in slow, unpredictable orbits around the platform. They pulse with a dull light. You do not know what they are. You do not know what they want.

You take stock of your surroundings. The platform is a simple square -- solid ground, but with open edges on every side. One misstep and you fall into the void below. You notice a faint, translucent barrier lining the perimeter -- glass-like walls that shimmer in the dim light. They seem sturdy enough. For now, they offer some comfort.

Then the machines activate. One by one, they begin releasing creatures -- bat-like things with sharp, angular wings. Vultures. They swarm just beyond the glass walls, circling, screeching. Their movements are focused. Aggressive. They are watching you.

Your hands tighten around a weapon you did not notice you were holding.

The glass walls shatter. They crack, splinter, and dissolve into nothing. The barrier is gone. You are exposed.

The vultures rush in. You fire. Each shot connects. But they keep coming, and they are not trying to hurt you -- they are trying to push you. Their bodies slam into yours, shoving you backward, toward the edges, toward the fall. You dig in. You hold your ground. You survive.

The attack subsides. For a brief moment, everything is quiet again. The glass walls reform, rising from the platform's edges, sealing you in once more. You catch your breath.

But the calm does not last. The machines activate again. More creatures this time. The walls shatter once more.

Each assault brings more enemies. The swarm grows larger, the pressure harder to resist. You fight wave after wave, holding out as long as you can, until eventually the force is too much and you are pushed over the edge.

You fall.

## Gameplay Flow

### 1. Launch
The game starts with the start menu (existing). The player clicks "Start".

### 2. Cinematic Intro
A camera flies over and around the level, giving the player an overview of the environment: the platform, the spawners orbiting in the distance, the glass walls, the void below. The camera then swoops down and transitions smoothly into the player's first-person view.

### 3. Player Takes Control
The player now controls the character. The glass walls are up. The spawners are circling but have not yet activated. The player can look around, move, and get oriented.

### 4. Wave Start
The spawners begin spawning creatures outside the glass walls. A 5-second countdown appears on screen. When the countdown reaches zero:
- The glass walls shatter (visual effect: crush, crack, dissolve, or shatter)
- A "Wave N" announcement appears on screen
- The wave timer starts counting down

### 5. Combat Phase
Creatures rush the player. The player shoots them for points. Creatures push the player on contact (knockback). The player must fight while maintaining position on the platform.

### 6. Wave End
When the wave timer reaches zero:
- Remaining creatures are cleared or flee
- The score for the wave is tallied and added to the total
- The glass walls rebuild (visual effect: rise, materialize, reform)
- Brief calm period before the next wave

### 7. Next Wave
The cycle repeats with increased difficulty (more creatures per wave). Each wave follows the same pattern: spawn, countdown, walls shatter, fight, wave ends, walls rebuild.

### 8. Death
The player dies by falling off the platform (pushed by creatures or by accident). The kill plane triggers game over.

### 9. Game Over / Highscore
A highscore board appears showing the player's total score, wave reached, and a name entry field. Previous highscores are displayed. The player can restart to try again.

## Core Mechanics

### Wave System
- Waves are numbered sequentially (Wave 1, Wave 2, ...)
- Each wave has a fixed duration (game timer countdown)
- Difficulty scales by increasing the number of creatures spawned per wave
- Between waves there is a brief calm phase with glass walls providing protection

### Glass Wall Barrier
- Transparent/translucent walls around the platform perimeter
- Present between waves, providing safety during the calm phase
- Shatter at the start of each combat phase (after 5-second countdown)
- Rebuild at the end of each wave
- Visual effects for both shattering and rebuilding

### Knockback
- Creatures do not deal direct damage to the player
- On contact, creatures push the player (knockback force)
- This is the primary threat: being pushed off the platform edge
- Knockback direction is from the creature toward the player

### Platform & Death
- The platform is a square with open edges
- Falling off the platform is the only way to die
- The existing kill plane detects when the player has fallen

### Scoring & Highscore
- Each creature killed awards points
- Score is tallied per wave and accumulated across the run
- On death, the total score and wave number reached are displayed
- The player can enter a name for the highscore leaderboard
- Highscores are persisted (local storage for web, file for desktop)

### Cinematic Intro
- Pre-gameplay camera sequence showing the level from various angles
- Camera follows a predefined path (or animated via AnimationPlayer)
- Transitions into the player's camera to begin gameplay
- Plays only on first launch or can be skipped

## Multiplayer

### Split-Screen (Phase 1)
- Adapt the wave system for two players on the same platform
- Both players share the same waves, glass walls, and score
- Both players can be pushed off independently
- Game ends when the last player falls

### Network Multiplayer (Phase 2)
- Online multiplayer with multiple players on the same platform
- Shared wave system and scoring
- Implementation details to be determined after split-screen is complete

## Future Additions

- **HP system**: Creatures can deal direct damage in addition to knockback
- **Level design variations**: Different platform shapes, obstacles, or environmental hazards per wave
- **Tougher creatures**: Faster, stronger, or new creature types in later waves
- **Power-ups**: Temporary buffs (faster fire rate, stronger knockback resistance, etc.)
- **Audio design**: Ambient tension, spawner hum, wall shatter sounds, wave announcements
