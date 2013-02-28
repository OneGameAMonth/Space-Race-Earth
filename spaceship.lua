Spaceship = class("Spaceship")

function Spaceship:initialize(button, image, position, hud_position)
  self.max_speed = 2.0
  self.speed = { x = 0, y = 0 }
  self.save_landing_speed = 0.5
  self.velocity = 0
  self.position = position
  self.hud_position = hud_position
  self.thrust = { x = 0, y = 0 }
  self.max_thrust = { x = 0.05, y = 0.03 }
  self.button = button
  self.boosting = false
  self.image = image

  self.ground_y = 40 + 32 -- ground + sprite height
end

function Spaceship:update(dt)
  self.boosting = false -- always set false but if the key is set it will be set to true
  -- Minimum interaction is if you hit space to boost your speed, we use dt to make it smooth
   if love.keyboard.isDown(self.button) then
    self.boosting = true
    if self.thrust.y < self.max_thrust.y then
      self.thrust.y = self.thrust.y - dt
    end
    self.speed.y = self.speed.y + self.thrust.y
  else
    self.thrust = {x = 0, y = 0}
  end


  -- things have a maximum speed, and as log as we haven't reached that we can
  -- use gravity and dt to fall faster.
  if self.speed.y < self.max_speed then
    -- Honestly, I don't know if that's the right formula
    self.speed.y = self.speed.y + dt * game.gravity
  end

  self.position.y = self.position.y - self.speed.y / 2

  if self.position.y <= self.ground_y then
    -- compare the last speed with the speed we consider save for landing
    if self.speed.y > self.save_landing_speed then
      self.crashed = true
    end
    self.position.y = self.ground_y
    game.stopped = true
  end
end

function Spaceship:draw()
  love.graphics.setColor(255,255,255,255)
  -- let's draw the space ship
  local spaceship = self.image
  if self.boosting then
    spaceship = self.image -- game.spaceship_with_booster
  end
  love.graphics.push()
  love.graphics.translate(self.position.x, love.graphics.getHeight() - self.position.y)
  love.graphics.draw(spaceship, 1, 1)
  love.graphics.pop()

  love.graphics.push()
  love.graphics.translate(self.hud_position.x, self.hud_position.y)

  -- make it red if we are getting too close too fast
  if self.position.y * self.speed.y > 2 * self.position.y * self.save_landing_speed then
    love.graphics.setColor(255,0,0,255)
  end
  love.graphics.print('Height: ' .. shortdec(self.position.y - self.ground_y) .. 'm', 10, 10)

  -- make it red any time we are too fast
  if self.speed.y > self.save_landing_speed then
    love.graphics.setColor(255,0,0,255)
  else
    love.graphics.setColor(255,255,255,255)
  end
  love.graphics.print('Speed vertical: ' .. shortdec(self.speed.y,2) .. 'm/s', 10, 30)

  love.graphics.setFont(love.graphics.newFont(14))
  love.graphics.setColor(255,255,255,255)

  if self.position.y <= self.ground_y then
    if self.crashed then
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
    love.graphics.print('Hit [' .. self.button .. '] to boost up', 10, 100)
  end
  love.graphics.setColor(200,200,200,255)

  love.graphics.pop()
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
