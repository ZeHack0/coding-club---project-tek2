function main_init()
    player = Player:new("Pier", 0, 75, 50, 75, 5, 0)
    camera = Cam:new(player.x, player.y)
end

function world_init()
    -- ground
    g0 = Block:new(-1000, 0, 1000, 500, -1)
    g1 = Block:new(0, 0, 1000, 500, -1)
    g2 = Block:new(1000, 0, 1000, 500, -1)
    g3 = Block:new(2000, 0, 1000, 500, -1)
    -- platform
    p1 = Block:new(95, 69, 60, 69, 4)
    -- fake enemies
    e1 = Block:new(800, 75, 50, 75, 4)
    e1:set_color(1, 0, 0, 1)
end