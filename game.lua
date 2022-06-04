local game = {}

local SCREEN_WIDTH
local SCREEN_HEIGHT

local PAD_CIRCLE_RADIUS = 200

local ballVelocity = {['x'] = 100, ['y']  = - 100}
local ballPosition = {}
local ballRadius = 10

local PAD_WIDTH = 100
local PAD_HEIGHT = 20
local padAngle = math.pi / 2
local padCenter = {}

local function radToCartesian(origin, radius, angle)
  return {
    ['x'] = origin.x + radius * math.cos(angle),
    ['y'] = origin.y - radius * math.sin(angle)
  }
end

function game.load()
  SCREEN_WIDTH = love.graphics.getWidth()
  SCREEN_HEIGHT = love.graphics.getHeight()

  ballPosition = {
    ['x'] = 0,
    ['y'] = 0
  }

  padCenter = radToCartesian(
    {['x'] = 0, ['y'] = 0},
     PAD_CIRCLE_RADIUS,
     padAngle
  )
end

function game.update(dt)
  -- update ball position
  ballPosition.x = ballPosition.x + ballVelocity.x * dt
  ballPosition.y = ballPosition.y + ballVelocity.y * dt

  -- controls
  if love.keyboard.isDown('right', 'd') then
    padAngle = padAngle - 0.03
  end
  if love.keyboard.isDown('left', 'a') then
    padAngle = padAngle + 0.03
  end

  -- update pad position
  padCenter = radToCartesian(
    {['x'] = 0, ['y'] = 0},
     PAD_CIRCLE_RADIUS,
     padAngle
  )
end

function game.draw()
  love.graphics.translate(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)

  -- draw pad circle
  love.graphics.circle("line", 0, 0, PAD_CIRCLE_RADIUS)

  -- draw ball
  love.graphics.circle("fill", ballPosition.x, ballPosition.y, ballRadius)

  -- draw pad
  love.graphics.push()
    love.graphics.translate(padCenter.x, padCenter.y)
    love.graphics.push()
      love.graphics.rotate(-padAngle + math.pi / 2)
      love.graphics.rectangle("fill" , - PAD_WIDTH / 2, - PAD_HEIGHT / 2, PAD_WIDTH, PAD_HEIGHT)
    love.graphics.pop()
  love.graphics.pop()

end


return game