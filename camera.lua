Cam = {
    pos = {x = 100, y = 50},
    offset = {x = 0, y = 0}
}

function Cam:new(posx, posy, offsetx, offsety)
    a_camera = {
        pos = {x = posx, y = posy},
        offset = {x = offsetx, y = offsety}
    }
    setmetatable(a_camera, self)
    self.__index = self
    return a_camera
end

-- always send to player for now as it only works with player
-- math is hard lmao
function Cam:align_to_entity(ent)
    self.pos.x = ent.x + (ent.width / 2)
    self.pos.y = ent.y + (ent.height / 2)
end

function Cam:print_info()
    print("camera x: "..self.pos.x.." y: "..self.pos.y)
    print("offset x: "..self.offset.x.." y: "..self.pos.y)
end

-- func to move cam with player can check for a certain offset to not react to
