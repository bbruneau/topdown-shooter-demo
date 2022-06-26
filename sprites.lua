local Sprites = {}

function Sprites:loader(name, assetPath)
  if Sprites[name] then
    error("Sprite " .. name .. " already loaded")
  end

  Sprites[name] = love.graphics.newImage(assetPath)
end

function Sprites:init()
  Sprites:loader("background", "sprites/background.png")
  Sprites:loader("bullet", "sprites/bullet.png")
end

return Sprites