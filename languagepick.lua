-----------------------------------------------------------------------------------------
--
-- languagepick.lua --this is the scene the scene with the pickerwheel for the different languages chosen
--
-----------------------------------------------------------------------------------------
require("languages")
require("level1")
local composer = require( "composer" )
local scene = composer.newScene()
-- include Corona's "widget" library
local widget = require "widget"

function scene:create( event )
    local sceneGroup = self.view

    function onDoneBtnRelease(event)
        local values =  languagePicker:getValues()

        if  _G.pickedLanguages[1] == _LANGUAGES[values[1].index] and _G.pickedLanguages[2] == _LANGUAGES[values[2].index] then 
            print ("the two langueages you picked were the same ones you had before")
            composer.gotoScene( "level1", "fade", 100 )
            return true 

        elseif values[1].index ==  values[2].index then
            print("the two languages are the same")
            return true

        else  _G.pickedLanguages = {_LANGUAGES[values[1].index],  _LANGUAGES[values[2].index]} 
            print ("pickerwheelvals".._LANGUAGES[values[1].index].symbol)
            langText.text = _G.pickedLanguages[1].symbol
            langText2.text = _G.pickedLanguages[2].symbol
             _G.removeAllCells(); 
            composer.gotoScene( "level1", "fade", 100 )
            return true -- indicates successful touch 
        end  

        print ("values 1 and values 2 equal "..values[1].." "..values[2].." ".." respectively")
    end

 
     --widget button for returning to prev screen
    local doneBtn = widget.newButton{
        font = _G.defaultFont, fontsize = _G.defaultFontSize,
        label = "Done",
        labelColor = { default={128}, over={128} },
        default="button.png",
        over="button-over.png",
        width=154, height=40,
        onRelease = onDoneBtnRelease    -- event listener function
    }

    doneBtn.x = display.contentWidth*0.5
    doneBtn.y = display.contentHeight - 111

    -- Configure the picker wheel columns
    local columnData = 
    {
    -- Language of the first column
    { 
        align = "right",
        width = 140,
        startIndex =1,
        labels = _G.languages
    },
    -- Language of the Second Column
    {
        align = "left",
        width = 140,
        startIndex = 4,
        labels = _G.languages
    }
    }
    -- Create the widget
      languagePicker = widget.newPickerWheel
    {
        font = _G.defaultFont, fontsize = _G.defaultFontSize,
        top =   111,
        columns = columnData,
        overlayFrame = 1,
        overlayFrameWidth = 320,
        overlayFrameHeight = 222,
        backgroundFrame = 2,
        backgroundFrameWidth = 320,
        backgroundFrameHeight = 222,
        separatorFrame = 3,
        separatorFrameWidth = 8,
        separatorFrameHeight = 222,
        columnColor = { 0, 0, 0, 0 },
        fontColor = { 0.4, 0.4, 0.4, 0.5 },
        fontColorSelected = { 0.2, 0.6, 0.4 }
    }

    --widget button for returning to prev screen

    sceneGroup:insert( languagePicker )
    sceneGroup:insert( doneBtn )

    end


function scene:show( event )

local sceneGroup = self.view
local phase = event.phase
  
end

function scene:hide( event )
local sceneGroup = self.view
local phase = event.phase
 
 

if event.phase == "will" then
   
    -- Called when the scene is on screen and is about to move off screen
    --
    -- INSERT code here to pause the scene
    -- e.g. stop timers, stop animation, unload sounds, etc.)

elseif phase == "did" then
    previousScene = "languagepick"
    -- Called when the scene is now off screen
end
end

function scene:destroy( event )
local sceneGroup = self.view

-- Called prior to the removal of scene's "view" (sceneGroup)
--
-- INSERT code here to cleanup the scene
-- e.g. remove display objects, remove touch listeners, save state, etc.

if doneBtn then
    doneBtn:removeSelf()    -- widgets must be manually `removed`
end

end

---------------------------------------------------------------------------------

-- Listener setup


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
 