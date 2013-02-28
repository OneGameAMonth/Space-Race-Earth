
-- MoonLander. A short game in love2d to get you started in game programming

-- To draw the spaceship try http://pixieengine.com

require('lib/middleclass')
require('spaceship')
require('game')

function love.load()
  game = Game()
end

-- update is run again and again, the variable dt tells you how much time elapsed since the last time
function love.update(dt)
  if game.stopped then
    if love.keyboard.isDown('r') then
      game = Game()
    end
    return
  else
    game:update(dt)
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
      love.graphics.print('You landed sucessfully in ' .. shortdec(game.time_elapsed) .. ' seconds', 10, 50)
    end
    love.graphics.setColor(255,255,255,255) -- reset color to white
    love.graphics.print('Press [r] to restart', 10, 100)
  else
  love.graphics.setColor(255,255,255,255) -- reset color to white
    -- Tell player what to do
    love.graphics.print('Hit SPACE to boost up', 10, 100)
  end
  love.graphics.setColor(200,200,200,255)

  view_height = love.graphics.getHeight() * 0.9

  for i, player in ipairs(game.players) do
    player:draw(dt)
  end
  
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
