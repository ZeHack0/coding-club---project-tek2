-- col_dir key gives you the direction for wich an object has an
-- interactible hitbox, e.g.:
-- col_dir = -1 means a player falling from top to bottom should collide with it
-- but a player jump from bottom to top should not be able to collide with it
-- col_dir = 1 is the opposite
-- col_dir = 2 means no collisions
-- col_dir = 4 means collisions whatever the angle
-- can probably use bitwise operator to check for collision directions

block_1 = {
    pos = {x = 100, y = 100},
    hitbox = {width = 100, height = 20},
    col_dir = -1
}

--absolute ground (should move with the player to prevent infinite falls or smth)
ABS_GROUND = {
    pos = {x = 100, y = 300},
    hitbox = {width = 1000, height = 500},
    color = {R = 0, G = 200, B = 0, a = 255},
    col_dir = -1
}

function draw_block(bl)
    -- bl will not bee altered nor drawn, illusion is what you will see of bl
    local illusion = {
        pos = {
            x = CAM.x - bl.pos.x,
            y = CAM.y - bl.pos.y
        },
        hitbox = {
            width = bl.hitbox.width,
            height = bl.hitbox.height
        },
        col_dir = bl.col_dir -- unused, exists to prevent love2d from dying
    }

    -- debug
    print("\27[34morigin block: \27[0;0m")
    show_block_info(bl, 0)
    print("\27[36millusion: \27[0;0m")
    show_block_info(illusion, 0)

    love.graphics.setColor(bl.color.R, bl.color.G, bl.color.B, bl.color.a)
    love.graphics.rectangle("fill", illusion.pos.x, illusion.pos.y, illusion.hitbox.width, illusion.hitbox.height)
    love.graphics.setColor(0, 0, 0, 0)
end

function show_block_info(bl, show_col_dir)
    print("position x: "..bl.pos.x.." y: "..bl.pos.y)
    print("hitbox size: "..bl.hitbox.width.."x"..bl.hitbox.height)
    if show_col_dir then
        print("collision direction: "..bl.col_dir)
    end
end
