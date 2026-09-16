--[[
======================================================================
                         REM UI v5 TUTORIAL
======================================================================

This file is a simple guide for making your own script UI with REM.
You do NOT need to edit the REM UI library itself.

HOW TO USE
----------
1. Run rem-ui-v5.lua first.
2. Run this file after it in the SAME Matcha Lua environment.
3. Copy the examples you need.
4. Change titles, options and the code inside Callback functions.

IMPORTANT
---------
REM already creates these tabs for you:
  - Home
  - Settings

Do NOT create Home or Settings again.

REM automatically handles the UI animations for tabs, buttons, toggles,
sliders, dropdowns, pages, themes and notifications.

======================================================================
                         1. GET THE UI
======================================================================
]]

local UI = Rem
assert(UI and UI.Alive, "Run rem-ui-v5.lua first")

-- UI now means the REM UI library.
-- You will use UI:AddTab(), UI:Notify(), UI:SetTheme(), etc.


--[[
======================================================================
                         2. CREATE A TAB
======================================================================

This creates a new tab in the left sidebar.

Built-in icon names:
  "script"
  "home"
  "gear"

For most custom script tabs, use "script".
]]

local Main = UI:AddTab({
    Title = "Main",
    Icon = "script"
})

-- Another example:
local Player = UI:AddTab({
    Title = "Player",
    Icon = "gear"
})


--[[
======================================================================
                         3. ADD A LABEL
======================================================================

Labels only display information.
They do not run code when clicked.
]]

Main:AddLabel({
    Title = "My Script",
    Description = "Choose your settings below."
})


--[[
======================================================================
                         4. ADD A BUTTON
======================================================================

A button runs code when the user presses it.

PUT YOUR SCRIPT CODE INSIDE:
    Callback = function()
        -- your code here
    end
]]

Main:AddButton({
    Title = "Run Script",
    Description = "Press this to run the feature.",
    ButtonText = "Run",

    Callback = function()
        -- =====================================
        -- YOUR CODE GOES HERE
        -- =====================================
        print("Button pressed!")

        UI:Notify({
            Title = "REM",
            Content = "Script started!",
            Type = "success",
            Duration = 4
        })
    end
})


--[[
======================================================================
                         5. ADD A TOGGLE
======================================================================

A toggle gives you ON / OFF.

'value' will automatically be:
    true  = ON
    false = OFF
]]

local EnabledToggle = Main:AddToggle({
    Title = "Enabled",
    Description = "Turn the feature on or off.",
    Default = false,

    Callback = function(value)
        if value then
            print("Feature is ON")
            -- code for ON goes here
        else
            print("Feature is OFF")
            -- code for OFF goes here
        end
    end
})


--[[
======================================================================
                         6. ADD A SLIDER
======================================================================

A slider gives the user a number.

Min     = smallest number
Max     = biggest number
Step    = how much the value changes each step
Default = starting value

'value' is the current slider number.
]]

local SpeedSlider = Main:AddSlider({
    Title = "Speed",
    Description = "Choose the speed value.",

    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,

    Callback = function(value)
        print("Speed is now:", value)

        -- Example:
        -- YourSpeedVariable = value
    end
})


--[[
======================================================================
                         7. ADD A DROPDOWN
======================================================================

A dropdown lets the user choose ONE option from a list.

IMPORTANT:
Default should normally match one of the values inside Options.

'value' becomes the selected option text.
]]

local ModeDropdown = Main:AddDropdown({
    Title = "Mode",
    Description = "Choose a mode.",

    Options = {
        "Normal",
        "Fast",
        "Extreme"
    },

    Default = "Normal",

    Callback = function(value)
        print("Selected mode:", value)

        if value == "Normal" then
            -- Normal mode code
        elseif value == "Fast" then
            -- Fast mode code
        elseif value == "Extreme" then
            -- Extreme mode code
        end
    end
})


--[[
======================================================================
                         8. USE SELECTED VALUES
======================================================================

Every toggle, slider and dropdown returned by REM can be read later.

Use:
    control:GetValue()

This is useful when you want the user to choose settings first,
then press one button to run the script using those settings.
]]

Main:AddButton({
    Title = "Run With Settings",
    Description = "Uses your current toggle, slider and dropdown values.",
    ButtonText = "Start",

    Callback = function()
        local enabled = EnabledToggle:GetValue()
        local speed = SpeedSlider:GetValue()
        local mode = ModeDropdown:GetValue()

        print("Enabled:", enabled)
        print("Speed:", speed)
        print("Mode:", mode)

        -- Example:
        -- RunMyScript(enabled, speed, mode)
    end
})


--[[
======================================================================
                         9. NOTIFICATIONS
======================================================================

Use UI:Notify() anywhere in your script.

Types:
    "info"
    "success"
    "error"

Duration is in seconds.
Recommended: 3 to 6 seconds.
]]

Player:AddButton({
    Title = "Test Notification",
    Description = "Shows a REM notification.",
    ButtonText = "Show",

    Callback = function()
        UI:Notify({
            Title = "Hello",
            Content = "This is a custom notification.",
            Type = "info",
            Duration = 5
        })
    end
})

-- More notification examples:
-- UI:Notify({Title="Success", Content="Done!", Type="success", Duration=4})
-- UI:Notify({Title="Error", Content="Something failed.", Type="error", Duration=5})


--[[
======================================================================
                     10. CHANGE A CONTROL WITH CODE
======================================================================

You can change controls from your own code.

SetValue(value)
    Changes the value AND runs its Callback if the value changed.

SetValue(value, true)
    Changes the UI value silently WITHOUT running its Callback.
]]

Player:AddButton({
    Title = "Load Preset",
    Description = "Changes several controls automatically.",
    ButtonText = "Apply",

    Callback = function()
        EnabledToggle:SetValue(true)
        SpeedSlider:SetValue(75)
        ModeDropdown:SetValue("Fast")

        UI:Notify({
            Title = "Preset",
            Content = "Preset loaded.",
            Type = "success",
            Duration = 4
        })
    end
})


--[[
======================================================================
                         11. BUILT-IN TABS
======================================================================

Home and Settings already exist.
You can still ADD more controls to them.
]]

-- Example: add another label to Home
UI.Home:AddLabel({
    Title = "Loaded",
    Description = "Your script is connected to REM."
})

-- Example: add another button to Settings
UI.Settings:AddButton({
    Title = "About Script",
    Description = "Show information about this script.",
    ButtonText = "Info",

    Callback = function()
        UI:Notify({
            Title = "About",
            Content = "Made using REM UI.",
            Type = "info",
            Duration = 4
        })
    end
})


--[[
======================================================================
                         12. CUSTOM TAB ICON
======================================================================

Instead of "script", "home" or "gear", you can draw your own icon.

Each line is:
    {startX, startY, endX, endY}

The icon uses a 20 x 20 coordinate area.
]]

local Custom = UI:AddTab({
    Title = "Custom",

    Icon = {
        {10, 2, 18, 10},
        {18, 10, 10, 18},
        {10, 18, 2, 10},
        {2, 10, 10, 2}
    }
})

Custom:AddLabel({
    Title = "Custom Icon",
    Description = "This tab uses your own vector icon."
})


--[[
======================================================================
                         13. UI COMMANDS
======================================================================
]]

-- Change theme:
-- UI:SetTheme("Purple")
-- UI:SetTheme("Green")
-- UI:SetTheme("Blue")
-- UI:SetTheme("Black")

-- Change menu keybind using a Windows virtual-key code:
-- UI:SetKeybind(0x2D) -- Insert
-- UI:SetKeybind(0x24) -- Home
-- UI:SetKeybind(0x23) -- End

-- Open/select a tab with code:
-- Main:Select()

-- Remove REM UI:
-- UI:Destroy()

-- Check if REM is still loaded:
-- print(UI.Alive)

-- Check REM version:
-- print(UI.Version)


--[[
======================================================================
                         14. LAYOUT RULES
======================================================================

CONTROLS
--------
Controls appear in the SAME ORDER you add them.

Example:
    Main:AddLabel(...)
    Main:AddToggle(...)
    Main:AddSlider(...)
    Main:AddButton(...)

That is also the order they appear inside the tab.

PAGES
-----
REM fits 4 controls on one page.
If you add more than 4 controls, REM automatically creates page navigation.
You do NOT need to create pages manually.

TABS
----
If there are more than 5 tabs, REM automatically adds sidebar navigation.

ANIMATIONS
----------
Controls made through REM automatically use REM animations.
You do NOT need to write animation code for normal REM controls.

Your own game/script effects are separate.
REM only animates the REM interface itself.

UNLOADING
---------
UI:Destroy() removes REM's drawings, notifications and render connection.

IMPORTANT:
If YOUR script creates loops, events or connections, you should stop or
disconnect those yourself when your script is unloaded.

======================================================================
                         15. QUICK COPY TEMPLATES
======================================================================

Copy only the block you need.
]]

--[[ BUTTON
Main:AddButton({
    Title = "Button",
    Description = "Button description.",
    ButtonText = "Run",
    Callback = function()
        -- your code
    end
})
]]

--[[ TOGGLE
Main:AddToggle({
    Title = "Toggle",
    Description = "Toggle description.",
    Default = false,
    Callback = function(value)
        -- value = true / false
    end
})
]]

--[[ SLIDER
Main:AddSlider({
    Title = "Slider",
    Description = "Slider description.",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,
    Callback = function(value)
        -- value = current number
    end
})
]]

--[[ DROPDOWN
Main:AddDropdown({
    Title = "Dropdown",
    Description = "Dropdown description.",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(value)
        -- value = selected option
    end
})
]]

--[[ LABEL
Main:AddLabel({
    Title = "Title",
    Description = "Description"
})
]]

--[[ NOTIFICATION
UI:Notify({
    Title = "Title",
    Content = "Message",
    Type = "info",
    Duration = 4
})
]]

-- Start the tutorial on the Main tab.
Main:Select()

-- ====================================================================
-- END OF REM UI TUTORIAL
-- ====================================================================
