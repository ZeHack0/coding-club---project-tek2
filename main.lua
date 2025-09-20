-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

require "block"
require "player"
require "camera"

update_calls = 0 -- keeps track of how many times love.update got called
-- ^used for debug, remove when done

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
    player = Player:new("Pier", 0, 0, 50, 50, 5, 0)
    camera = Cam:new(player.x, player.y - (player.height / 2),
        (SCREEN_WIDTH / 2) - (player.width / 2), (SCREEN_HEIGHT / 2) - (player.height / 2)
    )
    ground = Block:new(0, 0, 1000, 500, -1)
    b1 = Block:new(500, 100, 20, 150, 4)
    b1.set_color(b1, 1, 0, 0, 1)
    b2 = Block:new(1050, 50, 700, 500, 4)
end


function love.update(dt)
    player.handle_inputs(player, camera)
    player.apply_gravity(player)
    Player.apply_movements(player, camera)
    camera.align_to_entity(camera, player)
    player.print_info(player)
    print()
    camera.print_info(camera)
    print()
    block_list_info()
    print()
    update_calls = update_calls + 1
    --print("\27[4;31mUpdate call: "..update_calls..", current fps:"..love.timer.getFPS().."\27[0;0m")
    print("\n\n")
end


function love.draw()
    draw_block_list(camera)
    player.draw(player)
end