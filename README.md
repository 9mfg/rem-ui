# REM v5

REM v5 is an animated Lua UI library built for Matcha's Drawing API. It is designed so scripts can add their own tabs, buttons, toggles, sliders, dropdowns, notifications and settings without rebuilding the interface.

## Load REM UI

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/9mfg/rem-ui/main/rem-ui-v5.lua"))()
```

After loading, the library is exposed globally as `Rem`:

```lua
local UI = Rem
```

> REM UI requires the Matcha Drawing API. The library already provides the built-in **Home** and **Settings** tabs, so you do not need to create them yourself.

---

# Quick Start

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/9mfg/rem-ui/main/rem-ui-v5.lua"))()

local UI = Rem

local Main = UI:AddTab({
    Title = "My Script",
    Icon = "script"
})

Main:AddButton({
    Title = "Run Script",
    Description = "Press this to run your feature.",
    ButtonText = "Run",
    Callback = function()
        print("Button pressed!")
    end
})

Main:Select()
```

---

# Full Tutorial Layout

A complete copy-and-paste tutorial is included here:

[`tutorial.lua`](./tutorial.lua)

You can also run the tutorial directly after loading REM UI:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/9mfg/rem-ui/main/rem-ui-v5.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/9mfg/rem-ui/main/tutorial.lua"))()
```

The tutorial demonstrates every main REM control and clearly marks where your own code should go.

---

# Tabs

Create a tab with `UI:AddTab()`:

```lua
local Main = UI:AddTab({
    Title = "Main",
    Icon = "script"
})
```

Built-in icons:

```lua
"script"
"home"
"gear"
```

Home and Settings already exist:

```lua
UI.Home
UI.Settings
```

For example:

```lua
UI.Home:AddLabel({
    Title = "Welcome",
    Description = "Thanks for using REM UI."
})
```

---

# Labels

Labels display information and do not have a callback.

```lua
Main:AddLabel({
    Title = "Information",
    Description = "This is a description."
})
```

---

# Buttons

```lua
Main:AddButton({
    Title = "Run Script",
    Description = "Runs your feature.",
    ButtonText = "Run",

    Callback = function()
        -- YOUR CODE GOES HERE
        print("Running!")
    end
})
```

Anything inside `Callback` runs when the user presses the button.

---

# Toggles

A toggle sends `true` when enabled and `false` when disabled.

```lua
local Toggle = Main:AddToggle({
    Title = "Enabled",
    Description = "Turn the feature on or off.",
    Default = false,

    Callback = function(value)
        if value then
            -- ON CODE
            print("Enabled")
        else
            -- OFF CODE
            print("Disabled")
        end
    end
})
```

Read its current value:

```lua
print(Toggle:GetValue())
```

Change it from code:

```lua
Toggle:SetValue(true)
```

---

# Sliders

```lua
local Speed = Main:AddSlider({
    Title = "Speed",
    Description = "Choose a value.",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,

    Callback = function(value)
        print("Speed:", value)
        -- USE value IN YOUR SCRIPT
    end
})
```

Read or change the value:

```lua
local current = Speed:GetValue()
Speed:SetValue(75)
```

---

# Dropdowns

```lua
local Mode = Main:AddDropdown({
    Title = "Mode",
    Description = "Choose one option.",
    Options = {
        "Soft",
        "Balanced",
        "Strong"
    },
    Default = "Balanced",

    Callback = function(value)
        print("Selected:", value)
        -- value IS THE SELECTED OPTION
    end
})
```

Change the selected option from code:

```lua
Mode:SetValue("Strong")
```

The value must exist inside `Options`.

---

# Notifications

```lua
UI:Notify({
    Title = "Finished",
    Content = "Your action completed.",
    Type = "success",
    Duration = 4
})
```

Available types:

```lua
"info"
"success"
"error"
```

Example error notification:

```lua
UI:Notify({
    Title = "Error",
    Content = "Something went wrong.",
    Type = "error",
    Duration = 5
})
```

For the cleanest layout, keep notification titles around 32 characters or less and content around 48 characters or less.

---

# Using Values Together

You can store controls and read their values later:

```lua
local Enabled = Main:AddToggle({
    Title = "Enabled",
    Default = false
})

local Amount = Main:AddSlider({
    Title = "Amount",
    Min = 0,
    Max = 100,
    Default = 50
})

Main:AddButton({
    Title = "Apply",
    ButtonText = "Apply",

    Callback = function()
        local enabled = Enabled:GetValue()
        local amount = Amount:GetValue()

        print(enabled, amount)
    end
})
```

---

# SetValue

Controls can be updated through your script:

```lua
Toggle:SetValue(true)
Slider:SetValue(75)
Dropdown:SetValue("Strong")
```

By default, changing a value also runs its callback if the value changed.

For a silent UI-only update:

```lua
Toggle:SetValue(true, true)
```

When using a silent update, update your own script state yourself if necessary.

---

# Selecting Tabs

```lua
Main:Select()
```

Selecting a tab displays it and replays its entry animation.

---

# Custom Tab Icons

Custom icons are made from line segments in a `20 x 20` coordinate space.

Each line is:

```lua
{startX, startY, endX, endY}
```

Example diamond icon:

```lua
local Custom = UI:AddTab({
    Title = "Custom",
    Icon = {
        {10,2,18,10},
        {18,10,10,18},
        {10,18,2,10},
        {2,10,10,2}
    }
})
```

---

# Themes

REM currently includes:

```lua
"Purple"
"Green"
"Blue"
"Black"
```

Change the theme from code:

```lua
UI:SetTheme("Blue")
```

The Settings tab also lets the user change the theme through the UI.

---

# Menu Keybind

Set the menu key using a Windows virtual-key code:

```lua
UI:SetKeybind(0x2D)
```

`0x2D` is Insert.

The Settings tab can also record a new keybind directly from the user.

---

# Unloading REM UI

```lua
UI:Destroy()
```

This performs the same UI unload action as **Settings > Unload UI**.

After unloading:

```lua
UI.Alive == false
```

REM removes its own drawings, notifications and render connection. If your script creates separate loops, events or connections, your script is responsible for stopping those itself.

---

# Layout Behavior

REM handles its layout automatically:

- Controls appear in the order they are added.
- Four controls are displayed per page.
- Additional controls automatically create previous/next page navigation.
- More than five tabs automatically creates sidebar navigation.
- Tab and page entry animations replay automatically.
- Control values remain preserved while switching pages or tabs.
- Controls and tabs can be created later while the UI is already running.
- Newly created elements automatically use REM's animations.

---

# API Reference

```lua
UI:AddTab({Title = "Tab", Icon = "script"})

Tab:AddLabel({
    Title = "Label",
    Description = "Description"
})

Tab:AddButton({
    Title = "Button",
    Description = "Description",
    ButtonText = "Run",
    Callback = function() end
})

Tab:AddToggle({
    Title = "Toggle",
    Description = "Description",
    Default = false,
    Callback = function(value) end
})

Tab:AddSlider({
    Title = "Slider",
    Description = "Description",
    Min = 0,
    Max = 100,
    Step = 1,
    Default = 50,
    Callback = function(value) end
})

Tab:AddDropdown({
    Title = "Dropdown",
    Description = "Description",
    Options = {"A", "B", "C"},
    Default = "A",
    Callback = function(value) end
})

Tab:Select()
Control:GetValue()
Control:SetValue(value)
Control:SetValue(value, true)

UI:SetTheme("Purple")
UI:SetKeybind(0x2D)

UI:Notify({
    Title = "Title",
    Content = "Message",
    Type = "info",
    Duration = 4
})

UI:Destroy()
```

---

# Recommended Script Structure

```lua
-- 1. LOAD REM
loadstring(game:HttpGet("https://raw.githubusercontent.com/9mfg/rem-ui/main/rem-ui-v5.lua"))()

-- 2. GET THE UI
local UI = Rem

-- 3. CREATE YOUR TAB
local Main = UI:AddTab({
    Title = "My Script",
    Icon = "script"
})

-- 4. ADD YOUR OPTIONS
local Enabled = Main:AddToggle({
    Title = "Enabled",
    Default = false,
    Callback = function(value)
        -- YOUR TOGGLE CODE
    end
})

local Power = Main:AddSlider({
    Title = "Power",
    Min = 1,
    Max = 100,
    Step = 1,
    Default = 50,
    Callback = function(value)
        -- YOUR SLIDER CODE
    end
})

-- 5. ADD ACTION BUTTONS
Main:AddButton({
    Title = "Run",
    ButtonText = "Start",
    Callback = function()
        print(Enabled:GetValue(), Power:GetValue())
    end
})

-- 6. OPEN YOUR TAB
Main:Select()
```

---

## Files

```text
rem-ui/
├─ rem-ui-v5.lua    # REM v5 UI library
├─ tutorial.lua     # full beginner tutorial / layout example
└─ README.md        # documentation
```

## Version

REM UI v5.0
