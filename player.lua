-- possible player states:
FALLING = -1
IDLE = 0
JUMPING = 1
-- 2

DEFAULT_JUMP_SPEED = 20

BIG_G = 5 -- gravity value

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
    p = {
        name = name,
        x = x,
        y = y,
        lx = x, -- last x | used to handle camera movements once player is done moving
        ly = y, -- last y | used to handle camera movements once player is done moving
        width = width,
        height = height,
        speed = speed,
        state = state,
        jump_time = 0,
        jump_speed = 10,
        color = {R = 0, G = 200, B = 200, a = 255}
    }
    setmetatable(p, self)
    self.__index = self
    return p
end


---------------------------- Character interactions ------------------

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


--every 0.1sec, reduce player jumpspeed by 1 until it reaches 0
-- once jumpspeed < BIG_G, player is falling
-- once jumpspeed = 0, set it back to default (10) and stop using it until next jump
-- or maybe leave it to 0 and when jump is calling throw at 10
-- so you don't need to handle 
function Player:jump()
    if self.state == JUMPING or self.state == FALLING then
        return -- if player is already jumping or falling, do nothing
    end
    self.jump_time = love.timer.getTime()
    self.state = JUMPING
    self.jump_speed = DEFAULT_JUMP_SPEED
end


---------------------------- User interactions -----------------------

function Player:handle_inputs(camera)
    if love.keyboard.isDown("right") then
        local bl_collided = self.check_collision(self, self.x + self.speed, self.y)
        if bl_collided.width > 0 then
            self.x = bl_collided.x - self.width
        else
            self.x = self.x + self.speed
        end
    end
    if love.keyboard.isDown("left") then
        local bl_collided = self.check_collision(self, self.x - self.speed, self.y)
        if bl_collided.width > 0 then
            self.x = bl_collided.x + bl_collided.width
        else
            self.x = self.x - self.speed
        end
    end
end

-- keys that should react only when pressed and not continuously pressed
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == "space" then
        player.jump(player)
    end
end

-------------- move to player interactions
function Player:apply_gravity()
    self.y = self.y - BIG_G
    local bl_collided = self.check_collision(self, self.x, self.y)
    if bl_collided.width > 0 then --player collided with smth
        print("UN SOL!!!! NO WAY")
        self.y = bl_collided.y + self.height --set player on top of it
        if self.state == FALLING then
            self.state = IDLE
        end
    elseif not (self.state == JUMPING) then
        self.state = FALLING
    end
end


-------------- move to player interactions
--moves the player from its current position to next verified position
--and adapt the camera's offset
function Player:apply_movements(camera)
    --handle jump here
    if self.jump_speed > 0 then
        if love.timer.getTime() - self.jump_time >= 0.15 then
            self.jump_speed = -1
            self.jump_time = love.timer.getTime()
        end
    end
    if self.state == JUMPING then
        if self.jump_speed < BIG_G then
            self.state = FALLING
        else
            local bl_collided = self.check_collision(self, self.x, self.y + self.jump_speed)
            if bl_collided.width > 0 then --player collided to a block above him
                self.y = bl_collided.y - bl_collided.height
                self.state = FALLING
            else
                self.y = self.y + self.jump_speed
            end
        end
    end
    --manage camera
    camera.offset.x = camera.offset.x - (self.x - self.lx)
    self.lx = self.x
    camera.offset.y = camera.offset.y + (self.y - self.ly)
    self.ly = self.y
end


---------------------------- Player Draw -----------------------------

function Player:draw()
    love.graphics.setColor(self.color.R, self.color.G, self.color.B, self.color.a)
    love.graphics.rectangle("fill", (SCREEN_WIDTH / 2) - (self.width / 2),
    (SCREEN_HEIGHT / 2) - (self.height / 2), self.width, self.height)
    love.graphics.setColor(0, 0, 0, 0)
end


---------------------------- Player Debug ----------------------------

function Player:print_info()
    print("Entity: "..self.name)
    print("position| x: "..self.x.." y: "..self.y)
    print("hitbox  | "..self.width.."x"..self.height)
end
