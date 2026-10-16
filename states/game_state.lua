local SnakeGame = require("states.snake_game")
local gameInstance = SnakeGame:new()

local GameStateWrapper = {}

function GameStateWrapper:update(dt)
    gameInstance:update(dt)
end

function GameStateWrapper:draw()
    gameInstance:draw()
end

function GameStateWrapper:changeDirection(dx, dy)
    gameInstance:changeDirection(dx, dy)
end

function GameStateWrapper:reset()
    gameInstance:reset()
end

function GameStateWrapper:isGameOver()
    return gameInstance.gameOver
end

return GameStateWrapper