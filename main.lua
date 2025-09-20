-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

TARGET_FPS = 60
DRAW_INTERAL = 1000 / TARGET_FPS
last_loop_time = love.timer.getTime() * 1000
AVG_RUN_TIME = 0

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

function run_game(dt)
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
end

function fps_limited_loop()
    local current_time = love.timer.getTime() * 1000 -- *1000 to transform into ms
    local delta_time = current_time - last_loop_time

    print("current time: "..current_time.."; last loop time: "..last_loop_time)
    print("average runtime: "..AVG_RUN_TIME.."; draw interval: "..DRAW_INTERAL)
    if (current_time - last_loop_time >= DRAW_INTERAL - AVG_RUN_TIME) then
        last_loop_time = love.timer.getTime() * 1000 -- restart clock
        run_game(delta_time)
        AVG_RUN_TIME = (AVG_RUN_TIME * 0.7 +
        (love.timer.getTime() * 1000 - last_loop_time) * 1.3) / 2.0
    end
end

function love.update(dt)
    fps_limited_loop(dt)
    --print("\27[4;31mUpdate call: "..update_calls..", current fps:"..love.timer.getFPS().."\27[0;0m")
    print("\n\n")
end


function love.draw()
    draw_block_list(camera)
    player.draw(player)
end