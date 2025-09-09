-- col_dir key gives you the direction for wich an object has an
--interactible hitbox, e.g.:
-- col_dir = -1 means a player faling from top to bottom should collide with it
-- but a player jump from bottom to top should not be able to collide with it
-- col_dir = 1 is the opposite
-- col_dir = 0 means no collisions
-- col_dir = 2 means collisions whatever the angle

block_1 = {
    pos = {x = 100, y = 100},
    col_dir = -1,
    hitbox = {width = 100, height = 20}
}

function print_block_info(bl)
    print("position x: "..bl.pos.x.." y: "..bl.pos.y)
    print("hitbox size: "..bl.hitbox.width.."x"..bl.hitbox.height)
    print("collision direction: "..bl.col_dir)
end

