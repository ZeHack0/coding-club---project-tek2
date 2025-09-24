-- screen_alignement: (where on screen should the target be drawn)
SA_CENTER = {x = SCREEN_WIDTH / 2, y = SCREEN_HEIGHT / 2}


Cam = {
    pos = {x = 100, y = 50},
    offset = {x = 0, y = 0},
    smooth_track = 0,
    target_coord = {x = 0, y = 0},
    target_b_e = nil,
    track_speed = 50,
    screen_alignement = {x = 0, y = 0}
}
-- smooth_track values:
-- 0 = not active -> align world to player
-- 1 = track entity -> tracks either a block or an ennemy / player
-- 2 = track coord -> move camera at track speed until reaching coordinates

-- track_speed is the max tracking speed, if the camera isn't on top of the target,
-- it will move towards the target at this speed, if it is on top of the target,
-- it will move at the target's speed

function Cam:new(posx, posy, offsetx, offsety)
    a_camera = {
        pos = {x = posx, y = posy},
        offset = {x = offsetx, y = offsety},
        smooth_track = 0,
        target_coord = {x = 0, y = 0},
        target_b_e = nil,
        track_speed = 50,
        screen_alignement = SA_CENTER
    }
    setmetatable(a_camera, self)
    self.__index = self
    return a_camera
end

-- should be able to align to any entity
function Cam:center_on_entity(ent)
    self.pos.x = ent.x + (ent.width / 2)
    self.pos.y = ent.y - (ent.height / 2)
end

-- not really useful, just makes the code ever so slightly clearer
function Cam:align_to_player(player)
    self.pos.x = player.x
    self.pos.y = player.y
end

function Cam:align_world_to_player(player)
    self.offset.x = self.screen_alignement.x - player.x - (player.width / 2)
    self.offset.y = self.screen_alignement.y + player.y - (player.height / 2)
end


-- camera will align to target block or entity
-- use camera's pos, once camera pos = target pos, use center_on_entity()
function Cam:smooth_track_target(b_e)
end

-- camera will align to target coord
function Cam:smooth_track_coord()
end

-- select aligning world to player or tracking depending on "smooth_tracking"
function Cam:manage_cam()
end

function Cam:print_info()
    print("camera x: "..self.pos.x.." y: "..self.pos.y)
    print("offset x: "..self.offset.x.." y: "..self.pos.y)
end

-- offset of camera should be where i want to draw it on screen + its world coord
-- inverse the world coord to move them accordingly on screen
