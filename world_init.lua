function main_init()
    background = love.graphics.newImage("sprites/10.png")
    background:setWrap("repeat", "repeat")    
    quad = love.graphics.newQuad(0, 0, background:getWidth(), background:getHeight(), background:getWidth(), background:getHeight())

    player = Player:new("Pier", 0, 75, 50, 75, 7, 0)
    camera = Cam:new(player.x, player.y)
end

function world_init()
    -- ground
    g0 = Block:new(-1000, 0, 1000, 500, -1) --ground 0
    g1 = Block:new(0, 0, 1000, 500, -1)     --ground 1
    g2 = Block:new(1000, 0, 1000, 500, -1)  --ground 2
    g3 = Block:new(2000, 0, 1000, 500, -1)  --ground 3
    -- platform
    ps1 = Block:new(95, 69, 60, 69, 4)    --stair1
    ps2 = Block:new(300, 143, 55, 143, 4) --stair2
    ps3 = Block:new(630, 260, 45, 260, 4) --stair3

    pa1 = Block:new(1263, 150, 50, 150, 4) --arena1
    pa2 = Block:new(1333, 255, 320, 20, 4) --arena roof
    pa3 = Block:new(1683, 150, 50, 150, 4) --arena2

    pe1 = Block:new(1833, 200, 207, 20, 4) --end 1
    pe2 = Block:new(2250, 400, 200, 20, 4) --end 2
    pe3 = Block:new(2500, 600, 200, 20, 4) --end 3
    -- enemies
    e1 = Enemy:new("méchant pas gentil :3", 1469, 75, 50, 75, 5, 100, "sprites/pierrick_walk.png", ATTACKING)
end