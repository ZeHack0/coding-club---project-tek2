
-- player states:
-- 0 = idle
-- 1 = moving
-- 2 = falling

BIG_G = 5

PLAYER = {
    pos = {x = 100, y = 50},
    hitbox = {width = 50, height = 50},
    color = {R = 0, G = 200, B = 200, a = 255},
    speed = 5,
    state = 0
}

function apply_g_to_entity(ent)
    ent.pos.y = ent.pos.y + BIG_G
    if ent.pos.y + ent.hitbox.height > ABS_GROUND.pos.y then
        ent.pos.y = ABS_GROUND.pos.y - ent.hitbox.height
    end
end

function handle_user_actions()
    if love.keyboard.isDown("right") then
        PLAYER.pos.x = PLAYER.pos.x + PLAYER.speed
    end
    if love.keyboard.isDown("left") then
        PLAYER.pos.x = PLAYER.pos.x - PLAYER.speed
    end
end

function draw_entity(ent)
    love.graphics.setColor(ent.color.R, ent.color.G, ent.color.B, ent.color.a)
    love.graphics.rectangle("fill", ent.pos.x, ent.pos.y, ent.hitbox.width, ent.hitbox.height)
    love.graphics.setColor(0, 0, 0, 0)
end