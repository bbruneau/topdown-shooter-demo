DEBUG = {
  showDebugger = true,
  showZombieCount = true,
  hitbox = {
    bullet = true,
    player = true,
    world = false,
    zombie = true,
  },
}

if DEBUG.showDebugger == true then
  require "vendor.lovedebug.lovedebug"
end

S = require "vendor.Strike"

local Bullet  = require "bullet"
local Game    = require "game"
local Sprites = require "sprites"
local Player  = require "player"
local Zombie  = require "zombie"

function love.load()
  Sprites:init()
  Game:init()
end

function love.update(dt)
  TIME_ELAPSED = TIME_ELAPSED + dt
  Player:update(dt)
  Zombie:update(dt)
  Bullet:update(dt)
  Game:update(dt)
end

function love.draw()
  love.graphics.draw(Sprites.background, 0, 0)
  Player:draw()
  Zombie:draw()
  Bullet:draw()
  if DEBUG.showZombieCount == true then love.graphics.print(Zombie:count(), 10, 10) end
  Game:draw()
end
