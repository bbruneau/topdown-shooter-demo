local Bullet  = require "bullet"
local Sprites = require "sprites"
local Utils   = require "utils"

local Player = {}

function Player:init()
  Player.id = "Player"
  Player.position = Utils:createPosition({
    ox = Sprites.player:getWidth() / 2,
    oy = Sprites.player:getHeight() / 2,
  })
  Player.speed = 150
  Player.turnSpeed = Utils:degToRad(180)
  Player.hitbox = S.trikers.Rectangle(Player.position.x, Player.position.y, Sprites.player:getWidth(),
    Sprites.player:getHeight(), Player.position.dir)
  Player.hasDied = false
end

function Player:getDirection()
  return Player.position.dir
end

function Player:getTurnSpeed(dt)
  return Player.turnSpeed * dt
end

local SHOT_COOLDOWN = 0

function Player:shoot()
  if SHOT_COOLDOWN > 0 then
    return
  else
    Bullet:spawn(Player.position.x, Player.position.y, Player.position.dir)
    SHOT_COOLDOWN = .5
  end
end

function Player:kill(zombie)
  if Player.hasDied == false then
    Player.bloodTimer = 0
    Player.killDirection = zombie.position.dir
    Player.hasDied = true
  end
end

local handleMovement = function(dt)
  if love.keyboard.isDown("right") then
    Utils:turnRight(Player, Player:getTurnSpeed(dt))
  end
  if love.keyboard.isDown("left") then
    Utils:turnLeft(Player, Player:getTurnSpeed(dt))
  end
  if love.keyboard.isDown("up") then
    Utils:moveForward(Player, dt)
  end
  if love.keyboard.isDown("down") then
    Utils:moveBackward(Player, dt)
  end
end


local animateBlood = function(dt)
end

function Player:update(dt)
  if Player.hasDied == true then
    animateBlood(dt)
  else
    handleMovement(dt)
    SHOT_COOLDOWN = math.max(SHOT_COOLDOWN - dt, 0)
  end

end

local drawBlood = function()
  if Player.hasDied == true then
    love.graphics.draw(Sprites.blood, Player.position.x, Player.position.y,
      Player.killDirection, -1, -1,
      Sprites.blood:getHeight() + Sprites.zombie:getWidth(),
      Sprites.blood:getHeight() / 2)
  end
end

function Player:draw()
  drawBlood()
  love.graphics.draw(Sprites.player, Player.position.x, Player.position.y,
    Player:getDirection(), 1, 1,
    Player.position.ox, Player.position.oy
  )
  if DEBUG.hitbox.player == true then Player.hitbox:draw() end
end

return Player
