local spaces = require('hs.spaces')

hs.hotkey.bind({'cmd'}, '`', function ()
    local APP_NAME = 'kitty'
    function moveWindow(kitty, space, mainScreen)
        local win = nil
        while win == nil do
            win = kitty:mainWindow()
        end
        print(win)
        print(space)
        print(win:screen())
        print(mainScreen)
        local fullScreen = not win:isStandard()
        if fullScreen then
            hs.eventtap.keyStroke('cmd', 'return', 0, kitty)
        end
        winFrame = win:frame()
        scrFrame = mainScreen:fullFrame()
        print(winFrame)
        print(scrFrame)
        if winFrame.h > scrFrame.h then
            winFrame.h = scrFrame.h / 2
        end
        winFrame.w = scrFrame.w
        winFrame.y = scrFrame.y
        winFrame.x = scrFrame.x
        print(winFrame)
        win:setFrame(winFrame, 0)
        spaces.moveWindowToSpace(win, space)
        if fullScreen then
            hs.eventtap.keyStroke('cmd', 'return', 0, kitty)
        end
        win:focus()
    end
    local kitty = hs.application.get(APP_NAME)
    if kitty ~= nil and kitty:isFrontmost() then
        kitty:hide()
    else
        local space = spaces.focusedSpace()
        local mainScreen = hs.screen.mainScreen()
        if kitty == nil then
            hs.application.launchOrFocus(APP_NAME)
            local appWatcher = nil
            print('Create app watcher')
            appWatcher = hs.application.watcher.new(function(new, event, app)
                print(name)
                print(event)
                if event == hs.application.watcher.launched and name == APP_NAME then
                    app:hide()
                    moveWindow(app, space, mainScreen)
                    appWatcher:stop()
                end
            end)
            print('Start app watcher')
            appWatcher:start()
        end
        if kitty ~= nil then
            moveWindow(kitty, space, mainScreen)
        end
    end
end)

hs.hotkey.bind({}, "f13", function()
    hs.task.new("/usr/sbin/screencapture", nil, {"-ic"}):start()
end)