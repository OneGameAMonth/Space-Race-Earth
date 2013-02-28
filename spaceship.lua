Spaceship = class("Spaceship")

function Spaceship:initialize(button, image, position)
  self.max_speed = 2.0
  self.speed = { x = 0, y = 0}
  self.velocity = 0
  self.position = position
  self.thrust = { x = 0, y = 0 }
  self.button = button
  self.boosting = false
  self.image = image
end

function Spaceship:update(dt)
  self.boosting = false -- always set false but if the key is set it will be set to true
  -- Minimum interaction is if you hit space to boost your speed, we use dt to make it smooth
   if love.keyboard.isDown(self.button) then
    self.boosting = true
    self.speed.y = self.speed.y + dt
  end

  self.position.y = self.position.y - self.speed.y

  -- things have a maximum speed, and as log as we haven't reached that we can
  -- use gravity and dt to fall faster.
  if self.speed.y < self.max_speed then
    -- Honestly, I don't know if that's the right formula
    self.speed.y = self.speed.y + dt * game.gravity
  end

  if self.position.y <= 0 then
    -- compare the last speed with the speed we consider save for landing
    if self.speed.y > game.save_landing_speed then
      self.crashed = true
    end
    self.position.y = 0
    game.stopped = true
  end
end

function Spaceship:draw()
  -- let's draw the space ship
  local spaceship = self.image
  if self.boosting then
    spaceship = self.image -- game.spaceship_with_booster
  end
  love.graphics.translate(self.position.x, love.graphics.getHeight() - self.position.y)
  love.graphics.draw(spaceship, 1, 1)
end
