-- It's was a test for the coding club project --
-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

-- Function for load the sprite of the player_asset --
function love.load()
    love.window.setMode(800, 600)
    love.graphics.setBackgroundColor(0, 0.5, 1)
    player = {}
    player.x = 100
    player.y = 100
    player.vy = 0
    player.size = 50
    player.speed = 400
    gravity = 800
    ground = 400
    test = 0
    test_bar = 450
end

-- Function for use the deplacement --
function love.update(dt)
    player.vy = player.vy + gravity * dt
    player.y = player.y + player.vy * dt

    if player.y + player.size > ground then
        player.y = ground - player.size
        player.vy = 0
    end

    if love.keyboard.isDown("right") then
        test = test - 5
        test_bar = test_bar - 5
    end
    if love.keyboard.isDown("left") then
        test = test + 5
        test_bar = test_bar + 5
    end
end

-- function for manage the input --
function love.keypressed(key)
    if key == "space" then
        if player.vy == 0 then
            player.vy = -400
        end
    end
end

-- Function for draw the game --
function love.draw()
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle("fill", test, ground, 1220,200)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", test_bar, 310, 100,10)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", player.x, player.y, player.size, player.size)
end