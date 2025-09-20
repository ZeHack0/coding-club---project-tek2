
-- player states:
-- -1 = falling
-- 0 = idle
-- 1 = jumping
-- 2

BIG_G = 5 -- gravity value

--every 0.1sec, reduce player jumpspeed by 1 until it reaches 0
-- once jumpspeed < BIG_G, player is falling
-- once jumpspeed = 0, set it back to default (10) and stop using it until next jump
-- or maybe leave it to 0 and when jump is calling throw at 10
-- so you don't need to handle 

-- have a new var for the next position wich is one that's going to change through
-- gravity, movements etc, so when all movement are done we check if new position is fuf
Player = {
    name = "player",
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    speed = 5,
    state = 0,
    jump_time = 0,
    jump_speed = 10
}


-- marked as need change means make it simpler for the kiddos at the coding club
-- good luck
function Player:new(name, x, y, width, height, speed, state)
    t = {
        name = name,
        x = x,
        y = y,
        nx = x, -- next x | used to add up all movement before doing them | need change
        xy = y, -- next y | used to add up all movement before doing them | need change
        width = width,
        height = height,
        speed = speed,
        state = state,
        jump_time = 0,
        jump_speed = 10,
        color = {R = 0, G = 200, B = 200, a = 255}
    }
    setmetatable(t, self)
    self.__index = self
    return t
end

-- checks position xy with player's width and height to see if it would collide
-- with any block in Block_list
-- return first block encountered that collides with it (this can cause issues)
-- does not check for the direction of the collision for now
function Player:check_collision(x, y)
    print()
    print("checking collision for x: "..x.." y: "..y)
    for i = 0, NB_BLOCKS - 1 do
        print("block: "..i)
        local bl = Block_list[i]
        if (x < bl.x + bl.width and
            x + self.width > bl.x and
            y > bl.y - bl.height and
            y - self.height < bl.y
            ) then
                print("Coordinates x: "..x.." y: "..y.." will collide with block id: "..i.."\n")
            return bl
        end
    end
    print("no collision found")
    print()
    return NETHER_BLOCK
end

function Player:jump()
    if self.state == 1 or self.state == -1 then
        return
    end
    self.jump_time = love.timer.getTime()
    self.state = 1
end

-- would like to handle camera's offset when aligning camera to player
-- but math is hard, help
function Player:handle_inputs(camera)
    if love.keyboard.isDown("right") then
        local bl_collided = self.check_collision(self, self.x + self.speed, self.y)
        if bl_collided.width > 0 then
            self.nx = bl_collided.x - self.width
        else
            self.nx = self.x + self.speed
        end
    end
    if love.keyboard.isDown("left") then
        local bl_collided = self.check_collision(self, self.x - self.speed, self.y)
        if bl_collided.width > 0 then
            self.nx = bl_collided.x + bl_collided.width
        else
            self.nx = self.x - self.speed
        end
    end
end

function Player:apply_gravity()
    -- print("PLAYER jump time: "..self.jump_time)
    -- if self.state == 1 then --check if player is jumping
    --     self.y = self.y + self.speed
    --     camera.offset.y = camera.offset.y + self.speed
    --     --cancel player's jump after some time in seconds
    --     print("results in: "..love.timer.getTime() - self.jump_time)
    --     if love.timer.getTime() - self.jump_time >= 0.5 then
    --         self.state = -1 -- set state to falling
    --     end
    -- else --apply gravity
    self.ny = self.y - BIG_G
    local colliding_bl = self.check_collision(self, self.x, self.ny)
    if colliding_bl.width > 0 then --player collided with smth
        print("\27[4;31mCOLLIDING EAFEAFAFAEFEF")
        self.ny = colliding_bl.y + self.height --set player on top of it
        if self.state == -1 then --if player was falling
            self.state = 0 --set his state to idle
        end
    end
end

--moves the player from its current position to next verified position
--and adapt the camera's offset
function Player:apply_movements(camera)
    camera.offset.x = camera.offset.x - (self.nx - self.x)
    self.x = self.nx
    camera.offset.y = camera.offset.y + (self.ny - self.y)
    self.y = self.ny
end

function Player:draw()
    love.graphics.setColor(self.color.R, self.color.G, self.color.B, self.color.a)
    love.graphics.rectangle("fill", (SCREEN_WIDTH / 2) - (self.width / 2),
    (SCREEN_HEIGHT / 2) - (self.height / 2), self.width, self.height)
    love.graphics.setColor(0, 0, 0, 0)
end

function Player:print_info()
    print("Entity: "..self.name)
    print("position| x: "..self.x.." y: "..self.y)
    print("hitbox  | "..self.width.."x"..self.height)
end
