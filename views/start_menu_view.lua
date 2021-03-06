
require 'views/view'
gui = require 'lib/quickie'

StartMenuView = class("MenuView", View)

gui.core.style.color.normal.bg = {80,180,80}
StartMenuView.background_image = love.graphics.newImage('images/earth800.png')

function StartMenuView:drawContent()
  love.graphics.setFont(game.fonts.regular)

  love.graphics.setColor(180 ,205 , 105 , 255)
  love.graphics.draw(self.background_image)

  gui.core.draw()
  x = 130
  y = 80

  love.graphics.scale(1.8,1.8)
  love.graphics.setColor(255,255,255,200)
  love.graphics.print('Space Race: Earth', x, y)
  love.graphics.setColor(255,200, 10, 255)
  love.graphics.print('Space Race: Earth', x-1, y-1)
end

function StartMenuView:update(dt)
  local x = 100
  local y = 250

  gui.group.push({grow = "down", pos = {x, y}})
  -- start the game
  if gui.Button({text = '[N]ew game'}) then
    game:start()
  end
  gui.group.push({grow = "down", pos = {0, 20}})

  -- fullscreen toggle
  if self.fullscreen then
    text = 'Windowed'
  else
    text = 'Fullscreen'
  end
  if gui.Button({text = text}) then
    self.fullscreen = not self.fullscreen
    love.graphics.setMode(love.graphics.getWidth(), love.graphics.getHeight(), self.fullscreen)
  end

end
