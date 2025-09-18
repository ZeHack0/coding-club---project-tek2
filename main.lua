-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

require "block"
require "player"
require "camera"

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

update_calls = 0 -- keeps track of how many times love.update got called

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setBackgroundColor(0, 0.5, 1)
    if love.graphics.isCreated() then
        print("window exists")
        --love.graphics.setCaption("Sauvez le stream de Pierrick!") it's brokie
    else
        print("window is ded")
    end
    player = Player:new("Pier", 100, 50, 50, 50, 5, 0, 0)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == "space" then
        player.jump(player)
    end
end

function love.update(dt)
    --apply_g_to_entity(PLAYER)
    --align_cam_to_player()
    --hanlde_user_inputs()
    --print()
    --show_ent_info(PLAYER, 1, 1)
    --print()
    --show_cam_info()
    update_calls = update_calls + 1
    hanlde_user_inputs()
    print("\27[4;31mUpdate call: "..update_calls..", current fps:"..love.timer.getFPS().."\27[0;0m")
    print("\n\n")
end

function love.draw()
    draw_block(ABS_GROUND)
    draw_player()
end