
-- player states:
-- -1 = falling
-- 0 = idle
-- 1 = jumping
-- 2

BIG_G = 5

Player = {
    name = "player",
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    speed = 5,
    state = 0,
    jump_time = 0
}

function Player:new(name, x, y, width, height, speed, state, jump_time)
    t = {
        name = name,
        x = x,
        y = y,
        width = width,
        height = height,
        speed = speed,
        state = state,
        jump_time = jump_time,
    }
    setmetatable(t, self)
    self.__index = self
    return t
end

function Player:jump()
    self.jump_time = love.timer.getTime()
    self.state = 1
end

function apply_g_to_entity(ent)
    print("Player jump time: "..Player.jump_time)
    if Player.state == 1 then --check if player is jumping
        Player.pos.y = Player.pos.y + Player.speed
        --cancel player's jump after 2sec or more
        print("results in: "..love.timer.getTime() - Player.jump_time)
        if love.timer.getTime() - Player.jump_time >= 1 then
            Player.state = -1
        end
    else --apply gravity
        ent.pos.y = ent.pos.y - BIG_G
        if ent.pos.y - ent.hitbox.height < ABS_GROUND.pos.y then
            ent.pos.y = ABS_GROUND.pos.y + ent.hitbox.height
        end
    end
end

function hanlde_user_inputs()
    if love.keyboard.isDown("right") then
        Player.pos.x = Player.pos.x + Player.speed
    end
    if love.keyboard.isDown("left") then
        Player.pos.x = Player.pos.x - Player.speed
    end
end

-- exists because player needs to be centered on the screen
-- draw entity draws it in the world, not on the screen
function draw_player()
    love.graphics.setColor(110, 110, 110, 200)
    love.graphics.rectangle("fill", (SCREEN_WIDTH / 2) - (Player.width / 2),
    (SCREEN_HEIGHT / 2) - (Player.height / 2),
    Player.width, Player.height)
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
