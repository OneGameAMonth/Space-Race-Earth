
Game = class('Game')

-- Here we keep any data from the game like height, speed, gravity
Game.defaults = {
  stopped = false,
  startHeight = 200, -- same as hight but won't be changed by the game
  height = 200,
  boosting = false,
  speed_vertical = 0,
  gravity = 0.2,
  save_landing_speed = 0.2, -- for our win/lose condition we define a maximum speed that is save for landing
  spaceship = nil,
  spaceship_with_booster = nil,
  time_elapsed = 0
}

function Game:initialize()
  for k, v in pairs(self.defaults) do self[k] = v end
  local y = love.graphics.getHeight()
  self.players = {
    Spaceship('d', love.graphics.newImage('spaceship1.png'), {x = 40, y = y}),
    Spaceship('l', love.graphics.newImage('spaceship2.png'), {x = love.graphics.getWidth() - 40, y = y})
  }
end

function Game:update(dt)
 -- keep track of time
  self.time_elapsed = self.time_elapsed + dt

  for i, player in ipairs(self.players) do
    player:update(dt)
  end
end

