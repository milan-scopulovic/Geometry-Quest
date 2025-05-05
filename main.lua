--[[

  Geometry Quest
      by Jaded Jasmine

  A work in progress, but pretty promising :D

]]--

-- Libraries
_G.love = require("love")
_G.Camera = require("camera")
-- Randomizer
math.randomseed(os.time())

---------- MENU FUNCTIONS ----------
function quitGame() -- for love.update()
  if love.keyboard.isDown("escape") then
    love.event.push ("quit")
  end
end

function gameOverScreen(x, y) -- for love.draw()
  if pl.hp <= 0 then
  love.graphics.setColor(0/255,0/255,0/255)
  love.graphics.rectangle("fill", pl.x-800, pl.y-450, 1600, 900)
  
  end
end
---------- MENU FUNCTIONS ----------

---------- RENDERING FUNCTIONS ----------
-- Background Rendering
  bgGrid = { }
tileSize = 12
function bgGroundNoiseUpdate() --for love.update
  local bX = 100 * love.math.random()
	local bY = 100 * love.math.random()
  for y = (pl.y-450)/tonumber(tileSize), (pl.y+450)/tonumber(tileSize) do
		bgGrid[y] = {}
		for x = (pl.x-800)/tonumber(tileSize), (pl.x+800)/tonumber(tileSize) do
			bgGrid[y][x] = love.math.noise(bX+.01*x, bY+.03*y)
		end
	end
end

function bgGroundNoiseDraw()
	for y = (pl.y-450)/tonumber(tileSize), (pl.y+450)/tonumber(tileSize) do
		for x = (pl.x-800)/tonumber(tileSize), (pl.x+800)/tonumber(tileSize) do
			love.graphics.setColor(100/255, 80/255, 253/255, bgGrid[y][x])
			love.graphics.rectangle("fill", x*tileSize, y*tileSize, tileSize, tileSize)
		end
	end
end

bgTimer = 0
function backgroundRendering() --for love.draw()
  love.graphics.setBackgroundColor(100/255, 100/255 , 250/255)
  -- bgGroundNoiseDraw()
  
end
-- UI rendering
function scaleZoom()
  local x = (pl.size*7+pl.speed*3)/10
  return x
end
function uiRendering() -- for love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.print("FPS: "..tostring(love.timer.getFPS()), pl.x+750, pl.y-446)
    ---- Stat Viewer/Debugger
  love.graphics.print(math.random(0, 1000))
  love.graphics.print("x position: "..pl.x, pl.x+600, pl.y - 430)
  love.graphics.print("y position: "..pl.y, pl.x+600, pl.y - 415)
  love.graphics.print("xVelocity: "..pl.xVelocity, pl.x+600, pl.y - 400)
  love.graphics.print("yVelocity: "..pl.yVelocity, pl.x+600, pl.y - 385)
  love.graphics.print("dashCooldown: "..pl.dashCooldown, pl.x+600, pl.y - 370)
  love.graphics.print("modifyHPCooldown: "..modifyHPCooldown, pl.x+600, pl.y - 355)
  love.graphics.print("modifySizeCooldown: "..modifySizeCooldown, pl.x+600, pl.y - 340)
  love.graphics.print("modifySpeedCooldown: "..modifySpeedCooldown, pl.x+600, pl.y - 325)
  love.graphics.print("modifyStrengthCooldown: "..modifyStrengthCooldown, pl.x+600, pl.y - 310)
  love.graphics.print("modifyToughnessCooldown: "..modifyToughnessCooldown, pl.x+600, pl.y - 295)
  love.graphics.print("weaponCooldown: "..plWep.cooldown, pl.x+600, pl.y - 280)
  
  love.graphics.print("HP: "..pl.hp, pl.x + 350, pl.y - 430)
  love.graphics.print("Size: "..pl.size, pl.x + 350, pl.y - 415)
  love.graphics.print("Speed: "..pl.speed, pl.x + 350, pl.y - 400)
  love.graphics.print("Strength: "..pl.strength, pl.x + 350, pl.y - 385)
  love.graphics.print("Toughness: "..pl.toughness, pl.x + 350, pl.y - 370)
  
  love.graphics.print("maxHP: "..pl.maxHP, pl.x + 450, pl.y - 430)
  
  ---- Instructions
  love.graphics.print("Instructions:", pl.x+580, pl.y + 250)
  love.graphics.print("-- Movement:", pl.x+600, pl.y + 265)
  love.graphics.print("- Walking: arrow keys", pl.x+620, pl.y + 280)
  love.graphics.print("- Dash: SPACE", pl.x+620, pl.y + 295)
  love.graphics.print("-- Combat:", pl.x+600, pl.y + 310)
  love.graphics.print("- Attack: A", pl.x+620, pl.y + 325)
  
  -- HP Bar/Heart
  love.graphics.setColor(200/255,30/255,100/255)
  love.graphics.polygon("fill", 
    pl.x -800 + 20+math.random(-0.6, 0.6), pl.y -440 + 20+math.random(-0.6, 0.6),
    pl.x -800 + 20+math.random(-0.6, 0.6), pl.y -440 + 40+math.random(-0.6, 0.6),
    pl.x -800 + 45+math.random(-0.6, 0.6), pl.y -440 + 60+math.random(-0.6, 0.6),
    pl.x -800 + 70+math.random(-0.6, 0.6), pl.y -440 + 40+math.random(-0.6, 0.6),
    pl.x -800 + 70+math.random(-0.6, 0.6), pl.y -440 + 20+math.random(-0.6, 0.6),
    pl.x -800 + 55+math.random(-0.6, 0.6), pl.y -440 + 10+math.random(-0.6, 0.6),
    pl.x -800 + 45+math.random(-0.6, 0.6), pl.y -440 + 30+math.random(-0.6, 0.6),
    pl.x -800 + 40+math.random(-0.6, 0.6), pl.y -440 + 10+math.random(-0.6, 0.6),
    pl.x -800 + 30+math.random(-0.6, 0.6), pl.y -440 + 10+math.random(-0.6, 0.6)
  )
  -- HP Bar/HP Pellets
  for i = 1, pl.hp, 1 do
  love.graphics.rectangle("fill", pl.x-750+30*i+math.random(-0.2, 0.2), pl.y-420+math.random(-0.2, 0.2), 20+math.random(-0.2, 0.2), 20+math.random(-0.2, 0.2))
  end
  -- Dash Cooldown
  for i = 0, 80 - pl.dashCooldown, 1 do
  love.graphics.setColor(0/255,0/255,(150+i*2.3)/255)
  love.graphics.rectangle("fill", pl.x-720+2.5*i+math.random(-0.2, 0.2), pl.y-390, 10, 20)
  end
end

function uiRendering2() -- for love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.print("FPS: "..tostring(love.timer.getFPS()), pl.x+750*scaleZoom(), pl.y-446*scaleZoom())
    ---- Stat Viewer/Debugger
  love.graphics.print(math.random(0, 1000))
  love.graphics.print("x position: "..pl.x, pl.x+600*scaleZoom(), pl.y - 430*scaleZoom())
  love.graphics.print("y position: "..pl.y, pl.x+600*scaleZoom(), pl.y - 415*scaleZoom())
  love.graphics.print("xVelocity: "..pl.xVelocity, pl.x+600*scaleZoom(), pl.y - 400*scaleZoom())
  love.graphics.print("yVelocity: "..pl.yVelocity, pl.x+600*scaleZoom(), pl.y - 385*scaleZoom())
  love.graphics.print("dashCooldown: "..pl.dashCooldown, pl.x+600*scaleZoom(), pl.y - 370*scaleZoom())
  love.graphics.print("modifyHPCooldown: "..modifyHPCooldown, pl.x+600*scaleZoom(), pl.y - 355*scaleZoom())
  love.graphics.print("modifySizeCooldown: "..modifySizeCooldown, pl.x+600*scaleZoom(), pl.y - 340*scaleZoom())
  love.graphics.print("modifySpeedCooldown: "..modifySpeedCooldown, pl.x+600*scaleZoom(), pl.y - 325*scaleZoom())
  love.graphics.print("modifyStrengthCooldown: "..modifyStrengthCooldown, pl.x+600*scaleZoom(), pl.y - 310*scaleZoom())
  love.graphics.print("modifyToughnessCooldown: "..modifyToughnessCooldown, pl.x+600*scaleZoom(), pl.y - 295*scaleZoom())
  love.graphics.print("weaponCooldown: "..plWep.cooldown, pl.x+600*scaleZoom(), pl.y - 280*scaleZoom())
  
  love.graphics.print("HP: "..pl.hp, pl.x + 350*scaleZoom(), pl.y - 430*scaleZoom())
  love.graphics.print("Size: "..pl.size, pl.x + 350*scaleZoom(), pl.y - 415*scaleZoom())
  love.graphics.print("Speed: "..pl.speed, pl.x + 350*scaleZoom(), pl.y - 400*scaleZoom())
  love.graphics.print("Strength: "..pl.strength, pl.x + 350*scaleZoom(), pl.y - 385*scaleZoom())
  love.graphics.print("Toughness: "..pl.toughness, pl.x + 350*scaleZoom(), pl.y - 370*scaleZoom())
  
  love.graphics.print("maxHP: "..pl.maxHP, pl.x + 450*scaleZoom(), pl.y - 430*scaleZoom())
  
  ---- Instructions
  love.graphics.print("Instructions:", pl.x+580*scaleZoom(), pl.y + 250*scaleZoom())
  love.graphics.print("-- Movement:", pl.x+600*scaleZoom(), pl.y + 265*scaleZoom())
  love.graphics.print("- Walking: arrow keys", pl.x+620*scaleZoom(), pl.y + 280*scaleZoom())
  love.graphics.print("- Dash: SPACE", pl.x+620*scaleZoom(), pl.y + 295*scaleZoom())
  love.graphics.print("-- Combat:", pl.x+600*scaleZoom(), pl.y + 310*scaleZoom())
  love.graphics.print("- Attack: A", pl.x+620*scaleZoom(), pl.y + 325*scaleZoom())
  
  -- HP Bar/Heart
  -- *(pl.size*7+pl.speed*3)
  love.graphics.setColor(200/255,30/255,100/255)
  love.graphics.polygon("fill", 
    pl.x+(-800 + 20+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 20+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 20+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 40+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 45+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 60+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 70+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 40+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 70+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 20+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 55+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 10+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 45+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 30+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 40+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 10+math.random(-0.6, 0.6))*scaleZoom(),
    pl.x+(-800 + 30+math.random(-0.6, 0.6))*scaleZoom(), pl.y+(-440 + 10+math.random(-0.6, 0.6))*scaleZoom()
  )
  -- HP Bar/HP Pellets
  for i = 1, pl.hp, 1 do
  love.graphics.rectangle("fill", 
    pl.x+(-750+30*i+math.random(-0.2, 0.2))*scaleZoom(), 
    pl.y+(-420+math.random(-0.2, 0.2))*scaleZoom(), 
    (20+math.random(-0.2, 0.2))*scaleZoom(), 
    (20+math.random(-0.2, 0.2))*scaleZoom()
    )
  end
  -- Dash Cooldown
  for i = 0, 80 - pl.dashCooldown, 1 do
  love.graphics.setColor(0/255,0/255,(150+i*2.3)/255)
  love.graphics.rectangle("fill", 
    pl.x+(-720+2.5*i+math.random(-0.2, 0.2))*scaleZoom(), 
    pl.y-390*scaleZoom(), 
    10*scaleZoom(), 
    20*scaleZoom()
    )
  end
end

-- Character Rendering
function characterRendering() -- for love.draw()
---- Character
  -- Body 
  -- color depends on hp
  love.graphics.setColor(
    (pl.x%255)/255*(0.2+pl.hp/10),
    (255-(pl.x%255))/255*(0.2+pl.hp/10),
    (pl.y%255)/255*(0.2+pl.hp/10)
  )
  -- polygon body fuckery (polygonClose - random value, common for the closing and opening point of the polygon (smoothens visuals)
  polygonClose = math.random(-5, 5)
  love.graphics.polygon("fill",
    -23+pl.x              + math.random(-5, 5) * (pl.strength/3),  -45+pl.y                 + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x-50 * pl.size + polygonClose       * (pl.strength/3),  -45+pl.y + 30  * pl.size + polygonClose       * (pl.strength/3),
    -23+pl.x-30 * pl.size + math.random(-5, 5) * (pl.strength/3),  -45+pl.y + 90  * pl.size + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x+30 * pl.size + math.random(-5, 5) * (pl.strength/3),  -45+pl.y + 110 * pl.size + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x+90 * pl.size + math.random(-5, 5) * (pl.strength/3),  -45+pl.y + 80  * pl.size + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x+95 * pl.size + math.random(-5, 5) * (pl.strength/3),  -45+pl.y + 20  * pl.size + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x+60 * pl.size + math.random(-5, 5) * (pl.strength/3),  -45+pl.y - 25  * pl.size + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x-20 * pl.size + math.random(-5, 5) * (pl.strength/3),  -45+pl.y - 25  * pl.size + math.random(-5, 5) * (pl.strength/3),
    -23+pl.x-50 * pl.size + polygonClose       * (pl.strength/3),  -45+pl.y + 30  * pl.size + polygonClose       * (pl.strength/3)
    )
  --love.graphics.setColor(0,0,0)
  --love.graphics.circle("line",pl.x, pl.y, 10)

  ---- Face ----
  -- Eyes
  love.graphics.setColor(
    ((180+math.random(-5, 5))/255)*(0.1+pl.hp/10),
    ((180+math.random(-5, 5))/255)*(0.1+pl.hp/10),
    ((180+math.random(-5, 5))/255)*(0.1+pl.hp/10)
    )
  love.graphics.circle("fill", -23+pl.x+(pl.xVelocity/1.5), -45+pl.y+10+(pl.yVelocity/1.5), (10+math.random(-1.0, 1.0))*pl.size)
  love.graphics.circle("fill", -23+pl.x+50*pl.size+(pl.xVelocity/1.5), -45+pl.y+10+(pl.yVelocity/1.5), (10+math.random(-1.0, 1.0))*pl.size)
  -- Mouth
  love.graphics.setColor(
    ((40+math.random(-5, 5))/255)*((1-pl.hp/10)*2),
    ((40+math.random(-5, 5))/255)*((1-pl.hp/10)*2),
    ((40+math.random(-5, 5))/255)*((1-pl.hp/10)*2)
    )
  love.graphics.rectangle("fill", -23+pl.x-5+math.random(-0.1, 0.1)+(pl.xVelocity/1.2), -45+pl.y+(60+math.random(-0.1, 0.1))*pl.size+(pl.yVelocity/1.2), 60*pl.size, 10*pl.size)
  love.graphics.setColor(0,0,0)
end

-- Weapon Attack and Rendering
---- Weapon Attack Formula
dirx, diry = 0, 0
function weaponTrajectory() -- for love.update()
      if love.keyboard.isDown('a') and plWep.cooldown <= 0 then
        plWep.cooldown = (pl.strength*3+pl.speed)/4*50
        dirx, diry = 0, 0
        if love.keyboard.isDown('up') then 
          diry = -1
        end
        if love.keyboard.isDown('down') then 
          diry = 1
        end
        if love.keyboard.isDown('left') then
          dirx = -1
        end
        if love.keyboard.isDown('right') then 
          dirx = 1
        end
      end
      
      if plWep.cooldown > 0 then
      plWep.cooldown = plWep.cooldown - pl.speed
      end
end
---- Weapon Throw Animation
function drawWeapon() -- for love.draw()
  -- Weapon Color
  love.graphics.setColor((20+pl.strength*7)/255, (20+pl.toughness*7)/255, (20+pl.speed*7)/255)
  -- The Actual Animation (HOW TF DID I MAKE IT WORK)
  if dirx == 0 or diry == 0 then
    love.graphics.polygon("fill",
    -25+20  + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2),
    -40+-10 + pl.y     + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2),
    -25+20  + pl.x +10 + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2), 
    -40+-10 + pl.y     + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2),
    -25+20  + pl.x +10 + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2), 
    -40+-10 + pl.y+100 + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2),
    -25+20  + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2), 
    -40+-10 + pl.y+100 + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2)
    )
    love.graphics.polygon("fill",
    -25+-25 + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -40+35 + pl.y      + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -25+-25 + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -40+35 + pl.y+10   + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -25+-25 + pl.x+100 + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -40+35 + pl.y+10   + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -25+-25 + pl.x+100 + pl.xVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2),
    -40+35 + pl.y      + pl.yVelocity*2 + math.random(-0.5*pl.strength*math.sqrt(2),   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)*math.sqrt(2)
  )
    for i = 45, 45 + pl.strength + pl.speed, 1 do
    love.graphics.circle("line", 
      -25+25 + pl.x + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength)*math.sqrt(2) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2), 
      -40+40 + pl.y + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength)*math.sqrt(2) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)*math.sqrt(2), 
      i + math.random(-0.2, 0.2)*pl.strength
    )
    end
  else
    love.graphics.polygon("fill",
    -25+20  + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80),
    -40+-10 + pl.y     + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80),
    -25+20  + pl.x +10 + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80), 
    -40+-10 + pl.y     + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80),
    -25+20  + pl.x +10 + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80), 
    -40+-10 + pl.y+100 + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80),
    -25+20  + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80), 
    -40+-10 + pl.y+100 + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80)
    )
    love.graphics.polygon("fill",
    -25+-25 + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -40+35 + pl.y      + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -25+-25 + pl.x     + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -40+35 + pl.y+10   + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -25+-25 + pl.x+100 + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -40+35 + pl.y+10   + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -25+-25 + pl.x+100 + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80),
    -40+35 + pl.y      + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*plWep.cooldown/80)
  )
    for i = 45, 45 + pl.strength + pl.speed, 1 do
    love.graphics.circle("line", 
      -25+25 + pl.x + pl.xVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(dirx)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80), 
      -40+40 + pl.y + pl.yVelocity*2 + math.random(-0.5*pl.strength,   0.5*pl.strength) + tonumber(diry)*plWep.cooldown*5.5 * math.sin(math.pi*(plWep.cooldown)/80), 
      i + math.random(-0.2, 0.2)*pl.strength
    )
    end
  end
end

---------- RENDERING FUNCTIONS ----------

-- Miscellaneous Updates
function miscUpdate() -- for love.update()
-- scale font size to zoom
gameFont = love.graphics.newFont("fonts/Roboto-Light.ttf", 13*scaleZoom())
love.graphics.setFont(gameFont)  
end



---------- PROTAGONIST STAT UPDATE FUNCTIONS ----------
function updateProtagStats() -- for love.update()
pl.maxHP = 4 + pl.toughness
end
---------- PROTAGONIST STAT UPDATE FUNCTIONS ----------

---------- MOVEMENT FUNCTIONS ----------

function movementProtag() -- for love.update()
  -- Character Movement (up/down/left/right)
  ---- Walking
  if love.keyboard.isDown('left') then
  pl.xVelocity = pl.xVelocity - pl.speed
  end
  if love.keyboard.isDown('right') then
    pl.xVelocity = pl.xVelocity + pl.speed
  end
  if love.keyboard.isDown('up') then
    pl.yVelocity = pl.yVelocity - pl.speed
  end
  if love.keyboard.isDown('down') then
    pl.yVelocity = pl.yVelocity + pl.speed
  end
  
  -- Dash (SPACE + up/down/left/right)
  ---- Dash
  ---- Cooldown timer
  if(pl.dashCooldown > 0) then
    pl.dashCooldown = pl.dashCooldown - 1
  end
  if love.keyboard.isDown('space') and pl.dashCooldown == 0 then
    if love.keyboard.isDown('left') then
      pl.xVelocity = pl.xVelocity - 50*(2/3+pl.speed/3)
      pl.dashCooldown = 80
    end
    if love.keyboard.isDown('right') then
      pl.xVelocity = pl.xVelocity + 50*(2/3+pl.speed/3)
      pl.dashCooldown = 80
    end
    if love.keyboard.isDown('up') then
      pl.yVelocity = pl.yVelocity - 50*(2/3+pl.speed/3)
      pl.dashCooldown = 80
    end
    if love.keyboard.isDown('down') then
      pl.yVelocity = pl.yVelocity + 50*(2/3+pl.speed/3)
      pl.dashCooldown = 80
    end
  end  
  
  -- Acceleration
  pl.x = pl.x + pl.xVelocity
  pl.y = pl.y + pl.yVelocity
  
  -- Deceleration
  pl.xVelocity = pl.xVelocity * 0.8
  pl.yVelocity = pl.yVelocity * 0.8
  
end
---------- MOVEMENT FUNCTIONS ----------

---------- COMBAT FUNCTIONS ----------

-- FOR DEBUG --
modifyHPCooldown = 0
modifySizeCooldown = 0
modifySpeedCooldown = 0
modifyStrengthCooldown = 0
modifyToughnessCooldown = 0
function debugTools() -- for love.update()

  function modifyHP()
    if love.keyboard.isDown('-') and modifyHPCooldown == 0 then
      pl.hp = pl.hp - 1
      modifyHPCooldown = 20
    end
    if love.keyboard.isDown('=') and modifyHPCooldown == 0 then
      pl.hp = pl.hp + 1
      modifyHPCooldown = 20
    end
    if modifyHPCooldown > 0 then
      modifyHPCooldown = modifyHPCooldown - 1
    end
  end
  
  function modifySize()
    if love.keyboard.isDown('[') and modifySizeCooldown == 0 then
      pl.size = pl.size - 0.1
      modifySizeCooldown = 20
    end
    if love.keyboard.isDown(']') and modifySizeCooldown == 0 then
      pl.size = pl.size + 0.1
      modifySizeCooldown = 20
    end
    if modifySizeCooldown > 0 then
      modifySizeCooldown = modifySizeCooldown- 1
    end
  end
  
  function modifySpeed()
    if love.keyboard.isDown(';') and modifySpeedCooldown == 0 then
      pl.speed = pl.speed - 0.5
      modifySpeedCooldown = 20
    end
    if love.keyboard.isDown('\'') and modifySpeedCooldown == 0 then
      pl.speed = pl.speed + 0.5
      modifySpeedCooldown = 20
    end
    if modifySpeedCooldown > 0 then
      modifySpeedCooldown = modifySpeedCooldown - 1
    end
  end
  
  function modifyStrength()
    if love.keyboard.isDown(',') and modifyStrengthCooldown == 0 then
      pl.strength = pl.strength - 0.5
      modifyStrengthCooldown = 20
    end
    if love.keyboard.isDown('.') and modifyStrengthCooldown == 0 then
      pl.strength = pl.strength + 0.5
      modifyStrengthCooldown = 20
    end
    if modifyStrengthCooldown > 0 then
      modifyStrengthCooldown = modifyStrengthCooldown - 1
    end
  end
  
  function modifyToughness()
    if love.keyboard.isDown('9') and modifyToughnessCooldown == 0 then
      pl.toughness = pl.toughness - 1
      modifyToughnessCooldown = 20
    end
    if love.keyboard.isDown('0') and modifyToughnessCooldown == 0 then
      pl.toughness = pl.toughness + 1
      modifyToughnessCooldown = 20
    end
    if modifyToughnessCooldown > 0 then
      modifyToughnessCooldown = modifyToughnessCooldown - 1
    end
  end
  
  modifyHP()
  modifySize()
  modifySpeed()
  modifyStrength()
  modifyToughness()
  
end
---------- COMBAT FUNCTIONS --------- 
---------- COMBAT FUNCTIONS ---------

---------- MAIN FUNCTIONS ----------
function love.load()
  -- Protagonist Class
  _G.pl = {
    x = 0, y = 0,
    xVelocity = 0, yVelocity = 0,
    dashCooldown = 0,  
    -- Attributes
    hp = 5, strength = 1, speed = 1, size = 1, toughness = 1,
    maxHP = 4,
    
    
    -- Unused
    moveLeft = 0, moveRight = 0,
  }
  -- Protagonist's Weapon Class
  _G.plWep = {
    cooldown = 0,
  }
  -- World Gen
  _G.heals= {}
  
  -- Camera defined at the position of the protagonist
  camera = Camera(pl.x, pl.y)

  -- GameFont
  gameFont = love.graphics.newFont("fonts/Roboto-Bold.ttf", 13*scaleZoom())
  love.graphics.setFont(gameFont)
end

function love.update(dt)
-- t = t + dt
-- Character Controls
debugTools()
updateProtagStats()
movementProtag()
weaponTrajectory()
miscUpdate()
-- bgGroundNoiseUpdate()
quitGame()

-- Camera Following
camera:lookAt(pl.x, pl.y)
camera:zoomTo(10/((pl.size*7+pl.speed*3)))

end

function love.draw()
  -- Camera Begin
  camera:attach()
  -- Background
  backgroundRendering()
  -- UI and Character
  uiRendering2()
  characterRendering()
  -- Weapon
  drawWeapon()
  
  -- Game Over Screen
  gameOverScreen(pl.x, pl.y)
  -- Camera End
  camera:detach()
  
end

---------- CAMERA FUNCTION ----------
---------- CAMERA FUNCTION ----------

---------- MAIN FUNCTIONS ----------
















