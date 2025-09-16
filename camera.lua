CAM = {
    x = 100,
    y = 50
}


function align_cam_to_player()
    CAM.x = PLAYER.pos.x + (PLAYER.hitbox.width / 2)
    CAM.y = PLAYER.pos.y + (PLAYER.hitbox.height / 2)
end

function show_cam_info()
    print("Camera  x: "..CAM.x.."  y: "..CAM.y)
end
-- func to move cam with player can check for a certain offset to not react to
