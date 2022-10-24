local LOGGER = hs.logger.new("application-manager", "debug")

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function windowsChoices(windows)
    local choices = {}
    for _,window in pairs(windows) do
        table.insert(
                choices,
                {text = window:title(), uuid = window:id()}
        )
    end
    return choices
end

function minimizeAllWindows(windows)
    for _,window in pairs(windows) do
        window:minimize()
    end
end

function focusApplicationWindow(application, window)
    if not application.screen == nil then
        LOGGER:d("Moving window to screen")
        window:moveToScreen(application.screen)
    end
    window:focus()
end

function appToggle(application)
    if (application.name == nil) then
        LOGGER:w("Application name not defined")
        return
    end

    local app = hs.application.find(application.name)
    if (app == nil) then
        LOGGER:d("Starting application " .. application.name)
        hs.application.launchOrFocus(application.name)
        return
    end

    windows = app:allWindows()
    if app:isFrontmost() then
        LOGGER:d("Hiding all windows for " .. application.name)
        minimizeAllWindows(windows)
        app:hide()
        return
    end

    if tablelength(windows) == 1 then
        LOGGER:d("Only one window found for " .. application.name)
        focusApplicationWindow(application, windows[1])
        return
    end

    LOGGER:d("Listing windows for " .. application.name)
    hs.chooser.new(function(choice)
        focusApplicationWindow(application, hs.window.get(choice.uuid))
    end):choices(windowsChoices(app:allWindows())):show()

end

function newApplication(app)
    return {
        name = app.name,
        screen = app.screen
    }
end


return {
    newApplication = newApplication,
    toggle = appToggle
}