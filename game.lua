
Game = class('Game')

-- Here we keep any data from the game like height, speed, gravity
Game.defaults = {
  stopped = false,
  boosting = false,
  speed_vertical = 0,
  gravity = 0.2,
  save_landing_speed = 0.2, -- for our win/lose condition we define a maximum speed that is save for landing
  spaceship = nil,
  spaceship_with_booster = nil,
  time_elapsed = 0,
  fonts = {}
}

function Game:initialize()
  for k, v in pairs(self.defaults) do self[k] = v end
  self:createFonts(0)
end

function Game:start()
  state = GameState()
  local y = love.graphics.getHeight()
  local middle = love.graphics.getWidth() / 2
  self.players = {
    Spaceship('d', love.graphics.newImage('spaceship1.png'),
        {x = middle - 40, y = y}, {x = middle - 250, y = 40}), -- guesstimate text width to 150
    Spaceship('l', love.graphics.newImage('spaceship2.png'),
        {x = middle + 40, y = y}, {x = middle + 100, y = 40})
  }
end

function Game:createFonts(offset)
  self.fonts = {
    lineHeight = (10 + offset) * 1.7,
    small = love.graphics.newFont(12 + offset),
    regular = love.graphics.newImageFont('images/font.png',   " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\""),
    large = love.graphics.newFont(24 + offset),
    very_large = love.graphics.newFont(48 + offset)
  }
end

function Game:update(dt)
  -- keep track of time
  self.time_elapsed = self.time_elapsed + dt

  for i, player in ipairs(self.players) do
    player:update(dt)
  end
end

