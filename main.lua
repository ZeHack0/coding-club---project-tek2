-- By Ronan Botrel | Antoine Sandret | Romeo Pereira - Epitech 2Years --

_G.love = require("love")

SCREEN_WIDTH = 1600
SCREEN_HEIGHT = 900

TARGET_FPS = 60
DRAW_INTERVAL = 1 / TARGET_FPS
last_loop_time = love.timer.getTime() * 1000
AVG_RUN_TIME = 0
WON_TIME = 0
WON = 0

require "camera"
require "block"
require "weapon"
require "end_screen"
require "player"
require "enemy"
require "world_init"

function love.load()
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT)
    font = love.graphics.newFont("fonts/Nasa21.ttf", 30)
    love.graphics.setFont(font)
    main_init()
    world_init()
end

function run_game(dt)
    run_enemies(player)
    player:is_dead()
    player:apply_movement_with_collision(camera)
    camera:align_world_to_player(player)
    player:collected_camera()
end

function fps_limited_loop()
    local current_time = love.timer.getTime() * 1000 -- *1000 to transform into ms
    local delta_time = current_time - last_loop_time
    
    if (current_time - last_loop_time >= DRAW_INTERVAL * 1000 - AVG_RUN_TIME) then
        last_loop_time = love.timer.getTime() * 1000 -- restart clock
        run_game(delta_time)
        AVG_RUN_TIME = (AVG_RUN_TIME * 0.7 +
        (love.timer.getTime() * 1000 - last_loop_time) * 1.3) / 2.0
    end
end

function love.update(dt)
    fps_limited_loop(dt)
end


function love.draw()
    bgquad:setViewport(camera.offset.x * -0.4, SCREEN_HEIGHT / 8 + camera.offset.y * 0.1, background:getWidth(), background:getHeight())
    love.graphics.draw(background, bgquad, 0, 0, 0)
    draw_block_list(camera)
    draw_enemies(camera)
    player:draw()
    player:draw_ui()
    if WON == 1 then
        run_end_game()
        return
    end
end
