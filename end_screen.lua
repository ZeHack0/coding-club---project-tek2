function run_end_game()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Vous Avez récuperé la caméra de Pierrick !", SCREEN_WIDTH / 2 - 300, SCREEN_HEIGHT / 2 - 200)
    love.graphics.print("en "..WON_TIME.." secondes", SCREEN_WIDTH / 2 - 290, SCREEN_HEIGHT / 2 - 150)
end