-- possible player states:
IDLE = 0
JUMPING = 1

DEFAULT_JUMP_SPEED = 1100 -- pixels/second

GRAVITY = -2500 -- pixels/seconde²

-- have a new var for the next position wich is one that's going to change through
-- gravity, movements etc, so when all movement are done we check if new position is fuf
Player = {
    name = "player",
    hp = 60,
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    speed = 5,
    state = 0,
    jump_speed = 10
}


-- marked as need change means make it simpler for the kiddos at the coding club
-- good luck
function Player:new(name, x, y, width, height, speed, state)
    p = {
        name = name,
        hp = 60,
        x = x,
        y = y,
        lx = x,
        ly = y,
        width = width,
        height = height,
        speed = speed,
        state = state,
        jump_speed = 0,
        color = {R = 1, G = 1, B = 1, a = 255},
        image = love.graphics.newImage("sprites/pierrick_v0.png")
    }
    setmetatable(p, self)
    self.__index = self
    return p
end


---------------------------- User interactions -----------------------

function Player:move()
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.x = self.x + self.speed
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("q") then
        self.x = self.x - self.speed
    end
end

-- keys that should react only when pressed and not continuously pressed
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == "space" or key == "z" or key == "up" then
        player.jump(player)
    end
    if key == "r" then
        player.x = 0
        player.y = player.height + 50
        player.jump_speed = 0
    end
end


---------------------------- Character interactions ------------------

function Player:jump()
    if self.state == JUMPING then
        return -- if player is already jumping or falling, do nothing
    end
    self.jump_speed = DEFAULT_JUMP_SPEED
    self.state = JUMPING
    self.jump_time = love.timer.getTime()
end

function Player:update_physics()
    self.y = self.y + self.jump_speed * DELTA_TIME
    self.jump_speed = self.jump_speed + GRAVITY * DELTA_TIME
end

function Player:check_collision(x, y)
    -- print("checking collision for x: "..x.." y: "..y)
    for i = 0, NB_BLOCKS - 2 do
        -- print("block: "..i)
        local bl = Block_list[i]
        if (x < bl.x + bl.width and
            x + self.width > bl.x and
            y > bl.y - bl.height and
            y - self.height < bl.y
            ) then
            -- print("Coordinates x: "..x.." y: "..y.." will collide with block id: "..i.."\n")
            return bl
        end
    end
    -- print("no collision found")
    return NETHER_BLOCK
end

-- moves the player from its current position to next verified position
-- and adapt the camera's offset
function Player:apply_movement_with_collision(camera)
    -- save position before movement
    self.lx = self.x
    self.ly = self.y

    self:move()

    -- horizontal collision
    local bl_x = self:check_collision(self.x, self.y)
    if bl_x.width > 0 then
        self.x = self.lx
    end

    self:update_physics()

    -- vertical collision
    local bl_y = self:check_collision(self.x, self.y)
    if bl_y.width > 0 then
        if self.jump_speed < 0 then
            -- ground
            self.y = bl_y.y + self.height
            self.state = IDLE
        else
            -- ceiling
            self.y = bl_y.y - bl_y.height
        end
        self.jump_speed = 0
    end

    -- apply gravity
    if self.state ~= JUMPING then
        local bl_under = self:check_collision(self.x, self.y - 1)
        if bl_under.width < 0 then
            self.state = JUMPING
            self.jump_speed = 0
        end
    end
end

function Player:is_dead()
    if self.hp <= 0 or self.y < -750 then
        print("you died")
        self.x = 0
        self.y = self.height + 50
        self.hp = 60
    end
end

function Player:collected_camera()
    if WON == 1 then
        return
    end
    if (self.x < Block_list[NB_BLOCKS - 1].x + Block_list[NB_BLOCKS - 1].width and
        self.x + self.width > Block_list[NB_BLOCKS - 1].x and
        self.y > Block_list[NB_BLOCKS - 1].y - Block_list[NB_BLOCKS - 1].height and
        self.y - self.height < Block_list[NB_BLOCKS - 1].y
    ) then
        WON = 1
        WON_TIME = love.timer.getTime()
    end
end


---------------------------- Player Draw -----------------------------

function Player:draw()
    love.graphics.setColor(self.color.R, self.color.G, self.color.B, self.color.a)
    love.graphics.draw(self.image, (SCREEN_WIDTH / 2) - (self.width / 2),
        (SCREEN_HEIGHT / 2) - (self.height / 2), 0, self.width / self.image:getWidth(), self.height / self.image:getHeight())
end

function Player:draw_ui()
    love.graphics.print("PV: "..self.hp, 20, 20)
end

---------------------------- Player Debug ----------------------------

function Player:print_info()
    print("Entity: "..self.name)
    print("position| x: "..self.x.." y: "..self.y)
    print("hitbox  | "..self.width.."x"..self.height)
end
