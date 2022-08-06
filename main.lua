DEBUG = {}

require("vendor.lovedebug.lovedebug")
local World   = require "world"
local Sprites = require("sprites")
local Player  = require("player")
local Zombie  = require("zombie")

function love.load()
  World:init()
  Sprites:init()
  Player:init()
  Zombie:init()
  TIME_ELAPSED = 0
end

function love.keypressed(key)
  if key == "z" then
    Zombie:spawn()
  end
end

function love.update(dt)
  TIME_ELAPSED = TIME_ELAPSED + dt
  Player:handleMovement(dt)
  Zombie:move(dt)
end

function love.draw()
  love.graphics.draw(Sprites.background, 0, 0)
  Player:draw()
  Zombie:draw()
  love.graphics.print(Zombie:count(), 10, 10)
end
