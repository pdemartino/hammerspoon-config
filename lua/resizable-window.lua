Utils = require("lua/utils")

local LOGGER = hs.logger.new("resizable-window", "debug")

function WindowScreen(hsWindow)
    local frame = hsWindow:screen():frame()
    return {
        positions = {
            topLeft = {x = frame.x, y = frame.y},
            halfLeft = {x = frame.x, y = frame.y + (frame.h/2)},
            topCenter = { x = frame.x + (frame.w / 2), y = frame.y},
            center = { x = frame.x + (frame.w / 2), y = frame.y + (frame.h/2)}
        },
        sizes = {
            fullScreen = {w = frame.w, h = frame.h},
            fullWidthHalfHeight = { w = frame.w, h = frame.h/2},
            halfWidthFullHeight = { w = frame.w/2, h = frame.h},
            quarter = { w = frame.w/2, h = frame.h/2}
        }
    }
end

function getResizableWindow(hsWindow)
    local windowScreen = WindowScreen(hsWindow)
    return {
        moveToLeft = function()
            hsWindow:setTopLeft(windowScreen.positions.topLeft)
            hsWindow:setSize(windowScreen.sizes.halfWidthFullHeight)
        end,
        moveToRight = function()
            hsWindow:setTopLeft(windowScreen.positions.topCenter)
            hsWindow:setSize(windowScreen.sizes.halfWidthFullHeight)
        end,
        moveToTop = function()
            hsWindow:setTopLeft(windowScreen.positions.topLeft)
            hsWindow:setSize(windowScreen.sizes.fullWidthHalfHeight)
        end,
        moveToBottom = function()
            hsWindow:setTopLeft(windowScreen.positions.halfLeft)
            hsWindow:setSize(windowScreen.sizes.fullWidthHalfHeight)
        end,
        moveToCenterMaximized = function()
            hsWindow:setTopLeft(windowScreen.positions.topLeft)
            hsWindow:setSize(windowScreen.sizes.fullScreen)
        end,
        moveToTopLeft = function()
            hsWindow:setTopLeft(windowScreen.positions.topLeft)
            hsWindow:setSize(windowScreen.sizes.quarter)
        end,
        moveToTopRight = function()
            hsWindow:setTopLeft(windowScreen.positions.topCenter)
            hsWindow:setSize(windowScreen.sizes.quarter)
        end,
        moveToBottomLeft = function()
            hsWindow:setTopLeft(windowScreen.positions.halfLeft)
            hsWindow:setSize(windowScreen.sizes.quarter)
        end,
        moveToBottomRight = function()
            hsWindow:setTopLeft(windowScreen.positions.center)
            hsWindow:setSize(windowScreen.sizes.quarter)
        end
    }
end


return {
    focusedWindow = function() return getResizableWindow(hs.window.focusedWindow()) end
}