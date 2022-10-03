local love = require "love"

local game = {
    difficulty = 1,
    state = {
        menu = true,
        pause = false,
        running = false,
        ended = false,
    }
}

local player = {
    radius = 20,
    x = 0,
    x = 0,
}

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.mouse.setVisible(false)
end

function love.update()
    player.x, player.y = love.mouse.getPosition()
end

function love.draw()

    love.graphics.printf("FPS:" .. love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30, love.graphics.getWidth())
    
    if game.state["running"] then
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end
    if not game.state["running"] then
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", player.x, player.y, player.radius)
    end

end