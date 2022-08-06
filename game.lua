-- local Utils = require "utils"
local Player = require "player"
local Zombie = require "zombie"

local Game = {}

local w = love.graphics.getWidth() - 2;
local h = love.graphics.getHeight() - 2;
local coverOpacity = 0;

function Game:init()
  math.randomseed(os.time())
  coverOpacity = 0;

  Game.worldHitbox = S.trikers.Collider(
    S.hapes.Edge(1, 1, 1, h),
    S.hapes.Edge(1, h, w, h),
    S.hapes.Edge(w, h, w, 1),
    S.hapes.Edge(w, 1, 1, 1)
  )

  Player:init()
  Zombie:init()
  TIME_ELAPSED = 0
end

function Game:fadeToBlack(dt)
  if coverOpacity < 1 and Player.hasDied == true then
    coverOpacity = math.min(coverOpacity + dt, 1)
  end
end

function Game:endGame()
  if Player.hasDied then
    love.graphics.setColor(0, 0, 0, coverOpacity)
    love.graphics.rectangle("fill", 0, 0, w, h)
    love.graphics.setColor(255, 255, 255)
    if coverOpacity == 1 then
      love.graphics.printf("You died!", 0, h / 2, w, "center")
      love.graphics.printf("Try again? (y/n)", 0, h / 2 + 20, w, "center")
      function love.keypressed(key)
        if key == "y" then
          Game:init()
        end
        if key == "n" then
          love.event.quit()
        end
      end
    end
  end
end

function Game:update(dt)
  Game:fadeToBlack(dt)
end

function Game:draw()
  if DEBUG.hitbox.world == true then Game.worldHitbox:draw() end
  Game:endGame()
end

return Game
