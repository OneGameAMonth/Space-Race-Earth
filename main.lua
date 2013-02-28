
-- Space Race: Earth
-- (C) 2013 Thomas R. Koll, <info@ananasblau.com>


require('lib/middleclass')
require('game_states/state')
require('game_states/game_state')
require('game_states/start_menu')

function love.load()
  game = Game()
  state = StartMenu()
end

-- update is run again and again, the variable dt tells you how much time elapsed since the last time
function love.update(dt)
  state:update(dt)
end

function love.draw()
  state:draw()
end

function love.keypressed(key)
  state:keypressed(key)
end

