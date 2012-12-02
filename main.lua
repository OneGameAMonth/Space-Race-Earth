
-- MoonLander. A short game in love2d to get you started in game programming

-- To draw the spaceship try http://pixieengine.com


-- Here we keep any data from the game like height, speed, gravity
game = {
  stopped = false,
  startHeight = 200, -- same as hight but won't be changed by the game
  height = 200,
  boosting = false,
  speed_vertical = 0,
  max_speed_vertical = 2,
  gravity = 0.2,
  save_landing_speed = 0.2, -- for our win/lose condition we define a maximum speed that is save for landing
  spaceship = nil,
  spaceship_with_booster = nil
}

function love.load()
  game.spaceship = love.graphics.newImage('spaceship.png')
  -- http://pixieengine.com/sprites/34690-spaceship-with-booster
  game.spaceship_with_booster = love.graphics.newImage('spaceship_with_booster.png')

end

-- update is run again and again, the variable dt tells you how much time elapsed since the last time
function love.update(dt)
  game.boosting = false -- always set false but if the key is set it will be set to true
  if game.stopped then
    return -- when we land and stop the game we can leave this function right away
  end

  -- Minimum interaction is if you hit space to boost your speed, we use dt to make it smooth
  if love.keyboard.isDown(' ') then
    game.speed_vertical = game.speed_vertical - dt
    game.boosting = true
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
    -- compare the last speed with the speed we consider save for landing
    if game.speed_vertical > game.save_landing_speed then
      game.crashed = true
    end
    game.height = 0
    game.stopped = true
  end
end

function love.draw()
  love.graphics.setFont(love.graphics.newFont(14))
  love.graphics.setColor(255,255,255,255)

  -- make it red if we are getting too close too fast
  if game.height * game.speed_vertical > 2 * game.height * game.save_landing_speed then
    love.graphics.setColor(255,0,0,255)
  end
  love.graphics.print('Height: ' .. shortdec(game.height) .. 'm', 10, 10)

  -- make it red any time we are too fast
  if game.speed_vertical > game.save_landing_speed then
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(255,255,255,255)
  end
  love.graphics.print('Speed vertical: ' .. shortdec(game.speed_vertical,2) .. 'm/s', 10, 30)
  if game.height <= 0 then
    if game.crashed then
      love.graphics.setColor(255,50,50,255) -- red for losers
      love.graphics.print('Oh noes, you crashed!', 10, 50)
    else
      love.graphics.setColor(50,255,50,255) -- green
      love.graphics.print('You landed sucessfully', 10, 50)
    end
  else
  love.graphics.setColor(255,255,255,255) -- reset color to white
    -- Tell player what to do
    love.graphics.print('Hit SPACE to boost up', 10, 100)
  end
  love.graphics.setColor(200,200,200,255)

  view_height = love.graphics.getHeight() * 0.9

  -- let's draw the space ship
  local spaceship = game.spaceship
  if game.boosting then
    spaceship = game.spaceship_with_booster
  end
  love.graphics.draw(spaceship,
    love.graphics.getWidth() / 2 - 16, -- center it in the middle, subtract half the image's width
    view_height - 32 - (view_height * game.height / game.startHeight)) -- 32 is image height
  -- let's draw the moon surface

  love.graphics.rectangle('fill',
    2, -- starting at the left border
    love.graphics.getHeight() * 0.9, -- 90% from the op
    love.graphics.getWidth()-4, -- full width, with a little border
    love.graphics.getHeight() * 0.1 - 2 ) -- 10% high, with a little border at the bottom
end

-- so far we had miliseconds printed out, this function will help us to print nicer numbers
function shortdec(v, i)
  if not i then
    i = 1
  end
  i = 10 ^ i
  -- multiply with 10, round and divide by 10
  return math.floor(v * i) / i
end
