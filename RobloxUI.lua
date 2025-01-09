  local RobloxUI = {}
  local screen = {game:GetService("GuiService"):GetScreenResolution()}
  local activeWindows = {}
  local selectedCategory = nil
  local animations = {}

  -- UI Theme
  local theme = {
      background = {20, 20, 20, 230},
      header = {30, 30, 30, 255},
      accent = {255, 70, 70, 255},
      text = {255, 255, 255, 255},
      border = {40, 40, 40, 255},
      hover = {60, 60, 60, 255}
  }

  -- Animation System
  local function createAnimation(from, to, duration, callback)
      local anim = {
          start = tick(),
          from = from,
          to = to,
          duration = duration,
          callback = callback
      }
      table.insert(animations, anim)
  end

  local function updateAnimations()
      local currentTime = tick()
      for i = #animations, 1, -1 do
          local anim = animations[i]
          local progress = (currentTime - anim.start) / anim.duration
          if progress >= 1 then
              anim.callback(anim.to)
              table.remove(animations, i)
          else
              local value = anim.from + (anim.to - anim.from) * progress
              anim.callback(value)
          end
      end
  end

  -- UI Components
  function RobloxUI.createWindow(title, x, y, width, height)
      local window = {
          title = title,
          x = x or 100,
          y = y or 100,
          width = width or 300,
          height = height or 400,
          visible = true,
          categories = {},
          activeCategory = nil,
          isDragging = false,
          dragOffset = {x = 0, y = 0},
          alpha = 0
      }

      createAnimation(0, 255, 500, function(value)
          window.alpha = value
      end)

      table.insert(activeWindows, window)
      return window
  end

  function RobloxUI.addCategory(window, name)
      local category = {
          name = name,
          elements = {},
          visible = false,
          alpha = 0
      }
      table.insert(window.categories, category)
      return category
  end

  function RobloxUI.addButton(category, text, callback)
      local button = {
          type = "button",
          text = text,
          callback = callback,
          hover = false,
          alpha = 0
      }
      table.insert(category.elements, button)
      return button
  end

  function RobloxUI.addDropdown(category, text, options, default)
      local dropdown = {
          type = "dropdown",
          text = text,
          options = options,
          selected = default or options[1],
          expanded = false,
          hover = false,
          alpha = 0
      }
      table.insert(category.elements, dropdown)
      return dropdown
  end

  function RobloxUI.addToggle(category, text, default)
      local toggle = {
          type = "toggle",
          text = text,
          value = default or false,
          hover = false,
          alpha = 0
      }
      table.insert(category.elements, toggle)
      return toggle
  end

  function RobloxUI.addSlider(category, text, min, max, default, step)
      local slider = {
          type = "slider",
          text = text,
          min = min or 0,
          max = max or 100,
          value = default or min,
          step = step or 1,
          dragging = false,
          hover = false,
          alpha = 0
      }
      table.insert(category.elements, slider)
      return slider
  end

  -- Render System
  local function drawRect(x, y, width, height, color, radius)
      local frame = Instance.new("Frame")
      frame.Size = UDim2.new(0, width, 0, height)
      frame.Position = UDim2.new(0, x, 0, y)
      frame.BackgroundColor3 = Color3.fromRGB(color[1], color[2], color[3])
      frame.BackgroundTransparency = 1 - (color[4] / 255)
      return frame
  end

  local function renderWindow(window)
      if not window.visible then return end
    
      -- Window background
      local background = drawRect(window.x, window.y, window.width, window.height, theme.background)
    
      -- Header
      local header = drawRect(window.x, window.y, window.width, 30, theme.header)
    
      -- Title
      local title = Instance.new("TextLabel")
      title.Size = UDim2.new(0, window.width, 0, 30)
      title.Position = UDim2.new(0, window.x, 0, window.y)
      title.Text = window.title
      title.TextColor3 = Color3.fromRGB(theme.text[1], theme.text[2], theme.text[3])
      title.TextTransparency = 1 - (window.alpha / 255)
      title.TextScaled = true
    
      -- Categories
      local categoryY = window.y + 40
      for _, category in ipairs(window.categories) do
          if category.visible then
              -- Render category elements
              local elementY = categoryY + 30
              for _, element in ipairs(category.elements) do
                  if element.type == "button" then
                      -- Button rendering
                      local color = element.hover and theme.hover or theme.border
                      local button = drawRect(window.x + 10, elementY, window.width - 20, 25, color)
                    
                  elseif element.type == "dropdown" then
                      -- Dropdown rendering
                      local dropdown = drawRect(window.x + 10, elementY, window.width - 20, 25, theme.border)
                      if element.expanded then
                          local dropY = elementY + 30
                          for _, option in ipairs(element.options) do
                              local option_rect = drawRect(window.x + 10, dropY, window.width - 20, 25, theme.background)
                              dropY = dropY + 30
                          end
                      end
                    
                  elseif element.type == "toggle" then
                      -- Toggle rendering
                      local toggle = drawRect(window.x + window.width - 35, elementY, 20, 20, 
                          element.value and theme.accent or theme.border)
                    
                  elseif element.type == "slider" then
                      -- Slider rendering
                      local sliderWidth = window.width - 40
                      local progress = (element.value - element.min) / (element.max - element.min)
                      local sliderBg = drawRect(window.x + 20, elementY + 10, sliderWidth, 2, theme.border)
                      local sliderFg = drawRect(window.x + 20, elementY + 10, sliderWidth * progress, 2, theme.accent)
                  end
                
                  elementY = elementY + 35
              end
          end
          categoryY = categoryY + 30
      end
  end

  -- Main render loop
  game:GetService("RunService").RenderStepped:Connect(function()
      updateAnimations()
      for _, window in ipairs(activeWindows) do
          renderWindow(window)
      end
  end)

  -- Export the library
  return RobloxUI