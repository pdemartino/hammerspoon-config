resizableWindow = require("lua/resizable-window")
applicationManager = require("lua/application-manager")
local LOGGER = hs.logger.new("Init.lua", "debug")

local applications_hotkeys = {
    t = applicationManager.newApplication({name = "iTerm"}),
    b = applicationManager.newApplication({name = "Google Chrome"}),
    i = applicationManager.newApplication({name = "IntelliJ Idea", screen = function() return hs.screen.mainScreen() end}),
}



local application_mod = {"ctrl", "alt", "cmd"}
for key, application in pairs(applications_hotkeys) do
    hs.hotkey.bind(application_mod, key, function()
        applicationManager.toggle(application)
    end)
end

local window_mod = {"ctrl", "alt"}
hs.hotkey.bind(window_mod, "Left", function() resizableWindow.focusedWindow().moveToLeft() end)
hs.hotkey.bind(window_mod, "Right", function() resizableWindow.focusedWindow(). moveToRight() end)
hs.hotkey.bind(window_mod, "Up", function() resizableWindow.focusedWindow(). moveToTop() end)
hs.hotkey.bind(window_mod, "Down", function() resizableWindow.focusedWindow(). moveToBottom() end)
hs.hotkey.bind(window_mod, "q", function() resizableWindow.focusedWindow(). moveToTopLeft() end)
hs.hotkey.bind(window_mod, "w", function() resizableWindow.focusedWindow(). moveToTopRight() end)
hs.hotkey.bind(window_mod, "a", function() resizableWindow.focusedWindow(). moveToBottomLeft() end)
hs.hotkey.bind(window_mod, "s", function() resizableWindow.focusedWindow(). moveToBottomRight() end)
hs.hotkey.bind(window_mod, "Return", function() resizableWindow.focusedWindow(). moveToCenterMaximized() end)
hs.hotkey.bind(window_mod, "d", function() resizableWindow.logStatus() end)

local screen_mod = {"ctrl", "alt", "shift"}
hs.hotkey.bind(screen_mod, "Left", function() hs.window.focusedWindow():moveOneScreenWest() end)
hs.hotkey.bind(screen_mod, "Right", function() hs.window.focusedWindow():moveOneScreenEast() end)
hs.hotkey.bind(screen_mod, "Up", function() hs.window.focusedWindow():moveOneScreenNorth() end)
hs.hotkey.bind(screen_mod, "Down", function() hs.window.focusedWindow():moveOneScreenSud() end)


local choices = {
    {text="primo", subText = "Prima Selezione"},
    {text="secondo", subText = "Seconda Selezione"}
}

function choiceCallBack(choice)
    hs.alert(choice)
end

hs.hotkey.bind(application_mod, "p", function() hs.chooser.new(choiceCallBack):choices(choices):show() end)