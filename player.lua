
-- player states:
-- -1 = falling
-- 0 = idle
-- 1 = jumping
-- 2

BIG_G = 5

PLAYER = {
    name = "player",
    pos = {x = 100, y = 50},
    hitbox = {width = 50, height = 50},
    color = {R = 0, G = 200, B = 200, a = 255},
    speed = 5,
    state = 0,
    jump_time = 0
}

function apply_g_to_entity(ent)
    print("PLAYER jump time: "..PLAYER.jump_time)
    if PLAYER.state == 1 then --check if player is jumping
        PLAYER.pos.y = PLAYER.pos.y + PLAYER.speed
        --cancel player's jump after 2sec or more
        print("results in: "..love.timer.getTime() - PLAYER.jump_time)
        if love.timer.getTime() - PLAYER.jump_time >= 1 then
            PLAYER.state = -1
        end
    else --apply gravity
        ent.pos.y = ent.pos.y - BIG_G
        if ent.pos.y - ent.hitbox.height < ABS_GROUND.pos.y then
            ent.pos.y = ABS_GROUND.pos.y + ent.hitbox.height
        end
    end
end

-- handle user actions:
function love.keypressed(key)
    if key == "space" then
        PLAYER.jump_time = love.timer.getTime()
        PLAYER.state = 1
    end
    if key == "right" then
        PLAYER.pos.x = PLAYER.pos.x + PLAYER.speed
    end
    if key == "left" then
        PLAYER.pos.x = PLAYER.pos.x - PLAYER.speed
    end
end

-- exists because player needs to be centered on the screen
-- draw entity draws it in the world, not on the screen
function draw_player()
    love.graphics.setColor(PLAYER.color.R, PLAYER.color.G, PLAYER.color.B, PLAYER.color.a)
    love.graphics.rectangle("fill", (SCREEN_WIDTH / 2) - (PLAYER.hitbox.width / 2),
    (SCREEN_HEIGHT / 2) - (PLAYER.hitbox.height / 2),
    PLAYER.hitbox.width, PLAYER.hitbox.height)
    love.graphics.setColor(0, 0, 0, 0)
end

function draw_entity(ent)
    love.graphics.setColor(ent.color.R, ent.color.G, ent.color.B, ent.color.a)
    love.graphics.rectangle("fill", ent.pos.x, ent.pos.y, ent.hitbox.width, ent.hitbox.height)
    love.graphics.setColor(0, 0, 0, 0)
end

function show_ent_info(ent, show_pos, show_hitbox)
    print ("Entity: "..ent.name)
    if show_pos then
        print("position| x: "..ent.pos.x.." y: "..ent.pos.y)
    end
    if show_hitbox then
        print("hitbox  | "..ent.hitbox.width.."x"..ent.hitbox.height)
    end
end
