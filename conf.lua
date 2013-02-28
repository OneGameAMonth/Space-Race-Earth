require('version')
function love.conf(c)
  c.title = "Space Race: Earth (v" .. game.version .. ")"
  c.author = "Thomas R. Koll"
  c.screen.width = 800
  c.screen.height = 600
  c.fullscreen = true
end

