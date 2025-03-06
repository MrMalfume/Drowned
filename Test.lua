-- Red40 UI Library
-- A sleek, dark-themed UI library with red accents for Roblox

local Red40 = {}
Red40.__index = Red40

-- Utility functions
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Constants
local COLORS = {
    Background = Color3.fromRGB(15, 15, 15),
    DarkBackground = Color3.fromRGB(10, 10, 10),
    LightBackground = Color3.fromRGB(20, 20, 20),
    Primary = Color3.fromRGB(255, 48, 92), -- red accent color
    Secondary = Color3.fromRGB(50, 50, 50),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(200, 200, 200),
    Highlight = Color3.fromRGB(30, 30, 30)
}

local FONTS = {
    Regular = Enum.Font.Gotham,
    Bold = Enum.Font.GothamBold,
    SemiBold = Enum.Font.GothamSemibold
}

-- Create UI elements
function Red40.new(title)
    local self = setmetatable({}, Red40)
    
    -- Main GUI
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Red40UI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Check if CoreGui is accessible
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(self.ScreenGui)
            self.ScreenGui.Parent = game:GetService("CoreGui")
        elseif gethui then
            self.ScreenGui.Parent = gethui()
        else
            self.ScreenGui.Parent = game:GetService("CoreGui")
        end
    end)
    
    if not self.ScreenGui.Parent then
        self.ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, 600, 0, 350)
    self.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
    self.MainFrame.BackgroundColor3 = COLORS.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.ClipsDescendants = true
    self.MainFrame.Parent = self.ScreenGui
    
    -- Add corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.MainFrame
    
    -- Title bar
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, 40)
    self.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    self.TitleBar.BackgroundColor3 = COLORS.DarkBackground
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Parent = self.MainFrame
    
    -- Add corner rounding to title bar
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = self.TitleBar
    
    -- Clip the bottom corners of title bar
    local titleBottomCover = Instance.new("Frame")
    titleBottomCover.Name = "BottomCover"
    titleBottomCover.Size = UDim2.new(1, 0, 0, 10)
    titleBottomCover.Position = UDim2.new(0, 0, 1, -10)
    titleBottomCover.BackgroundColor3 = COLORS.DarkBackground
    titleBottomCover.BorderSizePixel = 0
    titleBottomCover.ZIndex = 0
    titleBottomCover.Parent = self.TitleBar
    
    -- Title text
    self.TitleText = Instance.new("TextLabel")
    self.TitleText.Name = "TitleText"
    self.TitleText.Size = UDim2.new(0, 200, 1, 0)
    self.TitleText.Position = UDim2.new(0, 15, 0, 0)
    self.TitleText.BackgroundTransparency = 1
    self.TitleText.TextColor3 = COLORS.Primary
    self.TitleText.TextSize = 16
    self.TitleText.Font = FONTS.Bold
    self.TitleText.Text = title or "red40"
    self.TitleText.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleText.Parent = self.TitleBar
    
    -- Close button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 40, 0, 40)
    self.CloseButton.Position = UDim2.new(1, -40, 0, 0)
    self.CloseButton.BackgroundTransparency = 1
    self.CloseButton.TextColor3 = COLORS.Text
    self.CloseButton.Text = "✕"
    self.CloseButton.TextSize = 18
    self.CloseButton.Font = FONTS.Regular
    self.CloseButton.Parent = self.TitleBar
    
    -- Sidebar
    self.Sidebar = Instance.new("Frame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.Size = UDim2.new(0, 150, 1, -40)
    self.Sidebar.Position = UDim2.new(0, 0, 0, 40)
    self.Sidebar.BackgroundColor3 = COLORS.DarkBackground
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.Parent = self.MainFrame
    
    -- Content area
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.Size = UDim2.new(1, -150, 1, -40)
    self.ContentArea.Position = UDim2.new(0, 150, 0, 40)
    self.ContentArea.BackgroundColor3 = COLORS.Background
    self.ContentArea.BorderSizePixel = 0
    self.ContentArea.Parent = self.MainFrame
    
    -- Tab container
    self.TabContainer = Instance.new("ScrollingFrame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(1, 0, 1, 0)
    self.TabContainer.BackgroundTransparency = 1
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.ScrollBarThickness = 0
    self.TabContainer.ScrollingEnabled = true
    self.TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.TabContainer.Parent = self.Sidebar
    
    -- Add padding to tab container
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingTop = UDim.new(0, 10)
    tabPadding.Parent = self.TabContainer
    
    -- Content container
    self.ContentContainer = Instance.new("Folder")
    self.ContentContainer.Name = "ContentContainer"
    self.ContentContainer.Parent = self.ContentArea
    
    -- Make the GUI draggable
    self:MakeDraggable(self.TitleBar, self.MainFrame)
    
    -- Close button callback
    self.CloseButton.MouseButton1Click:Connect(function()
        self.ScreenGui:Destroy()
    end)
    
    -- Other variables
    self.Tabs = {}
    self.ActiveTab = nil
    
    -- Search box in title bar
    self.SearchBox = Instance.new("TextBox")
    self.SearchBox.Name = "SearchBox"
    self.SearchBox.Size = UDim2.new(0, 150, 0, 24)
    self.SearchBox.Position = UDim2.new(1, -200, 0.5, -12)
    self.SearchBox.BackgroundColor3 = COLORS.LightBackground
    self.SearchBox.BorderSizePixel = 0
    self.SearchBox.TextColor3 = COLORS.Text
    self.SearchBox.PlaceholderText = "Search"
    self.SearchBox.PlaceholderColor3 = COLORS.SubText
    self.SearchBox.Text = ""
    self.SearchBox.TextSize = 14
    self.SearchBox.Font = FONTS.Regular
    self.SearchBox.Parent = self.TitleBar
    
    -- Add corner rounding to search box
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 4)
    searchCorner.Parent = self.SearchBox
    
    -- Search icon
    local searchIcon = Instance.new("ImageLabel")
    searchIcon.Name = "SearchIcon"
    searchIcon.Size = UDim2.new(0, 16, 0, 16)
    searchIcon.Position = UDim2.new(1, -24, 0.5, -8)
    searchIcon.BackgroundTransparency = 1
    searchIcon.Image = "rbxassetid://3926305904" -- Magnifying glass icon
    searchIcon.ImageRectOffset = Vector2.new(964, 324)
    searchIcon.ImageRectSize = Vector2.new(36, 36)
    searchIcon.ImageColor3 = COLORS.Primary
    searchIcon.Parent = self.SearchBox
    
    return self
end

-- Make a frame draggable
function Red40:MakeDraggable(dragFrame, dragObject)
    local dragging = false
    local dragStart, startPos
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        dragObject.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
    
    dragFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = dragObject.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            updateInput(input)
        end
    end)
end

-- Create a new tab
function Red40:AddTab(name, icon)
    -- Create tab button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name.."Tab"
    tabButton.Size = UDim2.new(1, 0, 0, 36)
    tabButton.BackgroundTransparency = 1
    tabButton.Font = FONTS.Regular
    tabButton.TextSize = 14
    tabButton.TextColor3 = COLORS.Text
    tabButton.Text = ""
    tabButton.Parent = self.TabContainer
    
    -- Tab layout
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.Parent = tabButton
    
    -- Tab padding
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 15)
    tabPadding.Parent = tabButton
    
    -- Tab icon
    local tabIcon
    if icon then
        tabIcon = Instance.new("ImageLabel")
        tabIcon.Name = "Icon"
        tabIcon.Size = UDim2.new(0, 16, 0, 16)
        tabIcon.Position = UDim2.new(0, 0, 0.5, -8)
        tabIcon.BackgroundTransparency = 1
        tabIcon.Image = icon
        tabIcon.ImageColor3 = COLORS.Text
        tabIcon.Parent = tabButton
    end
    
    -- Tab text
    local tabText = Instance.new("TextLabel")
    tabText.Name = "Text"
    tabText.Size = UDim2.new(0, 0, 1, 0)
    tabText.AutomaticSize = Enum.AutomaticSize.X
    tabText.BackgroundTransparency = 1
    tabText.Font = FONTS.Regular
    tabText.TextSize = 14
    tabText.TextColor3 = COLORS.Text
    tabText.Text = name
    tabText.TextXAlignment = Enum.TextXAlignment.Left
    tabText.Parent = tabButton
    
    -- Create tab content
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Name = name.."Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.ScrollBarThickness = 2
    tabContent.ScrollBarImageColor3 = COLORS.Secondary
    tabContent.Visible = false
    tabContent.Parent = self.ContentContainer
    
    -- Add padding to tab content
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingTop = UDim.new(0, 10)
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 10)
    contentPadding.Parent = tabContent
    
    -- Add layout for tab content
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = tabContent
    
    -- Setup automatic canvas sizing
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Tab selection
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(name)
    end)
    
    -- Add tab to tabs
    local tab = {
        Button = tabButton,
        Content = tabContent,
        Name = name,
        Icon = tabIcon,
        Text = tabText,
        Sections = {}
    }
    
    self.Tabs[name] = tab
    
    -- If it's the first tab, select it
    if not self.ActiveTab then
        self:SelectTab(name)
    end
    
    -- Return the tab for chaining
    return tab
end

-- Select a tab
function Red40:SelectTab(name)
    local tab = self.Tabs[name]
    if not tab then return end
    
    -- Hide all tabs
    for _, t in pairs(self.Tabs) do
        t.Content.Visible = false
        t.Button.BackgroundTransparency = 1
        t.Text.TextColor3 = COLORS.Text
        if t.Icon then
            t.Icon.ImageColor3 = COLORS.Text
        end
    end
    
    -- Show selected tab
    tab.Content.Visible = true
    tab.Button.BackgroundColor3 = COLORS.Primary
    tab.Button.BackgroundTransparency = 0.9
    tab.Text.TextColor3 = COLORS.Primary
    if tab.Icon then
        tab.Icon.ImageColor3 = COLORS.Primary
    end
    
    -- Set active tab
    self.ActiveTab = name
    
    -- Add highlight effect
    local highlight = Instance.new("Frame")
    highlight.Name = "SelectedHighlight"
    highlight.Size = UDim2.new(0, 3, 1, 0)
    highlight.Position = UDim2.new(0, 0, 0, 0)
    highlight.BackgroundColor3 = COLORS.Primary
    highlight.BorderSizePixel = 0
    highlight.Parent = tab.Button
    
    -- Remove highlight from other tabs
    for _, t in pairs(self.Tabs) do
        if t.Name ~= name then
            local oldHighlight = t.Button:FindFirstChild("SelectedHighlight")
            if oldHighlight then
                oldHighlight:Destroy()
            end
        end
    end
end

-- Add section to tab
function Red40:AddSection(tabName, sectionName)
    local tab = self.Tabs[tabName]
    if not tab then return end
    
    -- Create section frame
    local section = Instance.new("Frame")
    section.Name = sectionName.."Section"
    section.Size = UDim2.new(1, 0, 0, 0)
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.BackgroundColor3 = COLORS.LightBackground
    section.BorderSizePixel = 0
    section.Parent = tab.Content
    
    -- Add corner rounding
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 6)
    sectionCorner.Parent = section
    
    -- Section header
    local sectionHeader = Instance.new("TextLabel")
    sectionHeader.Name = "Header"
    sectionHeader.Size = UDim2.new(1, 0, 0, 30)
    sectionHeader.BackgroundTransparency = 1
    sectionHeader.Font = FONTS.SemiBold
    sectionHeader.TextSize = 14
    sectionHeader.TextColor3 = COLORS.Text
    sectionHeader.Text = sectionName
    sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
    sectionHeader.Parent = section
    
    -- Add padding to header
    local headerPadding = Instance.new("UIPadding")
    headerPadding.PaddingLeft = UDim.new(0, 10)
    headerPadding.Parent = sectionHeader
    
    -- Section content
    local sectionContent = Instance.new("Frame")
    sectionContent.Name = "Content"
    sectionContent.Size = UDim2.new(1, 0, 0, 0)
    sectionContent.AutomaticSize = Enum.AutomaticSize.Y
    sectionContent.Position = UDim2.new(0, 0, 0, 30)
    sectionContent.BackgroundTransparency = 1
    sectionContent.Parent = section
    
    -- Add padding to section content
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    contentPadding.PaddingBottom = UDim.new(0, 10)
    contentPadding.Parent = sectionContent
    
    -- Add layout for section content
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.Parent = sectionContent
    
    -- Auto-size section based on content
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sectionContent.Size = UDim2.new(1, 0, 0, contentLayout.AbsoluteContentSize.Y)
        section.Size = UDim2.new(1, 0, 0, contentLayout.AbsoluteContentSize.Y + 40)
    end)
    
    -- Save section
    tab.Sections[sectionName] = {
        Frame = section,
        Content = sectionContent,
        Elements = {}
    }
    
    return tab.Sections[sectionName]
end

-- Add toggle
function Red40:AddToggle(tabName, sectionName, toggleName, default, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    local toggleValue = default or false
    
    -- Create toggle frame
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = toggleName.."Toggle"
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = section.Content
    
    -- Toggle layout
    local toggleLayout = Instance.new("UIListLayout")
    toggleLayout.FillDirection = Enum.FillDirection.Horizontal
    toggleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    toggleLayout.SortOrder = Enum.SortOrder.LayoutOrder
    toggleLayout.Padding = UDim.new(0, 10)
    toggleLayout.Parent = toggleFrame
    
    -- Toggle text
    local toggleText = Instance.new("TextLabel")
    toggleText.Name = "Text"
    toggleText.Size = UDim2.new(1, -50, 1, 0)
    toggleText.BackgroundTransparency = 1
    toggleText.Font = FONTS.Regular
    toggleText.TextSize = 14
    toggleText.TextColor3 = COLORS.Text
    toggleText.Text = toggleName
    toggleText.TextXAlignment = Enum.TextXAlignment.Left
    toggleText.Parent = toggleFrame
    
    -- Toggle button background
    local toggleButton = Instance.new("Frame")
    toggleButton.Name = "Button"
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.BackgroundColor3 = toggleValue and COLORS.Primary or COLORS.Secondary
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = toggleFrame
    
    -- Add corner rounding to toggle button
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleButton
    
    -- Toggle circle
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Name = "Circle"
    toggleCircle.Size = UDim2.new(0, 16, 0, 16)
    toggleCircle.Position = UDim2.new(toggleValue and 1 or 0, toggleValue and -18 or 2, 0.5, -8)
    toggleCircle.BackgroundColor3 = COLORS.Text
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleButton
    
    -- Add corner rounding to toggle circle
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = toggleCircle
    
    -- Toggle functionality
    local function updateToggle()
        toggleValue = not toggleValue
        
        -- Animate toggle
        local targetPos = toggleValue and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = toggleValue and COLORS.Primary or COLORS.Secondary
        
        local circleTween = TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = targetPos})
        local colorTween = TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor})
        
        circleTween:Play()
        colorTween:Play()
        
        -- Call callback
        if callback then
            callback(toggleValue)
        end
    end
    
    -- Make button clickable
    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateToggle()
        end
    end)
    
    -- Make text clickable as well
    toggleText.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateToggle()
        end
    end)
    
    -- Listen for input changes in the whole frame
    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateToggle()
        end
    end)
    
    -- Add to section elements
    section.Elements[toggleName] = {
        Type = "Toggle",
        Instance = toggleFrame,
        Value = function() return toggleValue end,
        Set = function(value)
            if value ~= toggleValue then
                updateToggle()
            end
        end
    }
    
    return section.Elements[toggleName]
end

-- Add button
function Red40:AddButton(tabName, sectionName, buttonName, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    -- Create button
    local button = Instance.new("TextButton")
    button.Name = buttonName.."Button"
    button.Size = UDim2.new(1, 0, 0, 32)
    button.BackgroundColor3 = COLORS.Secondary
    button.BorderSizePixel = 0
    button.Font = FONTS.Regular
    button.TextSize = 14
    button.TextColor3 = COLORS.Text
    button.Text = buttonName
    button.AutoButtonColor = false
    button.Parent = section.Content
    
    -- Add corner rounding
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = button
    
    -- Button effects
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Primary}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Secondary}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
    end)
    
    -- Button callback
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    -- Add to section elements
    section.Elements[buttonName] = {
        Type = "Button",
        Instance = button
    }
    
    return section.Elements[buttonName]
end

-- Add slider
function Red40:AddSlider(tabName, sectionName, sliderName, min, max, default, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    min = min or 0
    max = max or 100
    default = math.clamp(default or min, min, max)
    
    -- Create slider frame
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = sliderName.."Slider"
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = section.Content
    
    -- Slider text
    local sliderText = Instance.new("TextLabel")
    sliderText.Name = "Text"
    sliderText.Size = UDim2.new(1, 0, 0, 20)
    sliderText.Position = UDim2.new(0, 0, 0, 0)
    sliderText.BackgroundTransparency = 1
    sliderText.Font = FONTS.Regular
    sliderText.TextSize = 14
    sliderText.TextColor3 = COLORS.Text
    sliderText.Text = sliderName
    sliderText.TextXAlignment = Enum.TextXAlignment.Left
    sliderText.Parent = sliderFrame
    
    -- Slider value text
    local valueText = Instance.new("TextLabel")
    valueText.Name = "Value"
    valueText.Size = UDim2.new(0, 50, 0, 20)
    valueText.Position = UDim2.new(1, -50, 0, 0)
    valueText.BackgroundTransparency = 1
    valueText.Font = FONTS.Regular
    valueText.TextSize = 14
    valueText.TextColor3 = COLORS.Primary
    valueText.Text = tostring(default)
    valueText.TextXAlignment = Enum.TextXAlignment.Right
    valueText.Parent = sliderFrame
    
    -- Slider background
    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "Background"
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.Position = UDim2.new(0, 0, 0, 30)
    sliderBg.BackgroundColor3 = COLORS.Secondary
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = sliderFrame
    
    -- Add corner rounding to slider background
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = sliderBg
    
    -- Slider fill
  -- Red40 UI Library (Continued)

    -- Slider fill
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "Fill"
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.Primary
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    -- Add corner rounding to slider fill
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = sliderFill
    
    -- Slider knob
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Name = "Knob"
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    sliderKnob.BackgroundColor3 = COLORS.Primary
    sliderKnob.BorderSizePixel = 0
    sliderKnob.ZIndex = 2
    sliderKnob.Parent = sliderBg
    
    -- Add corner rounding to slider knob
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = sliderKnob
    
    -- Slider functionality
    local dragging = false
    local value = default
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        value = math.floor(min + ((max - min) * pos))
        
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderKnob.Position = UDim2.new(pos, -8, 0.5, -8)
        valueText.Text = tostring(value)
        
        if callback then
            callback(value)
        end
    end
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    sliderBg.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    -- Add to section elements
    section.Elements[sliderName] = {
        Type = "Slider",
        Instance = sliderFrame,
        Value = function() return value end,
        Set = function(newValue)
            newValue = math.clamp(newValue, min, max)
            value = newValue
            local pos = (value - min) / (max - min)
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            sliderKnob.Position = UDim2.new(pos, -8, 0.5, -8)
            valueText.Text = tostring(value)
            
            if callback then
                callback(value)
            end
        end
    }
    
    return section.Elements[sliderName]
end

-- Add dropdown
function Red40:AddDropdown(tabName, sectionName, dropdownName, options, default, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    options = options or {}
    default = default or options[1] or ""
    
    -- Create dropdown frame
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = dropdownName.."Dropdown"
    dropdownFrame.Size = UDim2.new(1, 0, 0, 60)
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.ClipsDescendants = true
    dropdownFrame.Parent = section.Content
    
    -- Dropdown text
    local dropdownText = Instance.new("TextLabel")
    dropdownText.Name = "Text"
    dropdownText.Size = UDim2.new(1, 0, 0, 20)
    dropdownText.Position = UDim2.new(0, 0, 0, 0)
    dropdownText.BackgroundTransparency = 1
    dropdownText.Font = FONTS.Regular
    dropdownText.TextSize = 14
    dropdownText.TextColor3 = COLORS.Text
    dropdownText.Text = dropdownName
    dropdownText.TextXAlignment = Enum.TextXAlignment.Left
    dropdownText.Parent = dropdownFrame
    
    -- Dropdown button
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "Button"
    dropdownButton.Size = UDim2.new(1, 0, 0, 32)
    dropdownButton.Position = UDim2.new(0, 0, 0, 25)
    dropdownButton.BackgroundColor3 = COLORS.Secondary
    dropdownButton.BorderSizePixel = 0
    dropdownButton.Font = FONTS.Regular
    dropdownButton.TextSize = 14
    dropdownButton.TextColor3 = COLORS.Text
    dropdownButton.Text = default
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    dropdownButton.AutoButtonColor = false
    dropdownButton.Parent = dropdownFrame
    
    -- Dropdown button padding
    local buttonPadding = Instance.new("UIPadding")
    buttonPadding.PaddingLeft = UDim.new(0, 10)
    buttonPadding.Parent = dropdownButton
    
    -- Add corner rounding to dropdown button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = dropdownButton
    
    -- Dropdown arrow
    local dropdownArrow = Instance.new("ImageLabel")
    dropdownArrow.Name = "Arrow"
    dropdownArrow.Size = UDim2.new(0, 16, 0, 16)
    dropdownArrow.Position = UDim2.new(1, -26, 0.5, -8)
    dropdownArrow.BackgroundTransparency = 1
    dropdownArrow.Image = "rbxassetid://6031091004" -- Down arrow
    dropdownArrow.ImageColor3 = COLORS.Text
    dropdownArrow.Parent = dropdownButton
    
    -- Dropdown container
    local dropdownContainer = Instance.new("Frame")
    dropdownContainer.Name = "Container"
    dropdownContainer.Size = UDim2.new(1, 0, 0, 0) -- Will be sized based on options
    dropdownContainer.Position = UDim2.new(0, 0, 0, 60)
    dropdownContainer.BackgroundColor3 = COLORS.LightBackground
    dropdownContainer.BorderSizePixel = 0
    dropdownContainer.Visible = false
    dropdownContainer.ZIndex = 5
    dropdownContainer.Parent = dropdownFrame
    
    -- Add corner rounding to dropdown container
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 4)
    containerCorner.Parent = dropdownContainer
    
    -- Container layout
    local containerLayout = Instance.new("UIListLayout")
    containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    containerLayout.Padding = UDim.new(0, 2)
    containerLayout.Parent = dropdownContainer
    
    -- Current selection
    local selectedOption = default
    local isOpen = false
    
    -- Populate options
    local function populateOptions()
        -- Clear existing options
        for _, child in pairs(dropdownContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        -- Calculate height based on number of options
        local containerHeight = #options * 30 + (#options - 1) * 2
        dropdownContainer.Size = UDim2.new(1, 0, 0, containerHeight)
        
        -- Add options
        for i, option in pairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = option.."Option"
            optionButton.Size = UDim2.new(1, 0, 0, 30)
            optionButton.BackgroundColor3 = COLORS.Secondary
            optionButton.BackgroundTransparency = 0.5
            optionButton.BorderSizePixel = 0
            optionButton.Font = FONTS.Regular
            optionButton.TextSize = 14
            optionButton.TextColor3 = COLORS.Text
            optionButton.Text = option
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.ZIndex = 6
            optionButton.LayoutOrder = i
            optionButton.Parent = dropdownContainer
            
            -- Option button padding
            local optionPadding = Instance.new("UIPadding")
            optionPadding.PaddingLeft = UDim.new(0, 10)
            optionPadding.Parent = optionButton
            
            -- Highlight selected option
            if option == selectedOption then
                optionButton.TextColor3 = COLORS.Primary
            end
            
            -- Option selection
            optionButton.MouseButton1Click:Connect(function()
                selectedOption = option
                dropdownButton.Text = option
                
                -- Toggle dropdown
                isOpen = false
                dropdownContainer.Visible = false
                dropdownArrow.Rotation = 0
                dropdownFrame.Size = UDim2.new(1, 0, 0, 60)
                
                -- Call callback
                if callback then
                    callback(option)
                end
                
                -- Repopulate options to update highlighting
                populateOptions()
            end)
            
            -- Option hover effects
            optionButton.MouseEnter:Connect(function()
                TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
            end)
            
            optionButton.MouseLeave:Connect(function()
                TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
            end)
        end
    end
    
    -- Toggle dropdown
    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        
        -- Show or hide options
        dropdownContainer.Visible = isOpen
        dropdownArrow.Rotation = isOpen and 180 or 0
        
        -- Adjust frame height
        if isOpen then
            local containerHeight = #options * 30 + (#options - 1) * 2
            dropdownFrame.Size = UDim2.new(1, 0, 0, 60 + containerHeight + 5)
        else
            dropdownFrame.Size = UDim2.new(1, 0, 0, 60)
        end
    end)
    
    -- Close dropdown when clicking elsewhere
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
            local mousePos = Vector2.new(input.Position.X, input.Position.Y)
            local dropdownPos = dropdownFrame.AbsolutePosition
            local dropdownSize = dropdownFrame.AbsoluteSize
            
            if mousePos.X < dropdownPos.X or mousePos.X > dropdownPos.X + dropdownSize.X or
               mousePos.Y < dropdownPos.Y or mousePos.Y > dropdownPos.Y + dropdownSize.Y then
                isOpen = false
                dropdownContainer.Visible = false
                dropdownArrow.Rotation = 0
                dropdownFrame.Size = UDim2.new(1, 0, 0, 60)
            end
        end
    end)
    
    -- Button hover effects
    dropdownButton.MouseEnter:Connect(function()
        TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Highlight}):Play()
    end)
    
    dropdownButton.MouseLeave:Connect(function()
        TweenService:Create(dropdownButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Secondary}):Play()
    end)
    
    -- Populate options
    populateOptions()
    
    -- Add to section elements
    section.Elements[dropdownName] = {
        Type = "Dropdown",
        Instance = dropdownFrame,
        Value = function() return selectedOption end,
        Set = function(option)
            if table.find(options, option) then
                selectedOption = option
                dropdownButton.Text = option
                
                -- Call callback
                if callback then
                    callback(option)
                end
                
                -- Repopulate options to update highlighting
                populateOptions()
            end
        end,
        Refresh = function(newOptions, keepSelection)
            options = newOptions or {}
            
            if not keepSelection or not table.find(options, selectedOption) then
                selectedOption = options[1] or ""
                dropdownButton.Text = selectedOption
            end
            
            populateOptions()
            
            -- Call callback if selection changed
            if not keepSelection and callback then
                callback(selectedOption)
            end
        end
    }
    
    return section.Elements[dropdownName]
end

-- Add text box
function Red40:AddTextBox(tabName, sectionName, boxName, placeholder, default, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    placeholder = placeholder or ""
    default = default or ""
    
    -- Create textbox frame
    local boxFrame = Instance.new("Frame")
    boxFrame.Name = boxName.."TextBox"
    boxFrame.Size = UDim2.new(1, 0, 0, 50)
    boxFrame.BackgroundTransparency = 1
    boxFrame.Parent = section.Content
    
    -- Box label
    local boxLabel = Instance.new("TextLabel")
    boxLabel.Name = "Label"
    boxLabel.Size = UDim2.new(1, 0, 0, 20)
    boxLabel.BackgroundTransparency = 1
    boxLabel.Font = FONTS.Regular
    boxLabel.TextSize = 14
    boxLabel.TextColor3 = COLORS.Text
    boxLabel.Text = boxName
    boxLabel.TextXAlignment = Enum.TextXAlignment.Left
    boxLabel.Parent = boxFrame
    
    -- Text box
    local textBox = Instance.new("TextBox")
    textBox.Name = "Input"
    textBox.Size = UDim2.new(1, 0, 0, 30)
    textBox.Position = UDim2.new(0, 0, 0, 20)
    textBox.BackgroundColor3 = COLORS.Secondary
    textBox.BorderSizePixel = 0
    textBox.Font = FONTS.Regular
    textBox.TextSize = 14
    textBox.TextColor3 = COLORS.Text
    textBox.PlaceholderText = placeholder
    textBox.PlaceholderColor3 = COLORS.SubText
    textBox.Text = default
    textBox.ClearTextOnFocus = false
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Parent = boxFrame
    
    -- Add corner rounding to text box
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 4)
    boxCorner.Parent = textBox
    
    -- Add padding to text box
    local boxPadding = Instance.new("UIPadding")
    boxPadding.PaddingLeft = UDim.new(0, 10)
    boxPadding.PaddingRight = UDim.new(0, 10)
    boxPadding.Parent = textBox
    
    -- Text box functionality
    local value = default
    
    textBox.FocusLost:Connect(function(enterPressed)
        value = textBox.Text
        
        if callback then
            callback(value, enterPressed)
        end
    end)
    
    -- Add to section elements
    section.Elements[boxName] = {
        Type = "TextBox",
        Instance = boxFrame,
        Value = function() return value end,
        Set = function(newValue)
            value = newValue
            textBox.Text = newValue
            
            if callback then
                callback(value, false)
            end
        end
    }
    
    return section.Elements[boxName]
end

-- Add label
function Red40:AddLabel(tabName, sectionName, labelText)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    -- Create label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Font = FONTS.Regular
    label.TextSize = 14
    label.TextColor3 = COLORS.Text
    label.Text = labelText
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section.Content
    
    -- Add to section elements
    section.Elements[labelText] = {
        Type = "Label",
        Instance = label,
        Set = function(newText)
            label.Text = newText
        end
    }
    
    return section.Elements[labelText]
end

-- Add color picker
function Red40:AddColorPicker(tabName, sectionName, pickerName, default, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    default = default or Color3.fromRGB(255, 255, 255)
    
    -- Create color picker frame
    local pickerFrame = Instance.new("Frame")
    pickerFrame.Name = pickerName.."ColorPicker"
    pickerFrame.Size = UDim2.new(1, 0, 0, 50)
    pickerFrame.BackgroundTransparency = 1
    pickerFrame.ClipsDescendants = true
    pickerFrame.Parent = section.Content
    
    -- Picker label
    local pickerLabel = Instance.new("TextLabel")
    pickerLabel.Name = "Label"
    pickerLabel.Size = UDim2.new(1, -60, 0, 20)
    pickerLabel.BackgroundTransparency = 1
    pickerLabel.Font = FONTS.Regular
    pickerLabel.TextSize = 14
    pickerLabel.TextColor3 = COLORS.Text
    pickerLabel.Text = pickerName
    pickerLabel.TextXAlignment = Enum.TextXAlignment.Left
    pickerLabel.Parent = pickerFrame
    
    -- Color preview
    local colorPreview = Instance.new("Frame")
    colorPreview.Name = "Preview"
    colorPreview.Size = UDim2.new(0, 50, 0, 20)
    colorPreview.Position = UDim2.new(1, -50, 0, 0)
    colorPreview.BackgroundColor3 = default
    colorPreview.BorderSizePixel = 0
    colorPreview.Parent = pickerFrame
    
    -- Add corner rounding to color preview
    local previewCorner = Instance.new("UICorner")
    previewCorner.CornerRadius = UDim.new(0, 4)
    previewCorner.Parent = colorPreview
    
    -- Color display values
    local colorDisplay = Instance.new("TextLabel")
    colorDisplay.Name = "Display"
    colorDisplay.Size = UDim2.new(1, 0, 0, 20)
    colorDisplay.Position = UDim2.new(0, 0, 0, 25)
    colorDisplay.BackgroundTransparency = 1
    colorDisplay.Font = FONTS.Regular
    colorDisplay.TextSize = 12
    colorDisplay.TextColor3 = COLORS.SubText
    colorDisplay.Text = string.format("RGB: %d, %d, %d", 
        math.floor(default.R * 255), 
        math.floor(default.G * 255), 
        math.floor(default.B * 255))
    colorDisplay.TextXAlignment = Enum.TextXAlignment.Left
    colorDisplay.Parent = pickerFrame
    
    -- Add simple color picker functionality
    local isOpen = false
    local selectedColor = default
    
    -- Update color display
    local function updateColor(color)
        selectedColor = color
        colorPreview.BackgroundColor3 = color
        colorDisplay.Text = string.format("RGB: %d, %d, %d", 
            math.floor(color.R * 255), 
            math.floor(color.G * 255), 
            math.floor(color.B * 255))
        
        if callback then
            callback(color)
        end
    end
    
    -- Create color picker popup
    local pickerPopup = Instance.new("Frame")
    pickerPopup.Name = "Popup"
    pickerPopup.Size = UDim2.new(1, 0, 0, 150)
    pickerPopup.Position = UDim2.new(0, 0, 0, 50)
    pickerPopup.BackgroundColor3 = COLORS.LightBackground
    pickerPopup.BorderSizePixel = 0
    pickerPopup.Visible = false
    pickerPopup.ZIndex = 5
    pickerPopup.Parent = pickerFrame
    
    -- Add corner rounding to popup
    local popupCorner = Instance.new("UICorner")
    popupCorner.CornerRadius = UDim.new(0, 4)
    popupCorner.Parent = pickerPopup
    
    -- Add color palette (simplified version for this example)
    local palette = Instance.new("Frame")
    palette.Name = "Palette"
    palette.Size = UDim2.new(1, -20, 0, 100)
    palette.Position = UDim2.new(0, 10, 0, 10)
    palette.BackgroundColor3 = COLORS.Secondary
    palette.BorderSizePixel = 0
    palette.ZIndex = 6
    palette.Parent = pickerPopup
    
    -- Add corner rounding to palette
    local paletteCorner = Instance.new("UICorner")
    paletteCorner.CornerRadius = UDim.new(0, 4)
    paletteCorner.Parent = palette
    
    -- Generate a simple color grid (for demonstrative purposes)
    local colorGrid = {}
    local colorOptions = {
        Color3.fromRGB(255, 0, 0),   -- Red
        Color3.fromRGB(255, 165, 0), -- Orange
        Color3.fromRGB(255, 255, 0), -- Yellow
        Color3.fromRGB(0, 255, 0),   -- Green
        Color3.fromRGB(0, 0, 255),   -- Blue
        Color3.fromRGB(128, 0, 128), -- Purple
        Color3.fromRGB(255, 192, 203), -- Pink
        Color3.fromRGB(255, 255, 255), -- White
        Color3.fromRGB(0, 0, 0),     -- Black
        Color3.fromRGB(128, 128, 128) -- Gray
    }
    
    for i, color in ipairs(colorOptions) do
        local colorButton = Instance.new("TextButton")
        colorButton.Name = "ColorOption"
        colorButton.Size = UDim2.new(0.2, -4, 0, 30)
        colorButton.Position = UDim2.new(0.2 * ((i-1) % 5), 2, 0, math.floor((i-1) / 5) * 35 + 2)
        colorButton.BackgroundColor3 = color
        colorButton.BorderSizePixel = 0
        colorButton.Text = ""
        colorButton.ZIndex = 7
        colorButton.Parent = palette
        
        -- Add corner rounding
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 4)
        buttonCorner.Parent = colorButton
        
        -- Color selection
        colorButton.MouseButton1Click:Connect(function()
            updateColor(color)
            isOpen = false
            pickerPopup.Visible = false
            pickerFrame.Size = UDim2.new(1, 0, 0, 50)
        end)
        
        table.insert(colorGrid, colorButton)
    end
    
    -- Add button for custom RGB input
    local rgbButton = Instance.new("TextButton")
    rgbButton.Name = "RGBInput"
    rgbButton.Size = UDim2.new(1, -20, 0, 25)
    rgbButton.Position = UDim2.new(0, 10, 0, 115)
    rgbButton.BackgroundColor3 = COLORS.Primary
    rgbButton.BorderSizePixel = 0
    rgbButton.Font = FONTS.Regular
    rgbButton.TextSize = 14
    rgbButton.TextColor3 = COLORS.Text
    rgbButton.Text = "Custom RGB"
    rgbButton.ZIndex = 6
    rgbButton.Parent = pickerPopup
    
    -- Add corner rounding to RGB button
    local rgbCorner = Instance.new("UICorner")
    rgbCorner.CornerRadius = UDim.new(0, 4)
    rgbCorner.Parent = rgbButton
    
    -- Toggle color picker popup
    colorPreview.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isOpen = not isOpen
            
            pickerPopup.Visible = isOpen
            if isOpen then
                pickerFrame.Size = UDim2.new(1, 0, 0, 205)
            else
                pickerFrame.Size = UDim2.new(1, 0, 0, 50)
            end
        end
    end)
    
    -- Close popup when clicking outside
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isOpen then
            local mousePos = Vector2.new(input.Position.X, input.Position.Y)
            local framePos = pickerFrame.AbsolutePosition
            local frameSize = pickerFrame.AbsoluteSize
            
            if mousePos.X < framePos.X or mousePos.X > framePos.X + frameSize.X or
               mousePos.Y < framePos.Y or mousePos.Y > framePos.Y + frameSize.Y then
                isOpen = false
                pickerPopup.Visible = false
                pickerFrame.Size = UDim2.new(1, 0, 0, 50)
            end
        end
    end)
    
    -- Add to section elements
    section.Elements[pickerName] = {
        Type = "ColorPicker",
        Instance = pickerFrame,
        Value = function() return selectedColor end,
        Set = function(color)
            updateColor(color)
        end
    }
    
    return section.Elements[pickerName]
end

-- Add keybind
function Red40:AddKeybind(tabName, sectionName, bindName, default, callback)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    default = default or Enum.KeyCode.Unknown
    
    -- Create keybind frame
    local bindFrame = Instance.new("Frame")
    bindFrame.Name = bindName.."Keybind"
    bindFrame.Size = UDim2.new(1, 0, 0, 30)
    bindFrame.BackgroundTransparency = 1
    bindFrame.Parent = section.Content
    
    -- Keybind layout
    local bindLayout = Instance.new("UIListLayout")
    bindLayout.FillDirection = Enum.FillDirection.Horizontal
    bindLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    bindLayout.SortOrder = Enum.SortOrder.LayoutOrder
    bindLayout.Padding = UDim.new(0, 10)
    bindLayout.Parent = bindFrame
    
    -- Keybind label
    local bindLabel = Instance.new("TextLabel")
    bindLabel.Name = "Label"
    bindLabel.Size = UDim2.new(1, -80, 1, 0)
    bindLabel.BackgroundTransparency = 1
    bindLabel.Font = FONTS.Regular
    bindLabel.TextSize = 14
    bindLabel.TextColor3 = COLORS.Text
    bindLabel.Text = bindName
    bindLabel.TextXAlignment = Enum.TextXAlignment.Left
    bindLabel.LayoutOrder = 1
    bindLabel.Parent = bindFrame
    
    -- Keybind button
    local bindButton = Instance.new("TextButton")
    bindButton.Name = "Button"
    bindButton.Size = UDim2.new(0, 70, 0, 24)
    bindButton.BackgroundColor3 = COLORS.Secondary
    bindButton.BorderSizePixel = 0
    bindButton.Font = FONTS.Regular
    bindButton.TextSize = 12
    bindButton.TextColor3 = COLORS.Text
    bindButton.Text = default ~= Enum.KeyCode.Unknown and default.Name or "None"
    bindButton.LayoutOrder = 2
    bindButton.Parent = bindFrame
    
    -- Add corner rounding to bind button
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = bindButton
    
    -- Keybind functionality
    local currentBind = default
    local isChanging = false
    
    -- Change keybind
    bindButton.MouseButton1Click:Connect(function()
        if isChanging then return end
        
        isChanging = true
        bindButton.Text = "..."
        bindButton.TextColor3 = COLORS.Primary
    end)
    
-- Red40 UI Library (Final Part)

    -- Detect key press
    UserInputService.InputBegan:Connect(function(input)
        if isChanging and input.UserInputType == Enum.UserInputType.Keyboard then
            currentBind = input.KeyCode
            bindButton.Text = input.KeyCode.Name
            bindButton.TextColor3 = COLORS.Text
            isChanging = false
            
            if callback then
                callback(input.KeyCode)
            end
        end
    end)
    
    -- Add to section elements
    section.Elements[bindName] = {
        Type = "Keybind",
        Instance = bindFrame,
        Value = function() return currentBind end,
        Set = function(keycode)
            currentBind = keycode
            bindButton.Text = keycode.Name
            
            if callback then
                callback(keycode)
            end
        end
    }
    
    return section.Elements[bindName]
end

-- Notification system
function Red40:Notify(title, message, duration)
    title = title or "Notification"
    message = message or ""
    duration = duration or 3
    
    -- Create notification
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 250, 0, 0)
    notification.AutomaticSize = Enum.AutomaticSize.Y
    notification.Position = UDim2.new(1, -260, 1, -10)
    notification.AnchorPoint = Vector2.new(0, 1)
    notification.BackgroundColor3 = COLORS.Background
    notification.BorderSizePixel = 0
    notification.Parent = self.ScreenGui
    
    -- Add corner rounding
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 6)
    notifCorner.Parent = notification
    
    -- Add subtle shadow
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 0.6
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BorderSizePixel = 0
    shadow.ZIndex = -1
    shadow.Parent = notification
    
    -- Add corner rounding to shadow
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 10)
    shadowCorner.Parent = shadow
    
    -- Notification header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = COLORS.Primary
    header.BorderSizePixel = 0
    header.Parent = notification
    
    -- Add corner rounding to header (only top corners)
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 6)
    headerCorner.Parent = header
    
    -- Clip the bottom corners of header
    local headerBottomCover = Instance.new("Frame")
    headerBottomCover.Name = "BottomCover"
    headerBottomCover.Size = UDim2.new(1, 0, 0, 10)
    headerBottomCover.Position = UDim2.new(0, 0, 1, -10)
    headerBottomCover.BackgroundColor3 = COLORS.Primary
    headerBottomCover.BorderSizePixel = 0
    headerBottomCover.ZIndex = 0
    headerBottomCover.Parent = header
    
    -- Notification title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = FONTS.SemiBold
    titleLabel.TextSize = 14
    titleLabel.TextColor3 = COLORS.Text
    titleLabel.Text = title
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Font = FONTS.Regular
    closeButton.TextSize = 18
    closeButton.TextColor3 = COLORS.Text
    closeButton.Text = "✕"
    closeButton.Parent = header
    
    -- Notification message
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, 0)
    messageLabel.Position = UDim2.new(0, 10, 0, 30)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Font = FONTS.Regular
    messageLabel.TextSize = 14
    messageLabel.TextColor3 = COLORS.Text
    messageLabel.Text = message
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.AutomaticSize = Enum.AutomaticSize.Y
    messageLabel.Parent = notification
    
    -- Calculate notification height based on message length
    local textSize = game:GetService("TextService"):GetTextSize(
        message, 
        14, 
        FONTS.Regular, 
        Vector2.new(230, math.huge)
    )
    
    -- Add padding to the bottom
    local padding = Instance.new("Frame")
    padding.Name = "Padding"
    padding.Size = UDim2.new(1, 0, 0, 10)
    padding.Position = UDim2.new(0, 0, 0, 30 + textSize.Y)
    padding.BackgroundTransparency = 1
    padding.Parent = notification
    
    -- Animation
    notification.Position = UDim2.new(1, 10, 1, -10)
    notification.BackgroundTransparency = 1
    header.BackgroundTransparency = 1
    headerBottomCover.BackgroundTransparency = 1
    titleLabel.TextTransparency = 1
    closeButton.TextTransparency = 1
    messageLabel.TextTransparency = 1
    shadow.BackgroundTransparency = 1
    
    -- Slide in
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    local positionTween = TweenService:Create(notification, tweenInfo, {
        Position = UDim2.new(1, -260, 1, -10)
    })
    
    local transparencyTween = TweenService:Create(notification, tweenInfo, {
        BackgroundTransparency = 0
    })
    
    local headerTween = TweenService:Create(header, tweenInfo, {
        BackgroundTransparency = 0
    })
    
    local headerCoverTween = TweenService:Create(headerBottomCover, tweenInfo, {
        BackgroundTransparency = 0
    })
    
    local titleTween = TweenService:Create(titleLabel, tweenInfo, {
        TextTransparency = 0
    })
    
    local closeTween = TweenService:Create(closeButton, tweenInfo, {
        TextTransparency = 0
    })
    
    local messageTween = TweenService:Create(messageLabel, tweenInfo, {
        TextTransparency = 0
    })
    
    local shadowTween = TweenService:Create(shadow, tweenInfo, {
        BackgroundTransparency = 0.6
    })
    
    positionTween:Play()
    transparencyTween:Play()
    headerTween:Play()
    headerCoverTween:Play()
    titleTween:Play()
    closeTween:Play()
    messageTween:Play()
    shadowTween:Play()
    
    -- Auto-close after duration
    local autoClose = true
    
    closeButton.MouseButton1Click:Connect(function()
        autoClose = false
        
        -- Fade out
        local fadeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        
        local fadeTween = TweenService:Create(notification, fadeInfo, {
            BackgroundTransparency = 1,
            Position = UDim2.new(1, 10, 1, -10)
        })
        
        local headerFade = TweenService:Create(header, fadeInfo, {
            BackgroundTransparency = 1
        })
        
        local headerCoverFade = TweenService:Create(headerBottomCover, fadeInfo, {
            BackgroundTransparency = 1
        })
        
        local titleFade = TweenService:Create(titleLabel, fadeInfo, {
            TextTransparency = 1
        })
        
        local closeFade = TweenService:Create(closeButton, fadeInfo, {
            TextTransparency = 1
        })
        
        local messageFade = TweenService:Create(messageLabel, fadeInfo, {
            TextTransparency = 1
        })
        
        local shadowFade = TweenService:Create(shadow, fadeInfo, {
            BackgroundTransparency = 1
        })
        
        fadeTween:Play()
        headerFade:Play()
        headerCoverFade:Play()
        titleFade:Play()
        closeFade:Play()
        messageFade:Play()
        shadowFade:Play()
        
        -- Destroy notification after fade
        task.delay(0.2, function()
            notification:Destroy()
        end)
    end)
    
    -- Auto close after duration
    task.delay(duration, function()
        if autoClose and notification and notification.Parent then
            -- Fade out
            local fadeInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            
            local fadeTween = TweenService:Create(notification, fadeInfo, {
                BackgroundTransparency = 1,
                Position = UDim2.new(1, 10, 1, -10)
            })
            
            local headerFade = TweenService:Create(header, fadeInfo, {
                BackgroundTransparency = 1
            })
            
            local headerCoverFade = TweenService:Create(headerBottomCover, fadeInfo, {
                BackgroundTransparency = 1
            })
            
            local titleFade = TweenService:Create(titleLabel, fadeInfo, {
                TextTransparency = 1
            })
            
            local closeFade = TweenService:Create(closeButton, fadeInfo, {
                TextTransparency = 1
            })
            
            local messageFade = TweenService:Create(messageLabel, fadeInfo, {
                TextTransparency = 1
            })
            
            local shadowFade = TweenService:Create(shadow, fadeInfo, {
                BackgroundTransparency = 1
            })
            
            fadeTween:Play()
            headerFade:Play()
            headerCoverFade:Play()
            titleFade:Play()
            closeFade:Play()
            messageFade:Play()
            shadowFade:Play()
            
            -- Destroy notification after fade
            task.delay(0.2, function()
                notification:Destroy()
            end)
        end
    end)
end

-- Add divider
function Red40:AddDivider(tabName, sectionName)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    -- Create divider
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.BackgroundColor3 = COLORS.Secondary
    divider.BorderSizePixel = 0
    divider.Parent = section.Content
    
    return divider
end

-- Toggle library visibility
function Red40:Toggle()
    self.MainFrame.Visible = not self.MainFrame.Visible
end

-- Get element value
function Red40:GetValue(tabName, sectionName, elementName)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return nil end
    
    local element = section.Elements[elementName]
    if not element then return nil end
    
    if element.Value then
        return element.Value()
    else
        return nil
    end
end

-- Set element value
function Red40:SetValue(tabName, sectionName, elementName, value)
    local section = self.Tabs[tabName].Sections[sectionName]
    if not section then return end
    
    local element = section.Elements[elementName]
    if not element or not element.Set then return end
    
    element.Set(value)
end

-- Create a tooltip
function Red40:CreateTooltip(parent, text)
    local tooltip = Instance.new("Frame")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(0, 0, 0, 0)
    tooltip.AutomaticSize = Enum.AutomaticSize.XY
    tooltip.BackgroundColor3 = COLORS.Background
    tooltip.BorderSizePixel = 0
    tooltip.Visible = false
    tooltip.ZIndex = 100
    tooltip.Parent = self.ScreenGui
    
    -- Add corner rounding
    local tooltipCorner = Instance.new("UICorner")
    tooltipCorner.CornerRadius = UDim.new(0, 4)
    tooltipCorner.Parent = tooltip
    
    -- Tooltip text
    local tooltipText = Instance.new("TextLabel")
    tooltipText.Name = "Text"
    tooltipText.Size = UDim2.new(0, 0, 0, 0)
    tooltipText.AutomaticSize = Enum.AutomaticSize.XY
    tooltipText.BackgroundTransparency = 1
    tooltipText.Font = FONTS.Regular
    tooltipText.TextSize = 14
    tooltipText.TextColor3 = COLORS.Text
    tooltipText.Text = text
    tooltipText.Padding = UDim.new(0, 8)
    tooltipText.ZIndex = 101
    tooltipText.Parent = tooltip
    
    -- Add padding
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.Parent = tooltip
    
    -- Show tooltip on hover
    parent.MouseEnter:Connect(function()
        tooltip.Position = UDim2.new(0, Mouse.X + 15, 0, Mouse.Y + 15)
        tooltip.Visible = true
    end)
    
    parent.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)
    
    -- Update position on mouse move
    parent.MouseMoved:Connect(function()
        tooltip.Position = UDim2.new(0, Mouse.X + 15, 0, Mouse.Y + 15)
    end)
    
    return tooltip
end

-- Destroy library
function Red40:Destroy()
    self.ScreenGui:Destroy()
end

-- Return the library
return Red40
