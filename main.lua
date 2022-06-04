local sceneManager = require 'sceneManager'

function love.load( ... )
  sceneManager.changeScene(require 'game')
end

function love.update(dt)
  sceneManager.currentScene.update(dt)
end

function love.draw()
  sceneManager.draw()
end

function love.keypressed(key)
  sceneManager.currentScene.keypressed(key)

  if key == 'escape' then
    love.event.quit()
  end

end

function love.mousepressed(x, y, button)
  sceneManager.currentScene.mousepressed(x, y, button)
end
