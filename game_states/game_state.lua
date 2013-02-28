
require('spaceship')
require('game')

GameState = class("GameState", State)
function GameState:initialize()
end

function GameState:draw()
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

  love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20)
end

function GameState:update(dt)
  if game.stopped then
    if love.keyboard.isDown('r') then
      game = Game()
    end
    return
  else
    game:update(dt)
  end
end
