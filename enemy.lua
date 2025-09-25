-- possible enemy state:
PATROLLING = 0 -- walks up to a wall, flip, walk up to a wall, flip...
ATTACKING = 1  -- follows player up to his attack range and attack

EDJS = 900 -- pixels/s (Enemy default jump speed)

E_list = {} -- list of all enemies
NB_E = 0    -- number of enemies (and index to place next enemy)

Enemy = {
    name = "Enemy, the origins, vol.1",
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    speed = 0,
    dir = 1, -- direction he is moving to (1 to right, -1 to left)
    state = 0,
    jump_time = EDJS,
    jump_speed = DEFAULT_JUMP_SPEED,
    range = 0,
    image = "not an image, but sauron is kinda sexy",
    weapon = {x = 0, y = 0, width = 20, height = 50}
}

function Enemy:new(name, x, y, width, height, speed, range, png, state)
    e = {
        name = name,
        x = x,
        y = y,
        width = width,
        height = height,
        speed = speed,
        dir = 1,
        state = state,
        jump_time = 0,
        jump_speed = EDJS,
        range = range,
        image = love.graphics.newImage(png)
    }
    setmetatable(e, self)
    self.__index = self
    E_list[NB_E] = e
    NB_E = NB_E + 1
    return e
end


---------------------------- Enemy handling -------------------------

function Enemy:check_collision(x, y)
    for i = 0, NB_BLOCKS - 1 do
        local bl = Block_list[i]
        if (x < bl.x + bl.width and
            x + self.width > bl.x and
            y > bl.y - bl.height and
            y - self.height < bl.y
            ) then
            return bl
        end
    end
    return NETHER_BLOCK
end

-- does not handles direction because enemy should always be facing the player
-- if it is attacking.
function Enemy:is_player_in_attack_range(player)
    if self.dir == 1 then
        if player.x >= self.x + self.range then
            if player.x <= self.x + self.range + self.weapon.width then
                return 1 -- player is in range
            else
                return 2 -- player is too far
            end
        else
            return 0 -- player is too close
        end
    else
        if player.x <= self.x - self.range then
            if player.x + player.width >= self.x - self.range - self.weapon.width then
                return 1 -- player is in range
            else
                return 2 -- player is too far
            end
        else
            return 0 -- player is too close
        end
    end
end

function Enemy:move(player)
    if self.state == ATTACKING then
        if self.x - player.x >= 0 then
            self.dir = -1
        else
            self.dir = 1
        end
    end
    local last_x = self.x
    if self.state == PATROLLING then
        self.x = self.x + self.speed * self.dir
    elseif self.state == ATTACKING then
        local m = self:is_player_in_attack_range(player)
        if m == 2 then
            self.x = self.x + self.speed * self.dir
        elseif m == 0 then
            self.x = self.x - self.speed * self.dir
        end
    end
    local bl_collision = self:check_collision(self.x, self.y)
    if bl_collision.width > 0 then
        self.x = last_x
        if self.state == PATROLLING then
            self.dir = self.dir * -1
        end
    end
end

function Enemy:attack(player)
    if not (self.state == ATTACKING) then
        return
    end
end

--for now just moves them but later should handle all their behavior
--and behavior change
function run_enemies(player)
    for i = 0, NB_E - 1 do
        E_list[i]:move(player)
    end
end


---------------------------- Enemy Draw -----------------------------

function Enemy:world_draw(camera)
    local illusion = {
        x = self.x + camera.offset.x,
        y = camera.offset.y - self.y,
        width = (self.width / self.image:getWidth()),
        height = (self.height / self.image:getHeight())
    }

    love.graphics.setColor(1, 1, 1, 1)
    if self.dir == 1 then
        love.graphics.draw(self.image, illusion.x, illusion.y, 0, illusion.width, illusion.height)
    else
        love.graphics.draw(self.image, illusion.x + self.width, illusion.y, 0, illusion.width * -1, illusion.height)
    end
        -- love.graphics.draw(self.image, (SCREEN_WIDTH / 2) - (self.width / 2),
    --     (SCREEN_HEIGHT / 2) - (self.height / 2), 0, self.width / self.image:getWidth(), self.height / self.image:getHeight())
end

function draw_enemies(camera)
    for i = 0, NB_E - 1 do
        E_list[i]:world_draw(camera)
    end
end
