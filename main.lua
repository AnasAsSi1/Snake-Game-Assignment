local GameState = require("gamestate")
local Input = require("input")

local gameState = GameState:new()
local input = Input:new()

function love.load()
    love.window.setMode(20 * 30, 20 * 30)
    love.window.setTitle("Snake Game - Assignment")

    input:bind("up", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(0, -1)
        end
    end)
    input:bind("w", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(0, -1)
        end
    end)

    input:bind("down", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(0, 1)
        end
    end)
    input:bind("s", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(0, 1)
        end
    end)

    input:bind("left", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(-1, 0)
        end
    end)
    input:bind("a", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(-1, 0)
        end
    end)

    input:bind("right", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(1, 0)
        end
    end)
    input:bind("d", function()
        if gameState.current == "playing" then
            gameState.states.playing:changeDirection(1, 0)
        end
    end)

    input:bind("return", function()
        if gameState.current == "menu" then
            gameState:switch("playing")
        end
    end)

    input:bind("space", function()
        if gameState.current == "playing" and gameState.states.playing:isGameOver() then
            gameState.states.playing:reset()
        end
    end)
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    input:handleKey(key)
end