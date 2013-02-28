
require('spaceship')
require('game')

GameState = class("GameState", State)
function GameState:initialize()
  self.background_image = love.graphics.newImage('images/earth800.png')
  self.twit = 0
end

function GameState:draw()
  self.twit = math.max(-20, math.min(20, self.twit + (1 - math.random() * 2)))
  love.graphics.setColor(180 - self.twit ,205 + 2 * self.twit, 105 + self.twit, 255)
  love.graphics.draw(self.background_image)

  for i, player in ipairs(game.players) do
    player:draw(dt)
  end
 
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
