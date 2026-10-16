# Snake — Lua Game Programming Assignment

A classic Snake game built with **LÖVE2D** and **Lua**. Guide the snake around the grid, collect food, and avoid the walls and your own tail. Each food item increases the score and gradually speeds up the game.

The project demonstrates a modular game structure and several programming patterns: state management, command-based input, an entity-component-style container, vector metatables, and an event system.

## Features

- Menu and gameplay states
- Grid-based movement with keyboard controls
- Wall and self-collision detection
- Food collection, score tracking, and gradually increasing speed
- Persistent high score
- Event notification when food is collected

## Project Structure

```text
snake_game/
├── main.lua                 # LÖVE callbacks, input bindings, and game entry point
├── gamestate.lua            # State manager for menu and gameplay
├── entity.lua               # Entity-component-style container
├── vector2.lua              # 2D vector type and metamethods
├── highscore.lua            # High-score file reading and writing
├── input.lua                # Command-style keyboard input bindings
├── events.lua               # Observer-style event system
└── states/
    ├── menu_state.lua       # Start menu
    ├── game_state.lua       # Gameplay state wrapper
    └── snake_game.lua       # Snake rules, update logic, and rendering
```

### Main modules

| File | Responsibility |
| --- | --- |
| `main.lua` | Entry point for LÖVE callbacks. Creates the state manager and input handler, binds keys, and delegates updates and drawing. |
| `gamestate.lua` | Manages the active state and switches between the menu and playing states. |
| `entity.lua` | Provides an entity with a component table and methods to add, retrieve, and check components. |
| `vector2.lua` | Implements 2D vectors and the `__add`, `__eq`, and `__tostring` metamethods. |
| `highscore.lua` | Reads and writes the high score in `highscore.txt`, closing the file handle after each operation. |
| `input.lua` | Maps keys to command callbacks and dispatches a command when a bound key is pressed. |
| `events.lua` | Provides `subscribe` and `emit` operations for event listeners. |
| `states/menu_state.lua` | Draws the start menu. |
| `states/game_state.lua` | Adapts the snake game instance to the state manager interface. |
| `states/snake_game.lua` | Implements the snake, food, scoring, collisions, speed progression, and gameplay rendering. |

`entity.lua` is included as the assignment's entity-component-style example; the current snake gameplay is implemented directly in `snake_game.lua`.

## Requirements

- LÖVE2D installed and available from the command line, or its graphical application
- The course/assignment's Lua 5.4 environment, if Lua 5.4 is required

> **Runtime note:** LÖVE's bundled Lua interpreter depends on the LÖVE version/build and may not be Lua 5.4. Use the runtime prescribed by your course and verify its compatibility with the assignment requirement.

## How to Run

Run the game from the project directory:

### Windows

```powershell
love.exe .
```

If `love.exe` is not on your `PATH`, use the full path to the LÖVE executable, followed by the project directory.

### macOS

```bash
love .
```

If using the application bundle directly, open LÖVE and select the project folder.

### Linux

```bash
love .
```

The project root contains `main.lua`, which LÖVE uses as the application entry point. No external Lua packages are required.

## Controls

| Key | Action |
| --- | --- |
| `W`, `A`, `S`, `D` | Move up, left, down, and right |
| Arrow keys | Move up, left, down, and right |
| `Enter` | Start the game from the menu |
| `Space` | Restart after game over |
| `Escape` | Quit |

## Modern Lua Features and Patterns

- **Modules:** Each part of the game lives in its own Lua file and exposes its interface with `return` and `require`.
- **Metatables:** The vector, input, entity, game-state manager, and snake game tables use metatables with `__index` to provide instance methods.
- **Metamethods:** `vector2.lua` defines `__add` for vector addition, `__eq` for vector equality, and `__tostring` for readable vector output.
- **Closures and callbacks:** Input bindings and event subscriptions use functions as callbacks.
- **Tables as objects:** Lua tables hold game state and instance data, while colon syntax (`object:method()`) passes the receiver as `self`.
- **Command and Observer patterns:** Input commands decouple key bindings from actions; the event system notifies subscribers when food is eaten.

The assignment describes the target as **LÖVE2D with Lua 5.4**. The features listed above are standard Lua constructs; the exact interpreter version available to a game depends on the LÖVE build being used.

## Submission Checklist

- [x] **Start Menu:** Displays a menu and starts the game with `Enter`.
- [x] **Movement:** Supports WASD and arrow keys.
- [x] **Gameplay:** Food increases the score; the snake grows and speeds up; wall and self-collisions end the game.
- [x] **High Score:** Loads and saves the best score using `highscore.lua`.
- [x] **Metamethods:** Vector type implements `__add`, `__eq`, and `__tostring`.
- [x] **Event System Bonus:** `events.lua` notifies subscribers when food is collected.
