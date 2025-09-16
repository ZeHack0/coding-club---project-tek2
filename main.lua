-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

require "block"
require "player"
require "camera"

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(0, 0.5, 1)
    if love.graphics.isCreated() then 
        print("window exists")
        --love.graphics.setCaption("Sauvez le stream de Pierrick!") it's brokie
    else
        print("window is ded")
    end
    algin_cam_to_player()
end

function love.update(dt)
    handle_user_actions()
    apply_g_to_entity(PLAYER)
    algin_cam_to_player()
    show_cam_info()
    print()
end

function love.keypressed(key)
    if key == "space" then
        PLAYER.pos.y = PLAYER.pos.y + 200
    end
end

function love.draw()
    draw_player()
    draw_block(ABS_GROUND)
end