local Vector2 = require("vector2")
local HighScore = require("highscore")
local Events = require("events")

Events:subscribe("food_eaten", function(data)
    print("Score increased to: " .. data.score)
end)

local SnakeGame = {}
SnakeGame.__index = SnakeGame

local function spawnFood(self)
    while true do
        local x = math.random(0, self.grid - 1)
        local y = math.random(0, self.grid - 1)
        local free = true
        for _, seg in ipairs(self.snake) do
            if seg.x == x and seg.y == y then
                free = false
                break
            end
        end
        if free then
            self.food = Vector2:new(x, y)
            return
        end
    end
end

function SnakeGame:new()
    local game = {
        grid = 20,
        cell = 30,
        initialStepTime = 0.12,
        stepTime = 0.12,
        timer = 0,
        score = 0,
        highScore = HighScore:load(),
        gameOver = false,
        snake = {
            Vector2:new(10, 10),
            Vector2:new(9, 10),
            Vector2:new(8, 10)
        },
        direction = Vector2:new(1, 0),
        nextDirection = Vector2:new(1, 0),
        food = Vector2:new(15, 15)
    }
    setmetatable(game, SnakeGame)
    spawnFood(game)
    return game
end

function SnakeGame:reset()
    self.snake = {
        Vector2:new(10, 10),
        Vector2:new(9, 10),
        Vector2:new(8, 10)
    }
    self.direction = Vector2:new(1, 0)
    self.nextDirection = Vector2:new(1, 0)
    self.timer = 0
    self.score = 0
    self.stepTime = self.initialStepTime
    self.gameOver = false
    spawnFood(self)
end

function SnakeGame:changeDirection(dx, dy)
    if (dx ~= 0 and self.direction.x == 0) or (dy ~= 0 and self.direction.y == 0) then
        self.nextDirection = Vector2:new(dx, dy)
    end
end

function SnakeGame:update(dt)
    if self.gameOver then return end

    self.timer = self.timer + dt
    if self.timer >= self.stepTime then
        self.timer = self.timer - self.stepTime
        self.direction = self.nextDirection

        local head = self.snake[1]
        local newHead = Vector2:new(head.x + self.direction.x, head.y + self.direction.y)

        if newHead.x < 0 or newHead.x >= self.grid or newHead.y < 0 or newHead.y >= self.grid then
            self.gameOver = true
            if self.score > self.highScore then
                self.highScore = self.score
                HighScore:save(self.highScore)
            end
            return
        end

        for _, seg in ipairs(self.snake) do
            if seg == newHead then
                self.gameOver = true
                if self.score > self.highScore then
                    self.highScore = self.score
                    HighScore:save(self.highScore)
                end
                return
            end
        end

        table.insert(self.snake, 1, newHead)

        if newHead == self.food then
            self.score = self.score + 1

            Events:emit("food_eaten", { score = self.score })

            self.stepTime = math.max(0.05, self.stepTime - 0.003)

            spawnFood(self)
        else
            table.remove(self.snake)
        end
    end
end

function SnakeGame:draw()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.12)

    love.graphics.setColor(1, 0.3, 0.3)
    love.graphics.rectangle("fill", self.food.x * self.cell, self.food.y * self.cell, self.cell - 2, self.cell - 2)

    for i, seg in ipairs(self.snake) do
        if i == 1 then
            love.graphics.setColor(0.5, 1, 0.6)
        else
            love.graphics.setColor(0.3, 0.8, 0.4)
        end
        love.graphics.rectangle("fill", seg.x * self.cell, seg.y * self.cell, self.cell - 2, self.cell - 2)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. self.score, 10, 10)
    love.graphics.print("High Score: " .. self.highScore, 10, 30)

    if self.gameOver then
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.rectangle("fill", 0, 0, self.grid * self.cell, self.grid * self.cell)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf("GAME OVER\nScore: " .. self.score .. "\nPress SPACE to restart", 0, (self.grid * self.cell) / 2 - 30, self.grid * self.cell, "center")
    end
end

return SnakeGame