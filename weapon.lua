-- this is here because weapon needs these 2 items from enemy.lua
-- but enemy.lua needs most of weapon.lua
E_list = {} -- list of all enemies
NB_E = 0    -- number of enemies (and index to place next enemy)

--Weapon states:
READY = 1
ON_COOLDOWN = 0

Weapon = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    dmg = 0,
    cooldown = 5,
    last_use = 0,
    state = READY,
    has_hit = 0,
    fall_speed = 8,
    image = "America's Second Amemdment"
}

function Weapon:new(width, height, dmg, cooldown, png)
    W = {
        width = width,
        height = height,
        dmg = dmg,
        cooldown = cooldown,
        image = love.graphics.newImage(png)
    }
    setmetatable(W, self)
    self.__index = self
    return W
end

function Weapon:check_collision(x, y)
    for i = 0, NB_BLOCKS - 2 do
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

-- call when starting to attack only, once attack is started calling it would
-- move the attack (we don't want that)
function Weapon:adapt_to_enemy(enemy)
    self.y = enemy.y * 2
    if enemy.dir == 1 then
        self.x = enemy.x + enemy.range
    else
        self.x = enemy.x - enemy.range - self.width
    end
end

function Weapon:check_hit(player)
    if self.has_hit == 1 then
        return --can only hit one target once.
    end
    if (self.x < player.x + player.width and
        self.x + self.width > player.x and
        self.y > player.y - player.height and
        self.y - self.height < player.y
    ) then
        self.has_hit = 1
        player.hp = player.hp - self.dmg
        print("hit player")
    end
    for i = 0, NB_E - 1 do
        if self.has_hit == 1 then
            return --can only hit one target once.
        end
        local e = E_list[i]
        if (self.x < e.x + e.width and
            self.x + self.width > e.x and
            self.y > e.y - e.height and
            self.y - self.height < e.y
        ) then
            self.has_hit = 1
            e.hp = e.hp - self.dmg
        end
    end
end

--takes player but will also check if it hits any enemy so it should work
--for both the player and the enemies (should)
function Weapon:run_weapon(player)
    if love.timer.getTime() - self.last_use >= self.cooldown then
        self.state = READY
        self.has_hit = 0
    end
    if self.state == READY then
        return --weapon not in use
    end
    self:check_hit(player)
    --make hammer fall
    local bl = self:check_collision(self.x, self.y - self.fall_speed)
    if bl.width > 0 then
        self.y = bl.y + self.height
    else
        self.y = self.y - self.fall_speed
    end
end

-- draw depending on enemy direction and range (will brake on player)
function Weapon:enemy_draw(enemy, camera)
    if self.state == ON_COOLDOWN then
        local illusion = {
            x = self.x + camera.offset.x,
            y = camera.offset.y - self.y,
            width = (self.width / self.image:getWidth()),
            height = (self.height / self.image:getHeight())
        }
        love.graphics.setColor(1, 1, 1, 1)
        if enemy.dir == 1 then
            love.graphics.draw(self.image, illusion.x + self.width, illusion.y, 3.14/2, illusion.width, illusion.height)
        else
            love.graphics.draw(self.image, illusion.x + self.width, illusion.y, -3.14/2, illusion.width * -1, illusion.height)
        end
    end
end