-- col_dir key gives you the direction for wich an object has an
-- interactible hitbox, e.g.:
-- col_dir = -1 means a player falling from top to bottom should collide with it
-- but a player jump from bottom to top should not be able to collide with it
-- col_dir = 1 is the opposite
-- col_dir = 2 means no collisions
-- col_dir = 4 means collisions whatever the angle
-- can probably use bitwise operator to check for collision directions

-- could add a type to blocks to make moving platforms

Block_list = {} -- list containing all blocks created
NB_BLOCKS = 0 -- number of blocks in the list and index

Block = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    col_dir = 4,
    color = {r = 0, g = 1, b = 0, a = 1}
}

NETHER_BLOCK = { -- used to send a "null" block when no collision detected when movin
    x = -1,
    y = -1,
    width = -1,
    height = -1,
    col_dir = 69,
    color = {r = 0, g = 1, b = 0, a = 1}
}

-- default color is green, look a set_color to change it
function Block:new(x, y, width, height, col_dir)
    b = {
        x = x,
        y = y,
        width = width,
        height = height,
        col_dir = col_dir,
        color = {r = 0, g = 1, b = 0, a = 1}
    }
    setmetatable(b, self)
    self.__index = self
    Block_list[NB_BLOCKS] = b
    NB_BLOCKS = NB_BLOCKS + 1
    return b
end


---------------------------- Block Draw ------------------------------

-- self will not bee altered nor drawn, illusion is what you will see of it
-- AND WHY IS BLOCK1 IN THE DAMN GROUND ON SCREEN BUT NOT IN COORD????
function Block:draw(camera)
    local illusion = {
        x = self.x + camera.offset.x,
        y = camera.offset.y - self.y,
        width = self.width,
        height = self.height
    }

    -- debug
    -- print("\27[34morigin block: \27[0;0m")
    -- print("x: "..self.x.." y: "..self.y)
    -- print(self.width.."x"..self.height)
    -- print("\27[36millusion: \27[0;0m")
    -- print("x: "..illusion.x.." y: "..illusion.y)
    -- print(illusion.width.."x"..illusion.height)
    -- print()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    love.graphics.rectangle("fill", illusion.x, illusion.y,
    illusion.width, illusion.height)
    love.graphics.setColor(0, 0, 0, 0)
end


---------------------------- Block Set something ---------------------
function Block:set_coord(x, y)
    self.x = x
    self.y = y
end

function Block:set_dimensions(width, height)
    self.width = width
    self.height = height
end

function Block:set_color(r, g, b, a)
    self.color.r = r
    self.color.g = g
    self.color.b = b
    self.color.a = a
end


---------------------------- Block_list Funcs ------------------------

function block_list_info()
    print("Block List has "..NB_BLOCKS.." blocks in it:")
    for i = 0, NB_BLOCKS - 1 do
        print("    Block "..i..":")
        print("          coord x: "..Block_list[i].x.." y: "..Block_list[i].y)
        print("          size "..Block_list[i].width.."x"..Block_list[i].height)
    end
end

function draw_block_list(camera)
    for i = 0, NB_BLOCKS - 1 do
        Block_list[i]:draw(camera)
    end
end
