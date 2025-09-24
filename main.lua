-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

SCREEN_WIDTH = 1280
SCREEN_HEIGHT = 720

TARGET_FPS = 60
DRAW_INTERVAL = 1 / TARGET_FPS
last_loop_time = love.timer.getTime() * 1000
AVG_RUN_TIME = 0

require "camera"
require "block"
require "player"
require "world_init"

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
    main_init()
    world_init()
end

function run_game(dt)
    player:apply_movement_with_collision(camera)
    camera:align_world_to_player(player)
end

function fps_limited_loop()
    local current_time = love.timer.getTime() * 1000 -- *1000 to transform into ms
    local delta_time = current_time - last_loop_time

    -- print("current time: "..current_time.."; last loop time: "..last_loop_time)
    -- print("average runtime: "..AVG_RUN_TIME.."; draw interval: "..DRAW_INTERVAL * 1000)
    if (current_time - last_loop_time >= DRAW_INTERVAL * 1000 - AVG_RUN_TIME) then
        last_loop_time = love.timer.getTime() * 1000 -- restart clock
        run_game(delta_time)
        AVG_RUN_TIME = (AVG_RUN_TIME * 0.7 +
        (love.timer.getTime() * 1000 - last_loop_time) * 1.3) / 2.0
    end
end

function love.update(dt)
    fps_limited_loop(dt)
    -- print("\n\n")
end


function love.draw()
    draw_block_list(camera)
    player:draw()
end