function love.conf(t)
  t.window.title = "Geometry Quest"
  t.window.icon = "icon/character.png"
  
  -- t.version = "1.0.0"
  t.identity = "data/saves"
  t.console = false -- windows only
  t.externalstorage = false -- android only
  t.gammacorrect = true
  
  t.window.display = 1
  t.window.width = 1600
  t.window.height = 900
  t.window.x = 160
  t.window.y = 90
  
  t.window.minwidth = 640
  t.window.minheight = 360
  t.window.borderless = false
  t.window.resizable = false
  
end