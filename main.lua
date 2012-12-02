
-- MoonLander. A short game in love2d to get you started in game programming

-- Here we keep any data from the game like height, speed, gravity
game = {
  stopped = false,
  height = 200,
  speed_vertical = 0,
  max_speed_vertical = 2,
  gravity = 0.2,
}

function love.load()
end

-- update is run again and again, the variable dt tells you how much time elapsed since the last time
function love.update(dt)
  if game.stopped then
    return -- when we land and stop the game we can leave this function right away
  end
  -- Minimum interaction is if you hit space to boost your speed, we use dt to make it smooth
  if love.keyboard.isDown(' ') then
    game.speed_vertical = game.speed_vertical - dt
  end

  -- things have a maximum speed, and as log as we haven't reached that we can
  -- use gravity and dt to fall faster.
  if game.speed_vertical < game.max_speed_vertical then
    -- Honestly, I don't know if that's the right formula
    game.speed_vertical = game.speed_vertical + dt * game.gravity
  end
  -- we are falling, thus reduce the height
  game.height = game.height - game.speed_vertical

  if game.height <= 0 then
    game.stopped = true -- stop!
    game.height = 0 -- set to zero because we are tidy
  end
end

function love.draw()
  love.graphics.setFont(love.graphics.newFont(14))
  love.graphics.setColor(255,255,255,255)
  love.graphics.print('Height: ' .. game.height .. 'm', 10, 10)
  love.graphics.print('Speed vertical: ' .. game.speed_vertical .. 'm/s', 10, 30)
  if game.height <= 0 then
    love.graphics.print('You landed. Or crashed', 10, 50)
  else
    -- Tell player what to do
    love.graphics.print('Hit SPACE to boost up', 10, 100)
  end
end
