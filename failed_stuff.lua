-- Weapon Visuals Rendering
function weaponRendering()
  -- function to draw the sword
  
  attackDuration = 300
  function drawSword(atx, aty, i)
    love.graphics.setColor(50/255,50/255,50/255)
    love.graphics.polygon("fill",
    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+100      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y+50     +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+100      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y        +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+85       +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y        +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+85       +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y-10     +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+90       +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y-10     +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+90       +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y-130    +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+100      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y-140    +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+115      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y-120    +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+105      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y+10     +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+105      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y+50     +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+100      +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y+52.5   +tonumber(i*aty),

    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+95       +tonumber(i*atx),
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y+50     +tonumber(i*aty),
    
    math.random(-0.4, 0.4) + tonumber(protag.xVelocity/1.4)*10-70+protag.x+95       +tonumber(i*atx), 
    math.random(-0.4, 0.4) + tonumber(protag.yVelocity/1.4)*10+20 + protag.y+20     +tonumber(i*aty)   
  )

  end

  dirx, diry = 0, 0
    -- Attack Cooldown
    if protag.weaponCooldown > 0 then
      protag.weaponCooldown = protag.weaponCooldown - 1
    end
    
    -- if attacking
    if love.keyboard.isDown("a") and protag.weaponCooldown==0 and (protag.xVelocity~=0 or protag.yVelocity~=0) then
      weaponAttack = 1
      attackDistance = 200
      
          -- set attack direction
          if love.keyboard.isDown("left") then
            dirx = -1
          end
          if love.keyboard.isDown("right") then
            dirx = 1
          end
          if love.keyboard.isDown("up") then
            diry = -1
          end
          if love.keyboard.isDown("down") then
            diry = 1
          end
          protag.weaponCooldown = 50
          -- drawing sword when attacking
          if attackDuration > 0 then
          drawSword(dirx, diry, attackDistance)
          attackDuration = attackDuration - 1
          end
    else
      -- if not attacking
      -- drawing sword when not attacking
      drawSword(dirx, diry, 0)
    end
end


--[[
---- Dumb manual polygon moving algorithm (scrapped)
function movement_failed()
-- failed angle thingie
  protag.ang = protag.ang + 0.5*math.pi*dt
-- Moving horizontally
if protag.moveLeft == protag.moveRight then
  protag.moveRight = 1
  protag.moveLeft = 0
end

if protag.moveRight == 1 then
protag.x = protag.x + 1
end
if protag.moveLeft == 1 then
  protag.x = protag.x - 1
end

if protag.x >= 900 and protag.moveRight == 1 then
  protag.moveLeft = 1
  protag.moveRight = 0
end
if protag.x <= 300 and protag.moveLeft == 1 then
  protag.moveLeft = 0
  protag.moveRight = 1
end

-- Moving vertically
protag.y = 270+math.sin(math.random(-1, 1))*5
end
--]]

  --[[ Background
  love.graphics.setBackgroundColor(100/255, 100/255 , 250/255)
  love.graphics.setColor(50/255, 50/255 , 83/255)
  love.graphics.rectangle("line", 250+math.random(-1.2, 1.2), 50+math.random(-1.2, 1.2), 75+math.random(-1.2, 1.2), 25+math.random(-1.2, 1.2))
  love.graphics.setColor(150/255, 50/255 , 180/255)
  love.graphics.circle("line", 500+math.random(-1.2, 1.2), 200+math.random(-1.2, 1.2), 25)
  love.graphics.setColor(250/255, 250/255 , 180/255)
  love.graphics.line(325+math.random(-1.2, 1.2), 75+math.random(-1.2, 1.2), 475+math.random(-1.2, 1.2), 200+math.random(-1.2, 1.2))
  love.graphics.setColor(100/255, 250/255 , 0/255)
  love.graphics.arc("fill", 750+math.random(-1.2, 1.2), 650+math.random(-1.2, 1.2), 50, 0, 1.58, 12+math.random(-1.2, 1.2))
  ]]-- Background
  
  -- Perlin Noise Background
  bgGrid = { }
function bgGroundNoiseUpdate() --for love.update
  local bX = 100 * love.math.random()
	local bY = 100 * love.math.random()
	for y = -100, 0 do
		bgGrid[y] = {}
		for x = -100, 0 do
			bgGrid[y][x] = love.math.noise(bX+.1*x, bY+.3*y)
		end
	end
end

function bgGroundNoiseDraw()
  local tileSize = 12
	for y = -100, #bgGrid do
		for x = -100, #bgGrid[y] do
			love.graphics.setColor(200/255, 100/255, 253/255, bgGrid[y][x])
			love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize, tileSize)
		end
	end
end

function backgroundRendering() --for love.draw()
  love.graphics.setBackgroundColor(100/255, 100/255 , 250/255)
  bgGroundNoiseDraw()
  
end
  -- Perlin Noise Background
