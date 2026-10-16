local MenuState = {}

function MenuState:update(dt)
end

function MenuState:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("SNAKE GAME", 250, 200, 0, 2, 2)
    love.graphics.print("Press ENTER to Start", 230, 280)
end

return MenuState