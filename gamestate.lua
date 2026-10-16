local GameState = {}
GameState.__index = GameState

function GameState:new()
    local state = {
        current = "menu",
        states = {
            menu = require("states.menu_state"),
            playing = require("states.game_state")
        }
    }
    return setmetatable(state, GameState)
end

function GameState:switch(newState)
    if self.states[newState] then
        self.current = newState
        if self.states[newState].enter then
            self.states[newState]:enter()
        end
    end
end

function GameState:update(dt)
    local currentState = self.states[self.current]
    if currentState and currentState.update then
        currentState:update(dt)
    end
end

function GameState:draw()
    local currentState = self.states[self.current]
    if currentState and currentState.draw then
        currentState:draw()
    end
end

return GameState