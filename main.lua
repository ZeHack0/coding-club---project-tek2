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
    --player's x need to start at 0, otherwise camera's offset is fuffed
    player = Player:new("Pier", 0, 0, 50, 50, 5, 0, 0)
    camera = Cam:new(
        (SCREEN_WIDTH / 2) - (player.width / 2), (SCREEN_HEIGHT / 2) - (player.height / 2),
        (SCREEN_WIDTH / 2) - (player.width / 2), (SCREEN_HEIGHT / 2) - (player.height / 2)
    )
    ground = Block:new(0, 300, 1000, 500, -1)
    b1 = Block:new(500, 150, 20, 50, 4)
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
    player.handle_inputs(player, camera)
    player.apply_gravity(player, camera)
    camera.align_to_entity(camera, player)
    player.print_info(player)
    print()
    camera.print_info(camera)
    print()
    block_list_info()
    print()
    update_calls = update_calls + 1
    print("\27[4;31mUpdate call: "..update_calls..", current fps:"..love.timer.getFPS().."\27[0;0m")
    print("\n\n")
end

function love.draw()
    draw_block_list(camera)
    player.draw(player)
end