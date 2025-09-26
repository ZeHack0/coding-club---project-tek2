function main_init()
    background = love.graphics.newImage("sprites/10.png")
    background:setWrap("repeat", "repeat")
    bgquad = love.graphics.newQuad(0, 0, background:getWidth(), background:getHeight(), background:getWidth(), background:getHeight())

    player = Player:new("Pier", 0, 75 + 50, 50, 75, 7, 0)
    camera = Cam:new(player.x, player.y)
end

function world_init()
    -- ground
    g0 = Block:new(-500, 0, 1800, 1400, -1, "sprites/sci-fi_high_rise.png") --ground 0
    g2 = Block:new(1498, 100, 1300, 1400, -1, "sprites/sci-fi_high_rise.png")  --ground 1
    -- platform
    ps1 = Block:new(350, 69, 60, 69, 4, nil)     --stair1
    ps2 = Block:new(600, 140, 60, 140, 4, nil)   --stair2
    ps3 = Block:new(975, 250, 60, 250, 4, nil)   --stair3
    ps3 = Block:new(1100, 35, 60, 35, 4, nil)    --stair4

    pa1 = Block:new(1700, 250, 50, 150, 4, nil)  --arena1
    pa2 = Block:new(1850, 375, 300, 20, 4, nil)  --arena roof
    pa3 = Block:new(2250, 250, 50, 150, 4, nil)  --arena2

    pe1 = Block:new(2700, 250, 207, 20, 4, nil)  --end 1
    pe2 = Block:new(2975, 375, 200, 20, 4, nil)  --end 2
    pe3 = Block:new(3250, 500, 200, 20, 4, nil)  --end 3
    -- enemies
    e1 = Enemy:new("méchant pas gentil :3", 80, 1900, 175, 50, 75, 5, 100, "sprites/pierrick_walk.png", ATTACKING)
end