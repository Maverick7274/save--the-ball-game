local love = require "love"
local enemy = require "Enemy"
local button = require "Button"

math.randomseed(os.time())

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

local buttons = {
    menu_state = {}
}

local enemies = {}

local function startNewGame()
    game.state["menu"] = false
    game.state["running"] = true

    table.insert(enemies, 1, enemy())

end


function love.mousepressed(x, y, button, istouch, presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do
                    buttons.menu_state[index]:checkPressed(x, y, player.radius)
                end
            end
        end
    end
end

function love.load()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.mouse.setVisible(false)

    buttons.menu_state.play_game = button("Start", startNewGame, nil, 120, 50)
    buttons.menu_state.options = button("Options", nil, nil, 120, 50)
    buttons.menu_state.quit = button("Quit", love.event.quit, nil, 120, 50)

end

function love.update()
    player.x, player.y = love.mouse.getPosition()

    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:move(player.x, player.y)
        end
    end
end

function love.draw()

    love.graphics.printf("FPS:" .. love.timer.getFPS(), love.graphics.newFont(16), 10, love.graphics.getHeight() - 30, love.graphics.getWidth())
    
    if game.state["running"] then
        for i = 1, #enemies do
            enemies[i]:draw()
        end

        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", player.x, player.y, player.radius)
    
    elseif game.state["menu"] then
        buttons.menu_state.play_game:draw(570, 500, 45, 20)
        buttons.menu_state.options:draw(570, 570, 45, 20)
        buttons.menu_state.quit:draw(570, 640, 45, 20)
    end
    if not game.state["running"] then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", player.x, player.y, player.radius / 2)
    end

end