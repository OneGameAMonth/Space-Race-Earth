
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
  for i, player in ipairs(game.players) do
    player:draw(dt)
  end
  
  -- let's draw the moon surface
  love.graphics.setColor(80,205,105,255)
  love.graphics.rectangle('fill',
    2, -- starting at the left border
    love.graphics.getHeight() - 40, -- 90% from the op
    love.graphics.getWidth()-4, -- full width, with a little border
    40 ) -- 10% high, with a little border at the bottom
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
