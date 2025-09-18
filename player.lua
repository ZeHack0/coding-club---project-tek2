
-- player states:
-- -1 = falling
-- 0 = idle
-- 1 = jumping
-- 2

BIG_G = 5 -- gravity value 

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
        color = {R = 0, G = 200, B = 200, a = 255}
    }
    setmetatable(t, self)
    self.__index = self
    return t
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
        self.x = self.x + self.speed
        camera.offset.x = camera.offset.x - self.speed -- move this
    end
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed
        camera.offset.x = camera.offset.x + self.speed -- move this
    end
end

function Player:apply_gravity(camera)
    print("PLAYER jump time: "..self.jump_time)
    if self.state == 1 then --check if player is jumping
        self.y = self.y + self.speed
        camera.offset.y = camera.offset.y + self.speed
        --cancel player's jump after some time in seconds
        print("results in: "..love.timer.getTime() - self.jump_time)
        if love.timer.getTime() - self.jump_time >= 0.5 then
            self.state = -1 -- set state to falling
        end
    else --apply gravity
        self.y = self.y - BIG_G
        camera.offset.y = camera.offset.y - BIG_G
        if self.y - self.height < 300 then
            self.y = 300 + self.height
            camera.offset.y = 85
            self.state = 0 -- set state to idle
        end
    end
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
