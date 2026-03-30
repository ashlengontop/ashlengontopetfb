-- ETFB GUI - Cleaned & Fixed Version
-- Works with ETFB and other games
_G.UserKey = key
_G.Color = Color3.fromRGB(0, 255, 255)
_G.Toggle = Enum.KeyCode.RightControl

-- PlaceId for ETFB - Change to your desired game
local ETFB_PLACE_ID = 131623223084840 -- Change this to your ETFB PlaceId

if game.PlaceId == ETFB_PLACE_ID or game.PlaceId == 10321372166 then
    repeat wait() until game:IsLoaded()
    wait(1)
    
    if game:GetService("CoreGui"):FindFirstChild("AZRAHUB GUI") then
        game:GetService("CoreGui"):FindFirstChild("AZRAHUB GUI"):Destroy()
    end
    
    local DiscordLib = {}
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local HttpService = game:GetService("HttpService")
    local pfp
    local user
    local tag
    local userinfo = {}
    
    pcall(function()
        userinfo = HttpService:JSONDecode(readfile("discordlibinfo.txt"))
    end)
    
    pfp = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
    user = userinfo["user"] or game.Players.LocalPlayer.DisplayName
    tag = userinfo["tag"] or tostring(math.random(0001, 9999))
    
    local function MakeDraggable(topbarobject, object)
        local Dragging = nil
        local DragInput = nil
        local DragStart = nil
        local StartPosition = nil
    
        local function Update(input)
            local Delta = input.Position - DragStart
            local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
            local Tween = TweenService:Create(object, TweenInfo.new(0.15), {Position = pos})
            Tween:Play()
        end
    
        topbarobject.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
    
        topbarobject.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                DragInput = input
            end
        end)
    
        UserInputService.InputChanged:Connect(function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end)
    end
    
    local Discord = Instance.new("ScreenGui")
    Discord.Name = "AZRAHUB GUI"
    Discord.Parent = game:GetService("CoreGui")
    Discord.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    function DiscordLib:Window(text, mainclr, cls)
        local PresetColor = mainclr or _G.Color or Color3.fromRGB(0, 255, 255)
        local CloseBind = cls or _G.Toggle or Enum.KeyCode.RightControl
        local currentservertoggled = ""
        local minimized = false
        local fs = false
        local settingsopened = false
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Parent = Discord
        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        MainFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
        MainFrame.BackgroundTransparency = 1
        MainFrame.BorderSizePixel = 0
        MainFrame.ClipsDescendants = true
        MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrame.Size = UDim2.new(0, 618, 0, 407)
        
        local uitoggled = false
        UserInputService.InputBegan:Connect(function(io, p)
            pcall(function()
                if io.KeyCode == CloseBind then
                    if uitoggled == false then
                        MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        wait(.3)
                        Discord.Enabled = false
                        uitoggled = true
                    else
                        Discord.Enabled = true
                        MainFrame:TweenSize(UDim2.new(0, 618, 0, 407), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        uitoggled = false
                    end
                end
            end)
        end)
        
        local GlowFrame = Instance.new("Frame")
        GlowFrame.Name = "GlowFrame"
        GlowFrame.Parent = MainFrame
        GlowFrame.BackgroundTransparency = 1
        GlowFrame.Position = UDim2.new(0, 0.5, 0, 17.5)
        GlowFrame.Size = UDim2.new(0.625, 0, 0.763, 0)
        GlowFrame.BackgroundColor3 = PresetColor
        
        local GlowFrameCorner = Instance.new("UICorner")
        GlowFrameCorner.CornerRadius = UDim.new(0, 7)
        GlowFrameCorner.Name = "GlowFrameCorner"
        GlowFrameCorner.Parent = GlowFrame
        
        local Glow = Instance.new("ImageLabel")
        Glow.Name = "Glow"
        Glow.Parent = GlowFrame
        Glow.BackgroundColor3 = PresetColor
        Glow.BackgroundTransparency = 1
        Glow.BorderSizePixel = 0
        Glow.Size = UDim2.new(0.625, 0, 0.763, 0)
        Glow.ZIndex = 2
        Glow.Image = "rbxassetid://5028857084"
        Glow.ImageColor3 = PresetColor
        Glow.ScaleType = Enum.ScaleType.Slice
        
        local TopFrame = Instance.new("Frame")
        TopFrame.Name = "TopFrame"
        TopFrame.Parent = MainFrame
        TopFrame.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
        TopFrame.BackgroundTransparency = 1.000
        TopFrame.BorderSizePixel = 0
        TopFrame.Size = UDim2.new(0, 681, 0, 65)
        
        local TopFrameHolder = Instance.new("Frame")
        TopFrameHolder.Name = "TopFrameHolder"
        TopFrameHolder.Parent = TopFrame
        TopFrameHolder.BackgroundColor3 = Color3.fromRGB(32, 34, 37)
        TopFrameHolder.BackgroundTransparency = 1.000
        TopFrameHolder.BorderSizePixel = 0
        TopFrameHolder.Size = UDim2.new(0, 681, 0, 22)
        
        local Title = Instance.new("TextLabel")
        Title.Name = "Title"
        Title.Parent = TopFrame
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.0102790017, 0, 0, 0)
        Title.Size = UDim2.new(0, 192, 0, 23)
        Title.Font = Enum.Font.Gotham
        Title.Text = text
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 13.000
        Title.TextXAlignment = Enum.TextXAlignment.Left
        
        local ServersHolder = Instance.new("Folder")
        ServersHolder.Name = "ServersHolder"
        ServersHolder.Parent = TopFrameHolder
        
        local Userpad = Instance.new("Frame")
        Userpad.Name = "Userpad"
        Userpad.Parent = TopFrameHolder
        Userpad.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Userpad.BackgroundTransparency = 1
        Userpad.BorderSizePixel = 0
        Userpad.Position = UDim2.new(0.0010243297, 0, 15.8807148, 0)
        Userpad.Size = UDim2.new(0, 179, 0, 43)
        
        local UserIcon = Instance.new("Frame")
        UserIcon.Name = "UserIcon"
        UserIcon.Parent = Userpad
        UserIcon.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
        UserIcon.BackgroundTransparency = 1
        UserIcon.BorderSizePixel = 0
        UserIcon.Position = UDim2.new(0.0340000018, 0, 0.123999998, 0)
        UserIcon.Size = UDim2.new(0, 32, 0, 32)
        
        local UserImage = Instance.new("ImageLabel")
        UserImage.Name = "UserImage"
        UserImage.Parent = UserIcon
        UserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserImage.BackgroundTransparency = 1.000
        UserImage.Size = UDim2.new(0, 32, 0, 32)
        UserImage.Image = pfp
        
        local UserCircleImage = Instance.new("ImageLabel")
        UserCircleImage.Name = "UserCircleImage"
        UserCircleImage.Parent = UserImage
        UserCircleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserCircleImage.BackgroundTransparency = 1.000
        UserCircleImage.ImageColor3 = Color3.fromRGB(23, 23, 23)
        UserCircleImage.Size = UDim2.new(0, 32, 0, 32)
        UserCircleImage.Image = "rbxassetid://4031889928"
        UserCircleImage.ImageColor3 = Color3.fromRGB(27, 27, 27)
        
        local UserName = Instance.new("TextLabel")
        UserName.Name = "UserName"
        UserName.Parent = Userpad
        UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserName.BackgroundTransparency = 1.000
        UserName.BorderSizePixel = 0
        UserName.Position = UDim2.new(0.230000004, 0, 0.115999997, 0)
        UserName.Size = UDim2.new(0, 98, 0, 17)
        UserName.Font = Enum.Font.GothamSemibold
        UserName.TextColor3 = PresetColor
        UserName.TextSize = 13.000
        UserName.TextXAlignment = Enum.TextXAlignment.Left
        UserName.ClipsDescendants = true
        UserName.Text = user
        
        local UserTag = Instance.new("TextLabel")
        UserTag.Name = "UserTag"
        UserTag.Parent = Userpad
        UserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        UserTag.BackgroundTransparency = 1.000
        UserTag.BorderSizePixel = 0
        UserTag.Position = UDim2.new(0.230000004, 0, 0.455000013, 0)
        UserTag.Size = UDim2.new(0, 95, 0, 17)
        UserTag.Font = Enum.Font.Gotham
        UserTag.TextColor3 = PresetColor
        UserTag.TextSize = 13.000
        UserTag.TextTransparency = 0.300
        UserTag.TextXAlignment = Enum.TextXAlignment.Left
        UserTag.Text = "#" .. tag
        
        local ServersHoldFrame = Instance.new("Frame")
        ServersHoldFrame.Name = "ServersHoldFrame"
        ServersHoldFrame.Parent = MainFrame
        ServersHoldFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServersHoldFrame.BackgroundTransparency = 1.000
        ServersHoldFrame.BorderColor3 = PresetColor
        ServersHoldFrame.Size = UDim2.new(0, 71, 0, 396)
        
        local ServersHold = Instance.new("ScrollingFrame")
        ServersHold.Name = "ServersHold"
        ServersHold.Parent = ServersHoldFrame
        ServersHold.Active = true
        ServersHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ServersHold.BackgroundTransparency = 1.000
        ServersHold.BorderSizePixel = 0
        ServersHold.Position = UDim2.new(-0.000359333731, 0, 0.0580808073, 0)
        ServersHold.Size = UDim2.new(0, 71, 0, 373)
        ServersHold.ScrollBarThickness = 1
        ServersHold.ScrollBarImageTransparency = 1
        ServersHold.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local ServersHoldLayout = Instance.new("UIListLayout")
        ServersHoldLayout.Name = "ServersHoldLayout"
        ServersHoldLayout.Parent = ServersHold
        ServersHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ServersHoldLayout.Padding = UDim.new(0, 7)
        
        local ServersHoldPadding = Instance.new("UIPadding")
        ServersHoldPadding.Name = "ServersHoldPadding"
        ServersHoldPadding.Parent = ServersHold
        
        MakeDraggable(TopFrame, MainFrame)
        ServersHoldPadding.PaddingLeft = UDim.new(0, 14)
        
        local ServerHold = {}
        
        function ServerHold:Server(text, img)
            local fc = false
            local currentchanneltoggled = ""
            local Server = Instance.new("TextButton")
            local ServerBtnCorner = Instance.new("UICorner")
            local ServerIco = Instance.new("ImageLabel")
            local ServerWhiteFrame = Instance.new("Frame")
            local ServerWhiteFrameCorner = Instance.new("UICorner")
            
            Server.Name = text .. "Server"
            Server.Parent = ServersHold
            Server.BackgroundColor3 = Color3.fromRGB(20,20,20)
            Server.Position = UDim2.new(0.125, 0, 0, 0)
            Server.Size = UDim2.new(0, 47, 0, 47)
            Server.AutoButtonColor = false
            Server.Font = Enum.Font.Gotham
            Server.Text = ""
            Server.BackgroundTransparency = 1
            Server.TextTransparency = 1
            Server.TextColor3 = Color3.fromRGB(233, 25, 42)
            Server.TextSize = 18.000
            
            ServerBtnCorner.CornerRadius = UDim.new(1, 0)
            ServerBtnCorner.Name = "ServerCorner"
            ServerBtnCorner.Parent = Server
            
            ServerWhiteFrame.Name = "ServerWhiteFrame"
            ServerWhiteFrame.Parent = Server
            ServerWhiteFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            ServerWhiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ServerWhiteFrame.BackgroundTransparency = 1
            ServerWhiteFrame.Position = UDim2.new(-0.347378343, 0, 0.502659559, 0)
            ServerWhiteFrame.Size = UDim2.new(0, 11, 0, 10)
            
            ServerWhiteFrameCorner.CornerRadius = UDim.new(1, 0)
            ServerWhiteFrameCorner.Name = "ServerWhiteFrameCorner"
            ServerWhiteFrameCorner.Parent = ServerWhiteFrame
            ServersHold.CanvasSize = UDim2.new(0, 0, 0, ServersHoldLayout.AbsoluteContentSize.Y)
            
            local ServerFrame = Instance.new("Frame")
            local ServerTitleFrame = Instance.new("Frame")
            local ServerTitle = Instance.new("TextLabel")
            local GlowFrame2 = Instance.new("Frame")
            local Glow2 = Instance.new("ImageLabel")
            local ServerContentFrame = Instance.new("Frame")
            local ServerCorner = Instance.new("UICorner")
            local ChannelTitleFrame = Instance.new("Frame")
            local ChannelTitleFrameCorner = Instance.new("UICorner")
            local Hashtag = Instance.new("TextLabel")
            local ChannelTitle = Instance.new("TextLabel")
            local ChannelContentFrame = Instance.new("Frame")
            local ChannelContentFrameCorner = Instance.new("UICorner")
            local GlowChannel = Instance.new("ImageLabel")
            local ServerChannelHolder = Instance.new("ScrollingFrame")
            local ServerChannelHolderLayout = Instance.new("UIListLayout")
            local ServerChannelHolderPadding = Instance.new("UIPadding")
            local ServerTitleButtom = Instance.new("TextLabel")
            local TimeGlobal = Instance.new("TextLabel")

            ServerFrame.Name = "ServerFrame"
            ServerFrame.Parent = ServersHolder
            ServerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ServerFrame.BorderSizePixel = 0
            ServerFrame.ClipsDescendants = true
            ServerFrame.Position = UDim2.new(0.005356875, 0, 0.32262593, 13)
            ServerFrame.Size = UDim2.new(0, 609, 0, 373)
            ServerFrame.Visible = false
            
            ServerTitleFrame.Name = "ServerTitleFrame"
            ServerTitleFrame.Parent = ServerFrame
            ServerTitleFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            ServerTitleFrame.BackgroundTransparency = 1.000
            ServerTitleFrame.BorderSizePixel = 0
            ServerTitleFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
            ServerTitleFrame.Size = UDim2.new(0, 180, 0, 40)
            
            ServerTitle.Name = "ServerTitle"
            ServerTitle.Parent = ServerTitleFrame
            ServerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ServerTitle.BackgroundTransparency = 1.000
            ServerTitle.BorderSizePixel = 0
            ServerTitle.Position = UDim2.new(0.0851359761, 0, 0, 0)
            ServerTitle.Size = UDim2.new(0, 97, 0, 39)
            ServerTitle.Font = Enum.Font.GothamSemibold
            ServerTitle.Text = text
            ServerTitle.TextColor3 = PresetColor
            ServerTitle.TextSize = 15.000
            ServerTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            GlowFrame2.Name = "GlowFrame"
            GlowFrame2.Parent = ServerFrame
            GlowFrame2.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            GlowFrame2.BackgroundTransparency = 1.000
            GlowFrame2.BorderSizePixel = 0
            GlowFrame2.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
            GlowFrame2.Size = UDim2.new(0, 609, 0, 40)
            
            Glow2.Name = "Glow"
            Glow2.Parent = GlowFrame2
            Glow2.BackgroundColor3 = PresetColor
            Glow2.BackgroundTransparency = 1.000
            Glow2.BorderSizePixel = 0
            Glow2.Position = UDim2.new(0, -15, 0, -15)
            Glow2.Size = UDim2.new(1, 30, 1, 30)
            Glow2.ZIndex = 0
            Glow2.Image = "rbxassetid://4996891970"
            Glow2.ImageColor3 = Color3.fromRGB(15, 15, 15)
            Glow2.ScaleType = Enum.ScaleType.Slice
            Glow2.SliceCenter = Rect.new(20, 20, 280, 280)
            
            ServerContentFrame.Name = "ServerContentFrame"
            ServerContentFrame.Parent = ServerFrame
            ServerContentFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
            ServerContentFrame.BackgroundTransparency = 1.000
            ServerContentFrame.BorderSizePixel = 0
            ServerContentFrame.Position = UDim2.new(-0.0010054264, 0, 0.106338218, 0)
            ServerContentFrame.Size = UDim2.new(0, 180, 0, 333)
            
            ServerCorner.CornerRadius = UDim.new(0, 7)
            ServerCorner.Name = "ServerCorner"
            ServerCorner.Parent = ServerFrame
            
            ChannelTitleFrame.Name = "ChannelTitleFrame"
            ChannelTitleFrame.Parent = ServerFrame
            ChannelTitleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ChannelTitleFrame.BorderSizePixel = 0
            ChannelTitleFrame.Position = UDim2.new(0.294561088, 0, -0.000900391256, 0)
            ChannelTitleFrame.Size = UDim2.new(0, 429, 0, 40)
            
            ChannelTitleFrameCorner.CornerRadius = UDim.new(0, 7)
            ChannelTitleFrameCorner.Name = "ChannelTitleFrameCorner"
            ChannelTitleFrameCorner.Parent = ChannelTitleFrame
            
            TimeGlobal.Name = "TimeGlobal"
            TimeGlobal.Parent = ChannelTitleFrame
            TimeGlobal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TimeGlobal.Position = UDim2.new(0.7062470865, 0, 0, 0)
            TimeGlobal.Size = UDim2.new(0, 95, 0, 39)
            TimeGlobal.BackgroundTransparency = 1
            TimeGlobal.ZIndex = 3
            TimeGlobal.Font = Enum.Font.GothamSemibold
            TimeGlobal.Text = "TIME | N/A"
            TimeGlobal.TextColor3 = PresetColor
            TimeGlobal.TextSize = 15.000
            TimeGlobal.TextXAlignment = Enum.TextXAlignment.Left
            
            spawn(function()
                while wait() do
                    TimeGlobal.Text = "TIME | "..os.date("%H")..":"..os.date("%M")..":"..os.date("%S")
                end
            end)
            
            ChannelTitle.Name = "ChannelTitle"
            ChannelTitle.Parent = ChannelTitleFrame
            ChannelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ChannelTitle.BackgroundTransparency = 1.000
            ChannelTitle.BorderSizePixel = 0
            ChannelTitle.Position = UDim2.new(0.0662470865, 0, 0, 0)
            ChannelTitle.Size = UDim2.new(0, 95, 0, 39)
            ChannelTitle.Font = Enum.Font.GothamSemibold
            ChannelTitle.Text = ""
            ChannelTitle.TextColor3 = PresetColor
            ChannelTitle.TextSize = 15.000
            ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            ChannelContentFrame.Name = "ChannelContentFrame"
            ChannelContentFrame.Parent = ServerFrame
            ChannelContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            ChannelContentFrame.BorderSizePixel = 0
            ChannelContentFrame.ClipsDescendants = true
            ChannelContentFrame.Position = UDim2.new(0.294561088, 0, 0.106338218, 0)
            ChannelContentFrame.Size = UDim2.new(0, 429, 0, 333)
            
            ChannelContentFrameCorner.CornerRadius = UDim.new(0, 7)
            ChannelContentFrameCorner.Name = "ChannelContentFrameCorner"
            ChannelContentFrameCorner.Parent = ChannelContentFrame
            
            GlowChannel.Name = "GlowChannel"
            GlowChannel.Parent = ChannelContentFrame
            GlowChannel.BackgroundColor3 = PresetColor
            GlowChannel.BackgroundTransparency = 1.000
            GlowChannel.BorderSizePixel = 0
            GlowChannel.Position = UDim2.new(0, -33, 0, -91)
            GlowChannel.Size = UDim2.new(1.06396091, 30, 0.228228226, 30)
            GlowChannel.ZIndex = 0
            GlowChannel.Image = "rbxassetid://4996891970"
            GlowChannel.ImageColor3 = Color3.fromRGB(15, 15, 15)
            GlowChannel.ScaleType = Enum.ScaleType.Slice
            GlowChannel.SliceCenter = Rect.new(20, 20, 280, 280)
            
            ServerChannelHolder.Name = "ServerChannelHolder"
            ServerChannelHolder.Parent = ServerContentFrame
            ServerChannelHolder.Active = true
            ServerChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ServerChannelHolder.BackgroundTransparency = 1.000
            ServerChannelHolder.BorderSizePixel = 0
            ServerChannelHolder.Position = UDim2.new(0.00535549596, 0, 0.0241984241, 0)
            ServerChannelHolder.Selectable = false
            ServerChannelHolder.Size = UDim2.new(0, 179, 0, 278)
            ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            ServerChannelHolder.ScrollBarThickness = 4
            ServerChannelHolder.ScrollBarImageColor3 = PresetColor
            ServerChannelHolder.ScrollBarImageTransparency = 1
            
            ServerChannelHolderLayout.Name = "ServerChannelHolderLayout"
            ServerChannelHolderLayout.Parent = ServerChannelHolder
            ServerChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ServerChannelHolderLayout.Padding = UDim.new(0, 4)
            
            ServerChannelHolderPadding.Name = "ServerChannelHolderPadding"
            ServerChannelHolderPadding.Parent = ServerChannelHolder
            ServerChannelHolderPadding.PaddingLeft = UDim.new(0, 9)
            
            ServerChannelHolder.MouseEnter:Connect(function()
                ServerChannelHolder.ScrollBarImageTransparency = 0
            end)
            
            ServerChannelHolder.MouseLeave:Connect(function()
                ServerChannelHolder.ScrollBarImageTransparency = 1
            end)
            
            -- Server click/hover effects
            Server.MouseEnter:Connect(function()
                if currentservertoggled ~= Server.Name then
                    TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                    TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {CornerRadius = UDim.new(0, 15)}):Play()
                    ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 27), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                end
            end)
            
            Server.MouseLeave:Connect(function()
                if currentservertoggled ~= Server.Name then
                    TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {BackgroundColor3 = Color3.fromRGB(47, 49, 54)}):Play()
                    TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                        {CornerRadius = UDim.new(1, 0)}):Play()
                    ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                end
            end)
            
            Server.MouseButton1Click:Connect(function()
                currentservertoggled = Server.Name
                for i, v in next, ServersHolder:GetChildren() do
                    if v.Name == "ServerFrame" then
                        v.Visible = false
                    end
                    ServerFrame.Visible = true
                end
                
                for i, v in next, ServersHold:GetChildren() do
                    if v.ClassName == "TextButton" then
                        TweenService:Create(v, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = Color3.fromRGB(47, 49, 54)}):Play()
                        TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                        TweenService:Create(v.ServerCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {CornerRadius = UDim.new(1, 0)}):Play()
                        TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {CornerRadius = UDim.new(0, 15)}):Play()
                        v.ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 10), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 46), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                    end
                end
            end)
            
            if img == "" then
                Server.Text = string.sub(text, 1, 1)
            else
                ServerIco.Image = img
            end
            
            -- Auto-select first server
            if fs == false then
                TweenService:Create(Server, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                    {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                TweenService:Create(ServerBtnCorner, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                    {CornerRadius = UDim.new(0, 15)}):Play()
                ServerWhiteFrame:TweenSize(UDim2.new(0, 11, 0, 46), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                ServerFrame.Visible = true
                Server.Name = text .. "Server"
                currentservertoggled = Server.Name
                fs = true
            end
            
            local ChannelHold = {}
            
            function ChannelHold:Channel(text, ico)
                local Icon = ico or ""
                local ChannelBtnOutline = Instance.new("Frame")
                local ChannelBtnOutlineCorner = Instance.new("UICorner")
                local ChannelBtn = Instance.new("TextButton")
                local ChannelBtnCorner = Instance.new("UICorner")
                local ChannelBtnTitle = Instance.new("TextLabel")
                
                ChannelBtnOutline.Name = text.."ChannelBtn"
                ChannelBtnOutline.Parent = ServerChannelHolder
                ChannelBtnOutline.Position = UDim2.new(0.24118948, 0, 0.578947365, 0)
                ChannelBtnOutline.Size = UDim2.new(0, 162, 0, 32)
                ChannelBtnOutline.BackgroundColor3 = PresetColor
                
                ChannelBtnOutlineCorner.CornerRadius = UDim.new(0, 6)
                ChannelBtnOutlineCorner.Name = "ChannelBtnOutlineCorner"
                ChannelBtnOutlineCorner.Parent = ChannelBtnOutline
                
                ChannelBtn.Name = text .. "ChannelBtn"
                ChannelBtn.Parent = ChannelBtnOutline
                ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                ChannelBtn.BorderSizePixel = 0
                ChannelBtn.Position = UDim2.new(0.002761, 0, 0.02761, 0)
                ChannelBtn.Size = UDim2.new(0, 160, 0, 30)
                ChannelBtn.AutoButtonColor = false
                ChannelBtn.Font = Enum.Font.SourceSans
                ChannelBtn.Text = ""
                ChannelBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                ChannelBtn.TextSize = 14.000
                
                ChannelBtnCorner.CornerRadius = UDim.new(0, 6)
                ChannelBtnCorner.Name = "ChannelBtnCorner"
                ChannelBtnCorner.Parent = ChannelBtn
                
                local ChannelIcon = Instance.new("ImageLabel")
                ChannelIcon.Name = "TabIcon"
                ChannelIcon.Parent = ChannelBtn
                ChannelIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelIcon.BackgroundTransparency = 1.000
                ChannelIcon.Position = UDim2.new(0.0234146333, 0, 0.12, 0)
                ChannelIcon.Size = UDim2.new(0, 20, 0, 20)
                ChannelIcon.Image = Icon
                ChannelIcon.ImageTransparency = 0
                
                ChannelBtnTitle.Name = "ChannelBtnTitle"
                ChannelBtnTitle.Parent = ChannelBtn
                ChannelBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelBtnTitle.BackgroundTransparency = 1.000
                ChannelBtnTitle.BorderSizePixel = 0
                ChannelBtnTitle.Position = UDim2.new(0.163747092, 0, -0.166666672, 0)
                ChannelBtnTitle.Size = UDim2.new(0, 95, 0, 39)
                ChannelBtnTitle.Font = Enum.Font.Gotham
                ChannelBtnTitle.Text = text
                ChannelBtnTitle.TextColor3 = PresetColor
                ChannelBtnTitle.TextSize = 14.000
                ChannelBtnTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ServerChannelHolderLayout.AbsoluteContentSize.Y)
                
                local ChannelHolder = Instance.new("ScrollingFrame")
                local ChannelHolderLayout = Instance.new("UIListLayout")
                
                ChannelHolder.Name = "ChannelHolder"
                ChannelHolder.Parent = ChannelContentFrame
                ChannelHolder.Active = true
                ChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ChannelHolder.BackgroundTransparency = 1.000
                ChannelHolder.BorderSizePixel = 0
                ChannelHolder.Position = UDim2.new(0.0360843192, 0, 0.0241984241, 0)
                ChannelHolder.Size = UDim2.new(0, 412, 0, 314)
                ChannelHolder.ScrollBarThickness = 6
                ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                ChannelHolder.ScrollBarImageTransparency = 0
                ChannelHolder.ScrollBarImageColor3 = PresetColor
                ChannelHolder.Visible = false
                ChannelHolder.ClipsDescendants = false
                
                ChannelHolderLayout.Name = "ChannelHolderLayout"
                ChannelHolderLayout.Parent = ChannelHolder
                ChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                ChannelHolderLayout.Padding = UDim.new(0, 6)

                ChannelBtn.MouseEnter:Connect(function()
                    if currentchanneltoggled ~= ChannelBtn.Name then
                        ChannelBtn.BackgroundColor3 = PresetColor
                        ChannelBtnTitle.TextColor3 = Color3.fromRGB(27, 27, 27)
                    end
                end)
                
                ChannelBtn.MouseLeave:Connect(function()
                    if currentchanneltoggled ~= ChannelBtn.Name then
                        ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                        ChannelBtnTitle.TextColor3 = PresetColor
                    end
                end)
                
                ChannelBtn.MouseButton1Click:Connect(function()
                    for i, v in next, ChannelContentFrame:GetChildren() do
                        if v.Name == "ChannelHolder" then
                            v.Visible = false
                        end
                        ChannelHolder.Visible = true
                    end
                    
                    for i, v in next, ServerChannelHolder:GetChildren() do
                        if v.ClassName == "TextButton" then
                            v.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                            v.ChannelBtnTitle.TextColor3 = PresetColor
                        end
                    end
                    
                    ChannelTitle.Text = text
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                    ChannelBtnTitle.TextColor3 = PresetColor
                    currentchanneltoggled = ChannelBtn.Name
                end)
                
                -- Auto-select first channel
                if fc == false then
                    fc = true
                    ChannelTitle.Text = text
                    ChannelBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                    ChannelBtnTitle.TextColor3 = PresetColor
                    currentchanneltoggled = ChannelBtn.Name
                    ChannelHolder.Visible = true
                end
                
                local ChannelContent = {}
                
                function ChannelContent:Button(text, callback)
                    local Button = Instance.new("TextButton")
                    local ButtonCorner = Instance.new("UICorner")
                    
                    Button.Name = "Button"
                    Button.Parent = ChannelHolder
                    Button.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Button.Size = UDim2.new(0, 401, 0, 30)
                    Button.AutoButtonColor = false
                    Button.Font = Enum.Font.Gotham
                    Button.TextColor3 = PresetColor
                    Button.TextSize = 14.000
                    Button.Text = text
                    
                    ButtonCorner.CornerRadius = UDim.new(0, 4)
                    ButtonCorner.Name = "ButtonCorner"
                    ButtonCorner.Parent = Button
                    
                    Button.MouseEnter:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = PresetColor, TextColor3 = Color3.fromRGB(23, 23, 23)}):Play()
                    end)
                    
                    Button.MouseButton1Click:Connect(function()
                        pcall(callback)
                        Button.TextSize = 0
                        TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {TextSize = 14}):Play()
                    end)
                    
                    Button.MouseLeave:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = Color3.fromRGB(23, 23, 23), TextColor3 = PresetColor}):Play()
                    end)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                function ChannelContent:Toggle(text, default, callback)
                    local toggled = false
                    local Toggle = Instance.new("TextButton")
                    local ToggleTitle = Instance.new("TextLabel")
                    local ToggleFrame = Instance.new("Frame")
                    local ToggleFrameCorner = Instance.new("UICorner")
                    local ToggleFrameCircle = Instance.new("Frame")
                    local ToggleFrameCircleCorner = Instance.new("UICorner")
                    local ToggleFrameOutline = Instance.new("Frame")
                    local ToggleFrameOutlineCorner = Instance.new("UICorner")
                    local Icon = Instance.new("ImageLabel")
                    
                    Toggle.Name = "Toggle"
                    Toggle.Parent = ChannelHolder
                    Toggle.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Toggle.BorderSizePixel = 0
                    Toggle.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                    Toggle.Size = UDim2.new(0, 401, 0, 30)
                    Toggle.AutoButtonColor = false
                    Toggle.Font = Enum.Font.Gotham
                    Toggle.Text = ""
                    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Toggle.TextSize = 14.000
                    
                    ToggleTitle.Name = "ToggleTitle"
                    ToggleTitle.Parent = Toggle
                    ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleTitle.BackgroundTransparency = 1.000
                    ToggleTitle.Position = UDim2.new(0, 5, 0, 0)
                    ToggleTitle.Size = UDim2.new(0, 200, 0, 30)
                    ToggleTitle.Font = Enum.Font.Gotham
                    ToggleTitle.Text = text
                    ToggleTitle.TextColor3 = PresetColor
                    ToggleTitle.TextSize = 14.000
                    ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ToggleFrameOutline.Name = "ToggleFrameOutline"
                    ToggleFrameOutline.Parent = Toggle
                    ToggleFrameOutline.BackgroundColor3 = PresetColor
                    ToggleFrameOutline.Position = UDim2.new(0.900481343, -5, 0.16300018, 0)
                    ToggleFrameOutline.Size = UDim2.new(0, 41, 0, 22)
                    
                    ToggleFrameOutlineCorner.CornerRadius = UDim.new(1, 8)
                    ToggleFrameOutlineCorner.Name = "ToggleFrameOutlineCorner"
                    ToggleFrameOutlineCorner.Parent = ToggleFrameOutline
                    
                    ToggleFrame.Name = "ToggleFrame"
                    ToggleFrame.Parent = ToggleFrameOutline
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
                    ToggleFrame.Size = UDim2.new(0, 39, 0, 20)
                    ToggleFrame.Position = UDim2.new(0, 1, 0.03761, 0)
                    
                    ToggleFrameCorner.CornerRadius = UDim.new(1, 8)
                    ToggleFrameCorner.Name = "ToggleFrameCorner"
                    ToggleFrameCorner.Parent = ToggleFrame
                    
                    ToggleFrameCircle.Name = "ToggleFrameCircle"
                    ToggleFrameCircle.Parent = ToggleFrame
                    ToggleFrameCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleFrameCircle.Position = UDim2.new(0.234999999, -5, 0.133000001, 0)
                    ToggleFrameCircle.Size = UDim2.new(0, 15, 0, 15)
                    
                    ToggleFrameCircleCorner.CornerRadius = UDim.new(1, 0)
                    ToggleFrameCircleCorner.Name = "ToggleFrameCircleCorner"
                    ToggleFrameCircleCorner.Parent = ToggleFrameCircle
                    
                    Icon.Name = "Icon"
                    Icon.Parent = ToggleFrameCircle
                    Icon.AnchorPoint = Vector2.new(0.5, 0.5)
                    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Icon.BackgroundTransparency = 1.000
                    Icon.BorderColor3 = Color3.fromRGB(27, 42, 53)
                    Icon.Position = UDim2.new(0, 8, 0, 8)
                    Icon.Size = UDim2.new(0, 13, 0, 13)
                    Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                    Icon.ImageColor3 = Color3.fromRGB(31, 31, 31)
                    
                    if default == true then
                        toggled = true
                        TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {ImageColor3 = PresetColor}):Play()
                        TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {BackgroundColor3 = PresetColor}):Play()
                        ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), 
                            Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                        TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {ImageTransparency = 1}):Play()
                        Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                        wait(.1)
                        TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                            {ImageTransparency = 0}):Play()
                        pcall(callback, toggled)
                    end
                    
                    Toggle.MouseButton1Click:Connect(function()
                        if toggled == false then
                            TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageColor3 = PresetColor}):Play()
                            TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {BackgroundColor3 = PresetColor}):Play()
                            ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), 
                                Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 1}):Play()
                            Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                            wait(.1)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 0}):Play()
                        else
                            TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageColor3 = Color3.fromRGB(31, 31, 31)}):Play()
                            TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {BackgroundColor3 = Color3.fromRGB(31, 31, 31)}):Play()
                            ToggleFrameCircle:TweenPosition(UDim2.new(0.234999999, -5, 0.133000001, 0), 
                                Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 1}):Play()
                            Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                            wait(.1)
                            TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
                                {ImageTransparency = 0}):Play()
                        end
                        toggled = not toggled
                        pcall(callback, toggled)
                    end)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    
                    local toggleFunc = {}
                    function toggleFunc:Set(value)
                        if value == toggled then return end
                        toggled = value
                        if toggled then
                            TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = PresetColor}):Play()
                            TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = PresetColor}):Play()
                            ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                            Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                        else
                            TweenService:Create(Icon, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(31, 31, 31)}):Play()
                            TweenService:Create(ToggleFrame, TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(31, 31, 31)}):Play()
                            ToggleFrameCircle:TweenPosition(UDim2.new(0.234999999, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                            Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                        end
                        pcall(callback, toggled)
                    end
                    return toggleFunc
                end
                
                function ChannelContent:Slider(text, min, max, start, callback)
                    local SliderFunc = {}
                    local dragging = false
                    local Slider = Instance.new("TextButton")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderFrame = Instance.new("Frame")
                    local SliderFrameCorner = Instance.new("UICorner")
                    local CurrentValueFrame = Instance.new("Frame")
                    local CurrentValueFrameCorner = Instance.new("UICorner")
                    local Zip = Instance.new("Frame")
                    local ZipCorner = Instance.new("UICorner")
                    local ValueBubble = Instance.new("Frame")
                    local ValueBubbleCorner = Instance.new("UICorner")
                    local SquareBubble = Instance.new("Frame")
                    local GlowBubble = Instance.new("ImageLabel")
                    local ValueLabel = Instance.new("TextLabel")
                    
                    Slider.Name = "Slider"
                    Slider.Parent = ChannelHolder
                    Slider.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Slider.BorderSizePixel = 0
                    Slider.Position = UDim2.new(0, 0, 0.216560602, 0)
                    Slider.Size = UDim2.new(0, 401, 0, 38)
                    Slider.AutoButtonColor = false
                    Slider.Font = Enum.Font.Gotham
                    Slider.Text = ""
                    Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Slider.TextSize = 14.000
                    
                    SliderTitle.Name = "SliderTitle"
                    SliderTitle.Parent = Slider
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 5, 0, -4)
                    SliderTitle.Size = UDim2.new(0, 200, 0, 27)
                    SliderTitle.Font = Enum.Font.Gotham
                    SliderTitle.Text = text
                    SliderTitle.TextColor3 = PresetColor
                    SliderTitle.TextSize = 14.000
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = Slider
                    SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(79, 84, 92)
                    SliderFrame.Position = UDim2.new(0.497999996, 0, 0.757000029, 0)
                    SliderFrame.Size = UDim2.new(0, 385, 0, 8)
                    
                    SliderFrameCorner.Name = "SliderFrameCorner"
                    SliderFrameCorner.Parent = SliderFrame
                    
                    CurrentValueFrame.Name = "CurrentValueFrame"
                    CurrentValueFrame.Parent = SliderFrame
                    CurrentValueFrame.BackgroundColor3 = PresetColor
                    CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 8)
                    
                    CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
                    CurrentValueFrameCorner.Parent = CurrentValueFrame
                    
                    Zip.Name = "Zip"
                    Zip.Parent = SliderFrame
                    Zip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Zip.Position = UDim2.new((start or 0) / max, -6, -0.644999981, 0)
                    Zip.Size = UDim2.new(0, 10, 0, 18)
                    ZipCorner.CornerRadius = UDim.new(0, 3)
                    ZipCorner.Name = "ZipCorner"
                    ZipCorner.Parent = Zip
                    
                    ValueBubble.Name = "ValueBubble"
                    ValueBubble.Parent = Zip
                    ValueBubble.AnchorPoint = Vector2.new(0.5, 0.5)
                    ValueBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    ValueBubble.Position = UDim2.new(0.5, 0, -1.00800002, 0)
                    ValueBubble.Size = UDim2.new(0, 36, 0, 21)
                    ValueBubble.Visible = false
                    
                    Zip.MouseEnter:Connect(function()
                        if dragging == false then
                            ValueBubble.Visible = true
                        end
                    end)
                    
                    Zip.MouseLeave:Connect(function()
                        if dragging == false then
                            ValueBubble.Visible = false
                        end
                    end)
                    
                    ValueBubbleCorner.CornerRadius = UDim.new(0, 3)
                    ValueBubbleCorner.Name = "ValueBubbleCorner"
                    ValueBubbleCorner.Parent = ValueBubble
                    
                    SquareBubble.Name = "SquareBubble"
                    SquareBubble.Parent = ValueBubble
                    SquareBubble.AnchorPoint = Vector2.new(0.5, 0.5)
                    SquareBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    SquareBubble.BorderSizePixel = 0
                    SquareBubble.Position = UDim2.new(0.493000001, 0, 0.637999971, 0)
                    SquareBubble.Rotation = 45.000
                    SquareBubble.Size = UDim2.new(0, 19, 0, 19)
                    
                    GlowBubble.Name = "GlowBubble"
                    GlowBubble.Parent = ValueBubble
                    GlowBubble.BackgroundColor3 = PresetColor
                    GlowBubble.BackgroundTransparency = 1.000
                    GlowBubble.BorderSizePixel = 0
                    GlowBubble.Position = UDim2.new(0, -15, 0, -15)
                    GlowBubble.Size = UDim2.new(1, 30, 1, 30)
                    GlowBubble.ZIndex = 0
                    GlowBubble.Image = "rbxassetid://4996891970"
                    GlowBubble.ImageColor3 = Color3.fromRGB(15, 15, 15)
                    GlowBubble.ScaleType = Enum.ScaleType.Slice
                    GlowBubble.SliceCenter = Rect.new(20, 20, 280, 280)
                    
                    ValueLabel.Name = "ValueLabel"
                    ValueLabel.Parent = ValueBubble
                    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ValueLabel.BackgroundTransparency = 1.000
                    ValueLabel.Size = UDim2.new(0, 36, 0, 21)
                    ValueLabel.Font = Enum.Font.Gotham
                    ValueLabel.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
                    ValueLabel.TextColor3 = PresetColor
                    ValueLabel.TextSize = 10.000

                    local function move(input)
                        local pos = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1), -6, -0.644999981, 0)
                        local pos1 = UDim2.new(math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1), 0, 0, 8)
                        CurrentValueFrame.Size = pos1
                        Zip.Position = pos
                        local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                        ValueLabel.Text = tostring(value)
                        pcall(callback, value)
                    end
                    
                    Zip.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                            ValueBubble.Visible = true
                        end
                    end)
                    
                    Zip.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                            ValueBubble.Visible = false
                        end
                    end)
                    
                    game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end)
                    
                    function SliderFunc:Change(tochange)
                        CurrentValueFrame.Size = UDim2.new((tochange or 0) / max, 0, 0, 8)
                        Zip.Position = UDim2.new((tochange or 0) / max, -6, -0.644999981, 0)
                        ValueLabel.Text = tostring(tochange and math.floor((tochange / max) * (max - min) + min) or 0)
                        pcall(callback, tochange)
                    end
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    return SliderFunc
                end
                
                function ChannelContent:Line()
                    local Line1 = Instance.new("Frame")
                    local Line2 = Instance.new("Frame")
                    
                    Line1.Name = "Line1"
                    Line1.Parent = ChannelHolder
                    Line1.BackgroundColor3 = PresetColor
                    Line1.BackgroundTransparency = 1.000
                    Line1.Position = UDim2.new(0, 0, 0.350318581, 0)
                    Line1.Size = UDim2.new(0, 100, 0, 8)
                    
                    Line2.Name = "Line2"
                    Line2.Parent = Line1
                    Line2.BackgroundColor3 = PresetColor
                    Line2.BorderSizePixel = 0
                    Line2.Position = UDim2.new(0, 0, 0, 4)
                    Line2.Size = UDim2.new(0, 401, 0, 1)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                function ChannelContent:Dropdown(text, list, callback)
                    local DropFunc = {}
                    local itemcount = 0
                    local framesize = 0
                    local DropTog = false
                    local Dropdown = Instance.new("Frame")
                    local DropdownTitle = Instance.new("TextLabel")
                    local DropdownFrameOutline = Instance.new("Frame")
                    local DropdownFrameOutlineCorner = Instance.new("UICorner")
                    local DropdownFrame = Instance.new("Frame")
                    local DropdownFrameCorner = Instance.new("UICorner")
                    local CurrentSelectedText = Instance.new("TextLabel")
                    local ArrowImg = Instance.new("ImageLabel")
                    local DropdownFrameBtn = Instance.new("TextButton")
                    
                    Dropdown.Name = "Dropdown"
                    Dropdown.Parent = ChannelHolder
                    Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    Dropdown.BackgroundTransparency = 1.000
                    Dropdown.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
                    Dropdown.Size = UDim2.new(0, 403, 0, 60)
                    
                    DropdownTitle.Name = "DropdownTitle"
                    DropdownTitle.Parent = Dropdown
                    DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownTitle.BackgroundTransparency = 1.000
                    DropdownTitle.Position = UDim2.new(0, 5, 0, 0)
                    DropdownTitle.Size = UDim2.new(0, 200, 0, 29)
                    DropdownTitle.Font = Enum.Font.Gotham
                    DropdownTitle.Text = ""
                    DropdownTitle.TextColor3 = PresetColor
                    DropdownTitle.TextSize = 14.000
                    DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropdownFrameOutline.Name = "DropdownFrameOutline"
                    DropdownFrameOutline.Parent = DropdownTitle
                    DropdownFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
                    DropdownFrameOutline.BackgroundColor3 = PresetColor
                    DropdownFrameOutline.Position = UDim2.new(0.988442957, 0, 1.0197437, 0)
                    DropdownFrameOutline.Size = UDim2.new(0, 396, 0, 36)
                    
                    DropdownFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameOutlineCorner.Name = "DropdownFrameOutlineCorner"
                    DropdownFrameOutlineCorner.Parent = DropdownFrameOutline
                    
                    DropdownFrame.Name = "DropdownFrame"
                    DropdownFrame.Parent = DropdownTitle
                    DropdownFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    DropdownFrame.ClipsDescendants = true
                    DropdownFrame.Position = UDim2.new(0.00899999978, 0, 0.46638527, 0)
                    DropdownFrame.Selectable = true
                    DropdownFrame.Size = UDim2.new(0, 392, 0, 32)
                    
                    DropdownFrameCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameCorner.Name = "DropdownFrameCorner"
                    DropdownFrameCorner.Parent = DropdownFrame
                    
                    CurrentSelectedText.Name = "CurrentSelectedText"
                    CurrentSelectedText.Parent = DropdownFrame
                    CurrentSelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    CurrentSelectedText.BackgroundTransparency = 1.000
                    CurrentSelectedText.Position = UDim2.new(0.0178571437, 0, 0, 0)
                    CurrentSelectedText.Size = UDim2.new(0, 193, 0, 32)
                    CurrentSelectedText.Font = Enum.Font.Gotham
                    CurrentSelectedText.Text = text
                    CurrentSelectedText.TextTransparency = 0.250
                    CurrentSelectedText.TextColor3 = PresetColor
                    CurrentSelectedText.TextSize = 14.000
                    CurrentSelectedText.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ArrowImg.Name = "ArrowImg"
                    ArrowImg.Parent = CurrentSelectedText
                    ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ArrowImg.BackgroundTransparency = 1.000
                    ArrowImg.Position = UDim2.new(1.84974098, 0, 0.167428851, 0)
                    ArrowImg.Size = UDim2.new(0, 22, 0, 22)
                    ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818372"
                    ArrowImg.ImageColor3 = PresetColor
                    
                    DropdownFrameBtn.Name = "DropdownFrameBtn"
                    DropdownFrameBtn.Parent = DropdownFrame
                    DropdownFrameBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownFrameBtn.BackgroundTransparency = 1.000
                    DropdownFrameBtn.Size = UDim2.new(0, 392, 0, 32)
                    DropdownFrameBtn.Font = Enum.Font.SourceSans
                    DropdownFrameBtn.Text = ""
                    DropdownFrameBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                    DropdownFrameBtn.TextSize = 14.000
                    
                    local DropdownFrameMainOutline = Instance.new("Frame")
                    local DropdownFrameMainOutlineCorner = Instance.new("UICorner")
                    local DropdownFrameMain = Instance.new("Frame")
                    local DropdownFrameMainCorner = Instance.new("UICorner")
                    local DropItemHolderLabel = Instance.new("TextLabel")
                    local DropItemHolder = Instance.new("ScrollingFrame")
                    local DropItemHolderLayout = Instance.new("UIListLayout")
                    
                    DropdownFrameMainOutline.Name = "DropdownFrameMainOutline"
                    DropdownFrameMainOutline.Parent = DropdownTitle
                    DropdownFrameMainOutline.BackgroundColor3 = PresetColor
                    DropdownFrameMainOutline.Position = UDim2.new(-0.00155700743, 0, 1.66983342, 0)
                    DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 81)
                    DropdownFrameMainOutline.Visible = false
                    
                    DropdownFrameMainOutlineCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameMainOutlineCorner.Name = "DropdownFrameMainOutlineCorner"
                    DropdownFrameMainOutlineCorner.Parent = DropdownFrameMainOutline
                    
                    DropdownFrameMain.Name = "DropdownFrameMain"
                    DropdownFrameMain.Parent = DropdownTitle
                    DropdownFrameMain.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    DropdownFrameMain.ClipsDescendants = true
                    DropdownFrameMain.Position = UDim2.new(0.00799999978, 0, 1.7468965, 0)
                    DropdownFrameMain.Selectable = true
                    DropdownFrameMain.Size = UDim2.new(0, 392, 0, 77)
                    DropdownFrameMain.Visible = false
                    
                    DropdownFrameMainCorner.CornerRadius = UDim.new(0, 3)
                    DropdownFrameMainCorner.Name = "DropdownFrameMainCorner"
                    DropdownFrameMainCorner.Parent = DropdownFrameMain
                    
                    DropItemHolderLabel.Name = "ItemHolderLabel"
                    DropItemHolderLabel.Parent = DropdownFrameMain
                    DropItemHolderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropItemHolderLabel.BackgroundTransparency = 1.000
                    DropItemHolderLabel.Position = UDim2.new(0.0178571437, 0, 0, 0)
                    DropItemHolderLabel.Size = UDim2.new(0, 193, 0, 13)
                    DropItemHolderLabel.Font = Enum.Font.Gotham
                    DropItemHolderLabel.Text = ""
                    DropItemHolderLabel.TextColor3 = PresetColor
                    DropItemHolderLabel.TextSize = 14.000
                    DropItemHolderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    DropItemHolder.Name = "ItemHolder"
                    DropItemHolder.Parent = DropItemHolderLabel
                    DropItemHolder.Active = true
                    DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropItemHolder.BackgroundTransparency = 1.000
                    DropItemHolder.Position = UDim2.new(0, 0, 0.215384638, 0)
                    DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
                    DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                    DropItemHolder.ScrollBarThickness = 6
                    DropItemHolder.BorderSizePixel = 0
                    DropItemHolder.ScrollBarImageColor3 = PresetColor
                    
                    DropItemHolderLayout.Name = "ItemHolderLayout"
                    DropItemHolderLayout.Parent = DropItemHolder
                    DropItemHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropItemHolderLayout.Padding = UDim.new(0, 0)
                    
                    DropdownFrameBtn.MouseButton1Click:Connect(function()
                        if DropTog == false then
                            DropdownFrameMain.Visible = true
                            DropdownFrameMainOutline.Visible = true
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60 + DropdownFrameMainOutline.AbsoluteSize.Y)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                        else
                            DropdownFrameMain.Visible = false
                            DropdownFrameMainOutline.Visible = false
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                            wait(.2)
                        end
                        DropTog = not DropTog
                    end)
                    
                    for i, v in next, list do
                        itemcount = itemcount + 1
                        if itemcount == 1 then
                            framesize = 29
                        elseif itemcount == 2 then
                            framesize = 58
                        elseif itemcount >= 3 then
                            framesize = 87
                        end
                        
                        local Item = Instance.new("TextButton")
                        local ItemCorner = Instance.new("UICorner")
                        local ItemText = Instance.new("TextLabel")
                        
                        Item.Name = "Item"
                        Item.Parent = DropItemHolder
                        Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        Item.Size = UDim2.new(0, 379, 0, 29)
                        Item.AutoButtonColor = false
                        Item.Font = Enum.Font.SourceSans
                        Item.Text = ""
                        Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                        Item.TextSize = 14.000
                        Item.BackgroundTransparency = 1
                        
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Name = "ItemCorner"
                        ItemCorner.Parent = Item
                        
                        ItemText.Name = "ItemText"
                        ItemText.Parent = Item
                        ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        ItemText.BackgroundTransparency = 1.000
                        ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
                        ItemText.Size = UDim2.new(0, 192, 0, 29)
                        ItemText.Font = Enum.Font.Gotham
                        ItemText.TextColor3 = PresetColor
                        ItemText.TextSize = 14.000
                        ItemText.TextXAlignment = Enum.TextXAlignment.Left
                        ItemText.Text = v
                        
                        Item.MouseEnter:Connect(function()
                            ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BackgroundTransparency = 0
                        end)
                        
                        Item.MouseLeave:Connect(function()
                            ItemText.TextColor3 = PresetColor
                            Item.BackgroundTransparency = 1
                        end)
                        
                        Item.MouseButton1Click:Connect(function()
                            CurrentSelectedText.Text = v
                            CurrentSelectedText.TextTransparency = 0.250
                            pcall(callback, v)
                            DropdownFrameMain.Visible = false
                            DropdownFrameMainOutline.Visible = false
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                            wait(.2)
                            DropTog = not DropTog
                        end)
                        
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropItemHolderLayout.AbsoluteContentSize.Y)
                        DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
                        DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
                        DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
                    end
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    
                    function DropFunc:Clear()
                        for i, v in next, DropItemHolder:GetChildren() do
                            if v.Name == "Item" then
                                v:Destroy()
                            end
                        end
                        CurrentSelectedText.Text = text
                        CurrentSelectedText.TextTransparency = 0.250
                        itemcount = 0
                        framesize = 0
                        DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
                        DropdownFrameMain.Size = UDim2.new(0, 392, 0, 0)
                        DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 0)
                        Dropdown.Size = UDim2.new(0, 403, 0, 60)
                        DropdownFrameMain.Visible = false
                        DropdownFrameMainOutline.Visible = false
                        ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    end
                    
                    -- CONTINUATION (Part 5)

                    function DropFunc:Add(textadd)
                        itemcount = itemcount + 1
                        if itemcount == 1 then
                            framesize = 29
                        elseif itemcount == 2 then
                            framesize = 58
                        elseif itemcount >= 3 then
                            framesize = 87
                        end
                        
                        local Item = Instance.new("TextButton")
                        local ItemCorner = Instance.new("UICorner")
                        local ItemText = Instance.new("TextLabel")
                        
                        Item.Name = "Item"
                        Item.Parent = DropItemHolder
                        Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        Item.Size = UDim2.new(0, 379, 0, 29)
                        Item.AutoButtonColor = false
                        Item.Font = Enum.Font.SourceSans
                        Item.Text = ""
                        Item.TextColor3 = Color3.fromRGB(0, 0, 0)
                        Item.TextSize = 14.000
                        Item.BackgroundTransparency = 1
                        
                        ItemCorner.CornerRadius = UDim.new(0, 4)
                        ItemCorner.Name = "ItemCorner"
                        ItemCorner.Parent = Item
                        
                        ItemText.Name = "ItemText"
                        ItemText.Parent = Item
                        ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
                        ItemText.BackgroundTransparency = 1.000
                        ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
                        ItemText.Size = UDim2.new(0, 192, 0, 29)
                        ItemText.Font = Enum.Font.Gotham
                        ItemText.TextColor3 = PresetColor
                        ItemText.TextSize = 14.000
                        ItemText.TextXAlignment = Enum.TextXAlignment.Left
                        ItemText.Text = textadd
                        
                        Item.MouseEnter:Connect(function()
                            ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
                            Item.BackgroundTransparency = 0
                        end)
                        
                        Item.MouseLeave:Connect(function()
                            ItemText.TextColor3 = PresetColor
                            Item.BackgroundTransparency = 1
                        end)
                        
                        Item.MouseButton1Click:Connect(function()
                            CurrentSelectedText.Text = textadd
                            CurrentSelectedText.TextTransparency = 0.250
                            pcall(callback, textadd)
                            DropdownFrameMain.Visible = false
                            DropdownFrameMainOutline.Visible = false
                            TweenService:Create(Dropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {Size = UDim2.new(0, 403, 0, 60)}):Play()
                            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
                            wait(.2)
                            DropTog = not DropTog
                        end)
                        
                        DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropItemHolderLayout.AbsoluteContentSize.Y)
                        DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
                        DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
                        DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
                    end
                    
                    return DropFunc
                end

    function ChannelContent:MultiDropdown(text, list, callback)
    local multiSelect = {}
    local selectedItems = {}
    local DropTog = false
    local itemcount = 0
    
    local MultiDropdown = Instance.new("Frame")
    local MultiDropdownTitle = Instance.new("TextLabel")
    local MultiDropdownFrameOutline = Instance.new("Frame")
    local MultiDropdownFrameOutlineCorner = Instance.new("UICorner")
    local MultiDropdownFrame = Instance.new("Frame")
    local MultiDropdownFrameCorner = Instance.new("UICorner")
    local CurrentSelectedText = Instance.new("TextLabel")
    local ArrowImg = Instance.new("ImageLabel")
    local MultiDropdownFrameBtn = Instance.new("TextButton")
    
    MultiDropdown.Name = "MultiDropdown"
    MultiDropdown.Parent = ChannelHolder
    MultiDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropdown.BackgroundTransparency = 1.000
    MultiDropdown.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
    MultiDropdown.Size = UDim2.new(0, 403, 0, 60)
    
    MultiDropdownTitle.Name = "MultiDropdownTitle"
    MultiDropdownTitle.Parent = MultiDropdown
    MultiDropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropdownTitle.BackgroundTransparency = 1.000
    MultiDropdownTitle.Position = UDim2.new(0, 5, 0, 0)
    MultiDropdownTitle.Size = UDim2.new(0, 200, 0, 29)
    MultiDropdownTitle.Font = Enum.Font.Gotham
    MultiDropdownTitle.Text = ""
    MultiDropdownTitle.TextColor3 = PresetColor
    MultiDropdownTitle.TextSize = 14.000
    MultiDropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    MultiDropdownFrameOutline.Name = "MultiDropdownFrameOutline"
    MultiDropdownFrameOutline.Parent = MultiDropdownTitle
    MultiDropdownFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
    MultiDropdownFrameOutline.BackgroundColor3 = PresetColor
    MultiDropdownFrameOutline.Position = UDim2.new(0.988442957, 0, 1.0197437, 0)
    MultiDropdownFrameOutline.Size = UDim2.new(0, 396, 0, 36)
    
    MultiDropdownFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameOutlineCorner.Name = "MultiDropdownFrameOutlineCorner"
    MultiDropdownFrameOutlineCorner.Parent = MultiDropdownFrameOutline
    
    MultiDropdownFrame.Name = "MultiDropdownFrame"
    MultiDropdownFrame.Parent = MultiDropdownTitle
    MultiDropdownFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    MultiDropdownFrame.ClipsDescendants = true
    MultiDropdownFrame.Position = UDim2.new(0.00899999978, 0, 0.46638527, 0)
    MultiDropdownFrame.Selectable = true
    MultiDropdownFrame.Size = UDim2.new(0, 392, 0, 32)
    
    MultiDropdownFrameCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameCorner.Name = "MultiDropdownFrameCorner"
    MultiDropdownFrameCorner.Parent = MultiDropdownFrame
    
    CurrentSelectedText.Name = "CurrentSelectedText"
    CurrentSelectedText.Parent = MultiDropdownFrame
    CurrentSelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CurrentSelectedText.BackgroundTransparency = 1.000
    CurrentSelectedText.Position = UDim2.new(0.0178571437, 0, 0, 0)
    CurrentSelectedText.Size = UDim2.new(0, 300, 0, 32)
    CurrentSelectedText.Font = Enum.Font.Gotham
    CurrentSelectedText.Text = text .. " (0 selected)"
    CurrentSelectedText.TextTransparency = 0.250
    CurrentSelectedText.TextColor3 = PresetColor
    CurrentSelectedText.TextSize = 14.000
    CurrentSelectedText.TextXAlignment = Enum.TextXAlignment.Left
    
    ArrowImg.Name = "ArrowImg"
    ArrowImg.Parent = CurrentSelectedText
    ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ArrowImg.BackgroundTransparency = 1.000
    ArrowImg.Position = UDim2.new(1.1, 0, 0.167, 0)
    ArrowImg.Size = UDim2.new(0, 22, 0, 22)
    ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818372"
    ArrowImg.ImageColor3 = PresetColor
    
    MultiDropdownFrameBtn.Name = "MultiDropdownFrameBtn"
    MultiDropdownFrameBtn.Parent = MultiDropdownFrame
    MultiDropdownFrameBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropdownFrameBtn.BackgroundTransparency = 1.000
    MultiDropdownFrameBtn.Size = UDim2.new(0, 392, 0, 32)
    MultiDropdownFrameBtn.Font = Enum.Font.SourceSans
    MultiDropdownFrameBtn.Text = ""
    MultiDropdownFrameBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MultiDropdownFrameBtn.TextSize = 14.000
    
    local MultiDropdownFrameMainOutline = Instance.new("Frame")
    local MultiDropdownFrameMainOutlineCorner = Instance.new("UICorner")
    local MultiDropdownFrameMain = Instance.new("Frame")
    local MultiDropdownFrameMainCorner = Instance.new("UICorner")
    local MultiDropItemHolderLabel = Instance.new("TextLabel")
    local MultiDropItemHolder = Instance.new("ScrollingFrame")
    local MultiDropItemHolderLayout = Instance.new("UIListLayout")
    
    MultiDropdownFrameMainOutline.Name = "MultiDropdownFrameMainOutline"
    MultiDropdownFrameMainOutline.Parent = MultiDropdownTitle
    MultiDropdownFrameMainOutline.BackgroundColor3 = PresetColor
    MultiDropdownFrameMainOutline.Position = UDim2.new(-0.00155700743, 0, 1.66983342, 0)
    MultiDropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 0)
    MultiDropdownFrameMainOutline.Visible = false
    
    MultiDropdownFrameMainOutlineCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameMainOutlineCorner.Name = "MultiDropdownFrameMainOutlineCorner"
    MultiDropdownFrameMainOutlineCorner.Parent = MultiDropdownFrameMainOutline
    
    MultiDropdownFrameMain.Name = "MultiDropdownFrameMain"
    MultiDropdownFrameMain.Parent = MultiDropdownTitle
    MultiDropdownFrameMain.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    MultiDropdownFrameMain.ClipsDescendants = true
    MultiDropdownFrameMain.Position = UDim2.new(0.00799999978, 0, 1.7468965, 0)
    MultiDropdownFrameMain.Selectable = true
    MultiDropdownFrameMain.Size = UDim2.new(0, 392, 0, 0)
    MultiDropdownFrameMain.Visible = false
    
    MultiDropdownFrameMainCorner.CornerRadius = UDim.new(0, 3)
    MultiDropdownFrameMainCorner.Name = "MultiDropdownFrameMainCorner"
    MultiDropdownFrameMainCorner.Parent = MultiDropdownFrameMain
    
    MultiDropItemHolderLabel.Name = "ItemHolderLabel"
    MultiDropItemHolderLabel.Parent = MultiDropdownFrameMain
    MultiDropItemHolderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropItemHolderLabel.BackgroundTransparency = 1.000
    MultiDropItemHolderLabel.Position = UDim2.new(0.0178571437, 0, 0, 0)
    MultiDropItemHolderLabel.Size = UDim2.new(0, 193, 0, 13)
    MultiDropItemHolderLabel.Font = Enum.Font.Gotham
    MultiDropItemHolderLabel.Text = ""
    MultiDropItemHolderLabel.TextColor3 = PresetColor
    MultiDropItemHolderLabel.TextSize = 14.000
    MultiDropItemHolderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    MultiDropItemHolder.Name = "ItemHolder"
    MultiDropItemHolder.Parent = MultiDropItemHolderLabel
    MultiDropItemHolder.Active = true
    MultiDropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MultiDropItemHolder.BackgroundTransparency = 1.000
    MultiDropItemHolder.Position = UDim2.new(0, 0, 0.215384638, 0)
    MultiDropItemHolder.Size = UDim2.new(0, 385, 0, 0)
    MultiDropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    MultiDropItemHolder.ScrollBarThickness = 6
    MultiDropItemHolder.BorderSizePixel = 0
    MultiDropItemHolder.ScrollBarImageColor3 = PresetColor
    
    MultiDropItemHolderLayout.Name = "ItemHolderLayout"
    MultiDropItemHolderLayout.Parent = MultiDropItemHolder
    MultiDropItemHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    MultiDropItemHolderLayout.Padding = UDim.new(0, 0)
    
    local function updateSelectedText()
        local count = 0
        local textDisplay = ""
        for item, isSelected in pairs(selectedItems) do
            if isSelected then
                count = count + 1
                if textDisplay == "" then
                    textDisplay = item
                elseif count <= 2 then
                    textDisplay = textDisplay .. ", " .. item
                end
            end
        end
        
        if count == 0 then
            CurrentSelectedText.Text = text .. " (0 selected)"
            CurrentSelectedText.TextTransparency = 0.250
        elseif count == 1 then
            CurrentSelectedText.Text = textDisplay .. " (1 selected)"
            CurrentSelectedText.TextTransparency = 0
        elseif count <= 3 then
            CurrentSelectedText.Text = textDisplay .. " (+" .. (count - 2) .. ") (" .. count .. " selected)"
            CurrentSelectedText.TextTransparency = 0
        else
            CurrentSelectedText.Text = textDisplay .. " (+" .. (count - 2) .. ") (" .. count .. " selected)"
            CurrentSelectedText.TextTransparency = 0
        end
        
        local selectedTable = {}
        for item, isSelected in pairs(selectedItems) do
            if isSelected then
                table.insert(selectedTable, item)
            end
        end
        pcall(callback, selectedTable)
    end
    
    MultiDropdownFrameBtn.MouseButton1Click:Connect(function()
        if DropTog == false then
            MultiDropdownFrameMain.Visible = true
            MultiDropdownFrameMainOutline.Visible = true
            TweenService:Create(MultiDropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {Size = UDim2.new(0, 403, 0, 60 + MultiDropdownFrameMainOutline.AbsoluteSize.Y)}):Play()
            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
        else
            MultiDropdownFrameMain.Visible = false
            MultiDropdownFrameMainOutline.Visible = false
            TweenService:Create(MultiDropdown, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {Size = UDim2.new(0, 403, 0, 60)}):Play()
            TweenService:Create(ChannelHolder, TweenInfo.new(.5, Enum.EasingStyle.Quart),
                {CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)}):Play()
            wait(.2)
        end
        DropTog = not DropTog
    end)
    
    for i, v in next, list do
        itemcount = itemcount + 1
        local framesize = 29 + (itemcount - 1) * 29
        
        local Item = Instance.new("TextButton")
        local ItemCorner = Instance.new("UICorner")
        local ItemText = Instance.new("TextLabel")
        local Checkbox = Instance.new("Frame")  -- Checkbox on RIGHT side
        local CheckboxCorner = Instance.new("UICorner")
        local Checkmark = Instance.new("ImageLabel")
        
        Item.Name = "Item"
        Item.Parent = MultiDropItemHolder
        Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
        Item.Size = UDim2.new(0, 379, 0, 29)
        Item.AutoButtonColor = false
        Item.Font = Enum.Font.SourceSans
        Item.Text = ""
        Item.TextColor3 = Color3.fromRGB(0, 0, 0)
        Item.TextSize = 14.000
        Item.BackgroundTransparency = 1
        
        ItemCorner.CornerRadius = UDim.new(0, 4)
        ItemCorner.Name = "ItemCorner"
        ItemCorner.Parent = Item
        
        -- Item text on LEFT
        ItemText.Name = "ItemText"
        ItemText.Parent = Item
        ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
        ItemText.BackgroundTransparency = 1.000
        ItemText.Position = UDim2.new(0.02, 0, 0, 0)
        ItemText.Size = UDim2.new(0, 270, 0, 29)
        ItemText.Font = Enum.Font.Gotham
        ItemText.TextColor3 = PresetColor
        ItemText.TextSize = 14.000
        ItemText.TextXAlignment = Enum.TextXAlignment.Left
        ItemText.Text = v
        
        -- Checkbox on RIGHT side
        Checkbox.Name = "Checkbox"
        Checkbox.Parent = Item
        Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Checkbox.BorderSizePixel = 0
        Checkbox.Position = UDim2.new(0.78, 0, 0.17, 0)
        Checkbox.Size = UDim2.new(0, 20, 0, 20)
        
        CheckboxCorner.CornerRadius = UDim.new(0, 4)
        CheckboxCorner.Name = "CheckboxCorner"
        CheckboxCorner.Parent = Checkbox
        
        -- Checkmark inside checkbox (hidden by default)
        Checkmark.Name = "Checkmark"
        Checkmark.Parent = Checkbox
        Checkmark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Checkmark.BackgroundTransparency = 1.000
        Checkmark.Position = UDim2.new(0.15, 0, 0.15, 0)
        Checkmark.Size = UDim2.new(0, 14, 0, 14)
        Checkmark.Image = "http://www.roblox.com/asset/?id=6023426926" -- Checkmark
        Checkmark.ImageTransparency = 1
        Checkmark.ImageColor3 = PresetColor
        
        selectedItems[v] = false
        
        Item.MouseEnter:Connect(function()
            ItemText.TextColor3 = Color3.fromRGB(255, 255, 255)
            Item.BackgroundTransparency = 0
        end)
        
        Item.MouseLeave:Connect(function()
            ItemText.TextColor3 = PresetColor
            Item.BackgroundTransparency = 1
        end)
        
        Item.MouseButton1Click:Connect(function()
            selectedItems[v] = not selectedItems[v]
            
            if selectedItems[v] then
                -- Selected - show checkmark, change box color
                Checkbox.BackgroundColor3 = PresetColor
                Checkmark.ImageTransparency = 0
            else
                -- Deselected - hide checkmark, reset box color
                Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Checkmark.ImageTransparency = 1
            end
            
            updateSelectedText()
        end)
        
        MultiDropItemHolder.CanvasSize = UDim2.new(0, 0, 0, MultiDropItemHolderLayout.AbsoluteContentSize.Y)
        MultiDropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
        MultiDropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
        MultiDropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
    end
    
    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
    
    function multiSelect:SetSelected(items)
        -- Clear all first
        for item, _ in pairs(selectedItems) do
            selectedItems[item] = false
        end
        for _, v in next, MultiDropItemHolder:GetChildren() do
            if v.Name == "Item" then
                v.Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                v.Checkbox.Checkmark.ImageTransparency = 1
            end
        end
        -- Select the ones in the list
        for _, itemName in ipairs(items) do
            if selectedItems[itemName] ~= nil then
                selectedItems[itemName] = true
                for _, v in next, MultiDropItemHolder:GetChildren() do
                    if v.Name == "Item" and v.ItemText.Text == itemName then
                        v.Checkbox.BackgroundColor3 = PresetColor
                        v.Checkbox.Checkmark.ImageTransparency = 0
                    end
                end
            end
        end
        updateSelectedText()
    end
    
    function multiSelect:Clear()
        for item, _ in pairs(selectedItems) do
            selectedItems[item] = false
        end
        for i, v in next, MultiDropItemHolder:GetChildren() do
            if v.Name == "Item" then
                v.Checkbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                v.Checkbox.Checkmark.ImageTransparency = 1
            end
        end
        updateSelectedText()
    end
    
    return multiSelect
end

function ChannelContent:TextBox(labelText, placeholder, callback, defaultText, numericOnly)
    local textBoxFrame = Instance.new("Frame")
    local textBoxOutline = Instance.new("Frame")
    local outlineCorner = Instance.new("UICorner")
    local inputBox = Instance.new("TextBox")
    local inputCorner = Instance.new("UICorner")
    local label = Instance.new("TextLabel")

    -- Main frame for spacing
    textBoxFrame.Name = "TextBoxFrame"
    textBoxFrame.Parent = ChannelHolder
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.Size = UDim2.new(0, 403, 0, 36)

    -- Label above TextBox
    label.Name = "Label"
    label.Parent = textBoxFrame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 5, 0, 0)
    label.Size = UDim2.new(0, 200, 0, 14)
    label.Font = Enum.Font.Gotham
    label.Text = labelText
    label.TextColor3 = PresetColor
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left

    -- Outline frame
    textBoxOutline.Name = "Outline"
    textBoxOutline.Parent = textBoxFrame
    textBoxOutline.BackgroundColor3 = PresetColor
    textBoxOutline.Position = UDim2.new(0, 0, 0, 16)
    textBoxOutline.Size = UDim2.new(0, 396, 0, 24)

    outlineCorner.CornerRadius = UDim.new(0, 4)
    outlineCorner.Name = "OutlineCorner"
    outlineCorner.Parent = textBoxOutline

    -- TextBox inside outline
    inputBox.Name = "InputBox"
    inputBox.Parent = textBoxOutline
    inputBox.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    inputBox.Position = UDim2.new(0, 2, 0, 2)
    inputBox.Size = UDim2.new(1, -4, 1, -4)
    inputBox.Font = Enum.Font.Gotham
    inputBox.PlaceholderText = placeholder or ""
    inputBox.Text = defaultText or ""
    inputBox.TextColor3 = PresetColor
    inputBox.TextSize = 14
    inputBox.ClearTextOnFocus = false

    inputCorner.CornerRadius = UDim.new(0, 3)
    inputCorner.Name = "InputCorner"
    inputCorner.Parent = inputBox

    -- Text change callback
    inputBox:GetPropertyChangedSignal("Text"):Connect(function()
        if numericOnly then
            -- Remove non-numeric characters
            local clean = inputBox.Text:gsub("%D", "")
            if inputBox.Text ~= clean then
                inputBox.Text = clean
            end
        end
        pcall(callback, inputBox.Text)
    end)

    -- Adjust canvas size of the ChannelHolder
    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)

    -- Return the object to allow get/set
    local textboxObj = {}

    function textboxObj:GetValue()
        return inputBox.Text
    end

    function textboxObj:SetValue(val)
        inputBox.Text = val
    end

    return textboxObj
end
                
                function ChannelContent:Label(text)
                    local Label = Instance.new("TextButton")
                    local LabelTitle = Instance.new("TextLabel")
                    local labelfunc = {}
                    
                    Label.Name = "Label"
                    Label.Parent = ChannelHolder
                    Label.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                    Label.BorderSizePixel = 0
                    Label.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                    Label.Size = UDim2.new(0, 401, 0, 30)
                    Label.AutoButtonColor = false
                    Label.Font = Enum.Font.Gotham
                    Label.Text = ""
                    Label.TextColor3 = PresetColor
                    Label.TextSize = 14.000
                    
                    LabelTitle.Name = "LabelTitle"
                    LabelTitle.Parent = Label
                    LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    LabelTitle.BackgroundTransparency = 1.000
                    LabelTitle.Position = UDim2.new(0, 5, 0, 0)
                    LabelTitle.Size = UDim2.new(0, 200, 0, 30)
                    LabelTitle.Font = Enum.Font.Gotham
                    LabelTitle.Text = text
                    LabelTitle.TextColor3 = PresetColor
                    LabelTitle.TextSize = 14.000
                    LabelTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                    
                    function labelfunc:Refresh(tochange)
                        Label.Text = tochange
                    end
                    
                    return labelfunc
                end
                
                function ChannelContent:Bind(text, presetbind, callback)
                    local Key = presetbind.Name
                    local Keybind = Instance.new("TextButton")
                    local KeybindTitle = Instance.new("TextLabel")
                    local KeybindText = Instance.new("TextLabel")
                    
                    Keybind.Name = "Keybind"
                    Keybind.Parent = ChannelHolder
                    Keybind.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
                    Keybind.BorderSizePixel = 0
                    Keybind.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
                    Keybind.Size = UDim2.new(0, 401, 0, 30)
                    Keybind.AutoButtonColor = false
                    Keybind.Font = Enum.Font.Gotham
                    Keybind.Text = ""
                    Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Keybind.TextSize = 14.000
                    
                    KeybindTitle.Name = "KeybindTitle"
                    KeybindTitle.Parent = Keybind
                    KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    KeybindTitle.BackgroundTransparency = 1.000
                    KeybindTitle.Position = UDim2.new(0, 5, 0, 0)
                    KeybindTitle.Size = UDim2.new(0, 200, 0, 30)
                    KeybindTitle.Font = Enum.Font.Gotham
                    KeybindTitle.Text = text
                    KeybindTitle.TextColor3 = PresetColor
                    KeybindTitle.TextSize = 14.000
                    KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
                    
                    KeybindText.Name = "KeybindText"
                    KeybindText.Parent = Keybind
                    KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    KeybindText.BackgroundTransparency = 1.000
                    KeybindText.Position = UDim2.new(0, 316, 0, 0)
                    KeybindText.Size = UDim2.new(0, 85, 0, 30)
                    KeybindText.Font = Enum.Font.Gotham
                    KeybindText.Text = presetbind.Name
                    KeybindText.TextColor3 = PresetColor
                    KeybindText.TextSize = 14.000
                    KeybindText.TextXAlignment = Enum.TextXAlignment.Right
                    
                    Keybind.MouseButton1Click:Connect(function()
                        KeybindText.Text = "..."
                        local inputwait = game:GetService("UserInputService").InputBegan:wait()
                        if inputwait.KeyCode.Name ~= "Unknown" then
                            KeybindText.Text = inputwait.KeyCode.Name
                            Key = inputwait.KeyCode.Name
                        end
                    end)
                    
                    game:GetService("UserInputService").InputBegan:connect(function(current, pressed)
                        if not pressed then
                            if current.KeyCode.Name == Key then
                                pcall(callback)
                            end
                        end
                    end)
                    
                    ChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ChannelHolderLayout.AbsoluteContentSize.Y)
                end
                
                return ChannelContent
            end
            
            return ChannelHold
        end
        
        return ServerHold
    end
    
    -- MAIN GUI SETUP - Add your tabs here
    local win = DiscordLib:Window("Escape Tsunami for Brainrots", _G.Color, _G.Toggle)
    
    local serv = win:Server("Ashleng on Top", "")
    
    local main = serv:Channel("Main", "http://www.roblox.com/asset/?id=7040391851")
    
    Time = main:Label("Server Time")
    function UpdateTime()
		local GameTime = math.floor(workspace.DistributedGameTime+0.5)
		local Hour = math.floor(GameTime/(60^2))%24
		local Minute = math.floor(GameTime/(60^1))%60
		local Second = math.floor(GameTime/(60^0))%60
		Time:Refresh("Hour : "..Hour.." Minute : "..Minute.." Second : "..Second)
	end
	
	spawn(function()
		while true do
			UpdateTime()
			wait()
		end
	end)

    Client = main:Label("Client")
    function UpdateClient()
		local Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		local Fps = workspace:GetRealPhysicsFPS()
		Client:Refresh("Fps : "..Fps.." Ping : "..Ping)
	end
	
	spawn(function()
		while true do wait(.1)
			UpdateClient()
		end
	end)
    main:Line()
    main:Label(""):Refresh("Auto Farm")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local brainrots = workspace.ActiveBrainrots
local luckyBlocks = workspace.ActiveLuckyBlocks
local undergroundY = -2.8199849128723145
local spawnX = 150.32762145996094
local spawnAbove = Vector3.new(150.32762145996094, 3.407457113265991, -1.973116159439087)
local speed = 1000
local waveCheckRadius = 150
local geyserCheckRadius = 50

-- ============================================================
--  RARITY LISTS
-- ============================================================
local BrainrotRarityList = {
    "Infinity", "Divine", "Celestial", "Secret", "Cosmic",
    "Mythical", "Legendary", "Epic", "Rare", "Uncommon", "Common"
}

local LuckyBlockRarityList = {
    "Infinity", "Divine", "Celestial", "Secret", "Cosmic",
    "Mythical", "Legendary", "Epic", "Rare", "Uncommon", "Common"
}

local char, root, bv, bg

-- ============================================================
--  WAVE CHECK
-- ============================================================
local activeTsunamis = workspace:WaitForChild("ActiveTsunamis")

local function isWaveNearPosition(targetPos)
    for _, wave in pairs(activeTsunamis:GetChildren()) do
        if wave:IsA("Model") then
            local ok, pivot = pcall(function() return wave:GetPivot().Position end)
            if ok then
                local dist = (Vector3.new(pivot.X, 0, pivot.Z) - Vector3.new(targetPos.X, 0, targetPos.Z)).Magnitude
                if dist < waveCheckRadius then
                    return true
                end
            end
        end
    end
    return false
end

-- ============================================================
--  GEYSER CHECK
-- ============================================================
local function isGeyserNearPosition(targetPos)
    local geyserVFX = workspace:FindFirstChild("GeyserVisualsVFX")
    if not geyserVFX then return false end
    for _, part in pairs(geyserVFX:GetDescendants()) do
        if part:IsA("BasePart") and part.Name:find("DangerZone") then
            local dist = (Vector3.new(part.Position.X, 0, part.Position.Z) - Vector3.new(targetPos.X, 0, targetPos.Z)).Magnitude
            if dist < geyserCheckRadius then
                return true
            end
        end
    end
    return false
end

local function isDangerous(targetPos)
    return isWaveNearPosition(targetPos) or isGeyserNearPosition(targetPos)
end

-- ============================================================
--  GET MAX CARRY
-- ============================================================
local function getMaxCarry()
    local success, result = pcall(function()
        return player.PlayerGui.UpgradeShop.FrameNew.ScrollingFrame.Carry.Frame.CurrentNext.Current.Frame.Amount.Text
    end)
    if success and result then
        return tonumber(result:match("%d+")) or 1
    end
    return 1
end

-- ============================================================
--  GOD MODE
-- ============================================================
local godModeConnection
local function enableGodMode()
    if godModeConnection then
        godModeConnection:Disconnect()
        godModeConnection = nil
    end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    humanoid.BreakJointsOnDeath = false
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    godModeConnection = RunService.Heartbeat:Connect(function()
        if humanoid and humanoid.Parent then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

-- ============================================================
--  FLY TO POSITION
-- ============================================================
local function flyTo(targetX, targetY, targetZ, checkFlag, customSpeed)
    if not root or not root.Parent then return false end
    local target = Vector3.new(targetX, targetY, targetZ)
    local moveSpeed = customSpeed or _G.RainbowSpeedOverride or speed
    repeat
        task.wait()
        if not _G[checkFlag] then return false end
        if not root or not root.Parent then return false end
        local current = root.Position
        local dir = (target - current).Unit
        bv.Velocity = dir * moveSpeed
        root.CFrame = CFrame.new(current.X, targetY, current.Z)
    until (Vector3.new(root.Position.X, 0, root.Position.Z) - Vector3.new(targetX, 0, targetZ)).Magnitude < 3
    bv.Velocity = Vector3.zero
    return true
end

local collectY = -2.8199849128723145

-- ============================================================
--  RETURN TO SPAWN
-- ============================================================
local function returnToSpawn(checkFlag)
    if not root or not root.Parent then return end
    flyTo(spawnAbove.X, collectY, spawnAbove.Z, checkFlag)
    flyTo(spawnAbove.X, spawnAbove.Y, spawnAbove.Z, checkFlag)
end

-- ============================================================
--  COLLECT ONE TARGET
-- ============================================================
local function collectTarget(targetModel, checkFlag, grabCheckName)
    if not targetModel or not targetModel.Parent then return false end
    if not root or not root.Parent then return false end

    local pivot = targetModel:GetPivot().Position

    local ok = flyTo(pivot.X, collectY, pivot.Z, checkFlag)
    if not ok then return false end
    if not targetModel or not targetModel.Parent then return false end

    local function countCarried(name)
        local count = 0
        if char then
            for _, v in pairs(char:GetChildren()) do
                if v.Name == name then count += 1 end
            end
        end
        return count
    end

    local carriedBefore = countCarried(grabCheckName)

    local prompt = targetModel:FindFirstChildWhichIsA("ProximityPrompt", true)
    local grabbed = false
    for attempt = 1, 5 do
        if not _G[checkFlag] then return false end
        if prompt then
            fireproximityprompt(prompt)
        end
        task.wait(0.3)
        if countCarried(grabCheckName) > carriedBefore then
            grabbed = true
            break
        end
    end
    if not grabbed then return false end

    return true
end

local function getBrainrotTimer(model)
    local ok, result = pcall(function()
        return model.Root.TimerGui.TimeLeft.TimeLeft.Text
    end)
    if ok and result then
        return tonumber(result:match("%d+")) or 0
    end
    return 0
end

-- ============================================================
local function getBrainrotTargets()
    local targets = {}
    local selectedRarities = _G.SelectedBrainrotRarity or {}
    for _, rarity in ipairs(selectedRarities) do
        local folder = brainrots:FindFirstChild(rarity)
        if folder then
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") and model.Parent then
                    table.insert(targets, model)
                end
            end
        end
    end
    return targets
end

local function getBlockTargets()
    local targets = {}
    local selectedRarities = _G.SelectedLuckyBlockRarity or {}
    for _, model in ipairs(luckyBlocks:GetChildren()) do
        if model:IsA("Model") and model.Parent then
            for _, rarity in ipairs(selectedRarities) do
                if model.Name:match("_" .. rarity .. "$") then
                    table.insert(targets, model)
                    break
                end
            end
        end
    end
    return targets
end

-- ============================================================
--  BRAINROT FARM LOOP
-- ============================================================
function startFarmLoop()
    if _G.FarmLoopRunning then return end
    _G.FarmLoopRunning = true
    task.spawn(function()
        while _G.AutoFarmBrainrots do
            local selectedRarities = _G.SelectedBrainrotRarity or {}
            if #selectedRarities == 0 then
                task.wait(1)
                continue
            end

            local targets = getBrainrotTargets()
            if #targets == 0 then
                task.wait(1)
                continue
            end

            local maxCarry = _G.SelectedCarryAmount or 1
            local collected = 0

            for _, model in ipairs(targets) do
                if not _G.AutoFarmBrainrots then break end
                if not root or not root.Parent then break end
                if collected >= maxCarry then break end
                if not model.Parent then continue end
                if getBrainrotTimer(model) <= 5 then continue end
                local success = collectTarget(model, "AutoFarmBrainrots", "RenderedBrainrot")
                if success then collected += 1 end
                task.wait(0.2)
            end

            returnToSpawn("AutoFarmBrainrots")
            task.wait(0.5)
        end
        _G.FarmLoopRunning = false
    end)
end

-- ============================================================
--  LUCKY BLOCK FARM LOOP
-- ============================================================
function startBlockFarmLoop()
    if _G.BlockLoopRunning then return end
    _G.BlockLoopRunning = true
    task.spawn(function()
        while _G.AutoFarmBlocks do
            local selectedRarities = _G.SelectedLuckyBlockRarity or {}
            if #selectedRarities == 0 then
                task.wait(1)
                continue
            end

            local maxCarry = _G.SelectedCarryAmount or 1
            local collected = 0
            local targets = getBlockTargets()

            if #targets == 0 then
                task.wait(1)
                continue
            end

            for _, model in ipairs(targets) do
                if not _G.AutoFarmBlocks then break end
                if not root or not root.Parent then break end
                if collected >= maxCarry then break end
                if not model.Parent then continue end
                local success = collectTarget(model, "AutoFarmBlocks", "NaturalSpawnLuckyBlock")
                if success then collected += 1 end
                task.wait(0.2)
            end

            returnToSpawn("AutoFarmBlocks")
            task.wait(0.5)
        end
        _G.BlockLoopRunning = false
    end)
end

-- ============================================================
--  AUTO SACRIFICE
-- ============================================================
local fireColor = "0 1 0.392157 0.196078 0 1 1 0.392157 0.196078 0 "
local iceColor = "0 0.12549 0.254902 0.45098 0 1 0.12549 0.254902 0.45098 0 "

local submitPos = Vector3.new(325.9317626953125, -2.8199849128723145, -0.8744691610336304)

local function getAura()
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local fx = hrp:FindFirstChild("fx")
    if fx then return fx:FindFirstChild("aura1") end
    return hrp:FindFirstChild("aura1")
end

local function isFireTeam()
    local aura = getAura()
    if not aura then return false end
    return tostring(aura.Color) == fireColor
end

local function getTeam()
    if not getAura() then return nil end
    if isFireTeam() then return "Fire" end
    return "Ice"
end

local function isEventActive()
    return getAura() ~= nil
end

local function getSacrificeTargets()
    local team = getTeam()
    local targets = {}
    for _, rarity in ipairs(BrainrotRarityList) do
        local folder = brainrots:FindFirstChild(rarity)
        if folder then
            for _, model in pairs(folder:GetChildren()) do
                if model:IsA("Model") and model.Parent then
                    local pivot = model:GetPivot().Position
                    if team == "Fire" and pivot.Z < 0 then
                        table.insert(targets, model)
                    elseif team == "Ice" and pivot.Z > 0 then
                        table.insert(targets, model)
                    end
                end
            end
        end
        if #targets >= 6 then break end
    end
    return targets
end

local function clickYesButton()
    pcall(function()
        local button = game:GetService("Players").LocalPlayer.PlayerGui.ChoiceGui.Choice.Choices.Yes
        firesignal(button.Activated)
    end)
end

-- FIX: Spam E on any ProximityPrompt near the submit position (within 30 studs)
local function spamEAtSubmitPos()
    for _, v in pairs(workspace:GetDescendants()) do
        pcall(function()
            if v:IsA("ProximityPrompt") then
                local partPos = v.Parent:IsA("BasePart") and v.Parent.Position
                    or v.Parent:GetPivot().Position
                if (partPos - submitPos).Magnitude < 30 then
                    fireproximityprompt(v)
                end
            end
        end)
    end
end

local function autoSacrificeLoop()
    if _G.SacrificeLoopRunning then return end
    _G.SacrificeLoopRunning = true
    task.spawn(function()
        while _G.AutoSacrifice do
            if not isEventActive() then
                task.wait(1)
                continue
            end

            local fireAndIceMap = workspace:FindFirstChild("FireAndIceMap")
            if not fireAndIceMap then task.wait(2) continue end

            local machine = fireAndIceMap:FindFirstChild("FireAndIceSacraficeMachine")
            if not machine then task.wait(2) continue end

            local targets = getSacrificeTargets()
            if #targets == 0 then task.wait(1) continue end

            local collected = 0
            for _, model in ipairs(targets) do
                if not _G.AutoSacrifice then break end
                if collected >= 6 then break end
                if not model.Parent then continue end
                if getBrainrotTimer(model) <= 5 then continue end
                local success = collectTarget(model, "AutoSacrifice", "RenderedBrainrot")
                if success then collected += 1 end
                task.wait(0.2)
            end

            if collected == 0 then task.wait(1) continue end

            -- Fly to submit position
            flyTo(submitPos.X, collectY, submitPos.Z, "AutoSacrifice")
            flyTo(submitPos.X, submitPos.Y, submitPos.Z, "AutoSacrifice")

            local function countHeldBrainrots()
                local count = 0
                if char then
                    for _, v in pairs(char:GetChildren()) do
                        if v.Name == "RenderedBrainrot" then count += 1 end
                    end
                end
                return count
            end

            -- FIX: Spam E near submit position + Yes button every 0.2s until done
            local timeout = 0
            while countHeldBrainrots() > 0 and _G.AutoSacrifice and timeout < 10 do
                spamEAtSubmitPos()
                clickYesButton()
                task.wait(0.2)
                timeout += 0.2
            end

            returnToSpawn("AutoSacrifice")
            task.wait(0.5)
        end
        _G.SacrificeLoopRunning = false
    end)
end
-- ============================================================
--  AUTO PHANTOM ORBS
-- ============================================================
_G.AutoPhantomOrbs = false
_G.PhantomOrbsRunning = false

local phantomOrbParts = workspace:FindFirstChild("PhantomOrbParts")
local phantomSubmitPos = Vector3.new(447.5162658691406, 171.84654235839844, 337.6318054199219)

local function getOrbPart(orb)
    return orb:FindFirstChild("Part")
end

local function getPhantomOrbCount()
    local ok, text = pcall(function()
        return player.PlayerGui.HUD.BottomLeft.EventSpecificCurrencies.Container.Slot1.Value.Text
    end)
    if ok and text then
        return tonumber(text:match("%d+")) or 0
    end
    return 0
end

local function getNearestOrb()
    if not phantomOrbParts or not phantomOrbParts.Parent then
        phantomOrbParts = workspace:FindFirstChild("PhantomOrbParts")
    end
    if not phantomOrbParts then return nil end
    if not root or not root.Parent then return nil end

    local nearest = nil
    local nearestDist = math.huge

    for _, orb in pairs(phantomOrbParts:GetChildren()) do
        local part = getOrbPart(orb)
        if part then
            local dist = (part.Position - root.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = orb
            end
        end
    end

    return nearest
end

-- FIX: Spam E by finding the submit ProximityPrompt near the submit position directly
local function spamEAtSubmit()
    while getPhantomOrbCount() >= 100 and _G.AutoPhantomOrbs do
        -- Find any ProximityPrompt within range of the submit position
        local found = false
        for _, v in pairs(workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("ProximityPrompt") then
                    local partPos = v.Parent:IsA("BasePart") and v.Parent.Position
                        or v.Parent:GetPivot().Position
                    if (partPos - phantomSubmitPos).Magnitude < 30 then
                        fireproximityprompt(v)
                        found = true
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end

local function autoPhantomOrbsLoop()
    if _G.PhantomOrbsRunning then return end
    _G.PhantomOrbsRunning = true

-- Spam E nonstop while loop is running
task.spawn(function()
    while _G.AutoPhantomOrbs do
        for _, v in pairs(workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("ProximityPrompt") then
                    local partPos = v.Parent:IsA("BasePart") and v.Parent.Position
                        or v.Parent:GetPivot().Position
                    if (partPos - phantomSubmitPos).Magnitude < 30 then
                        fireproximityprompt(v)
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end)

    task.spawn(function()
        while _G.AutoPhantomOrbs do
            if not root or not root.Parent then task.wait(0.5) continue end

            -- If maxed, go submit first
            if getPhantomOrbCount() >= 100 then
                flyTo(phantomSubmitPos.X, collectY, phantomSubmitPos.Z, "AutoPhantomOrbs")
                flyTo(phantomSubmitPos.X, phantomSubmitPos.Y, phantomSubmitPos.Z, "AutoPhantomOrbs")
                spamEAtSubmit()
                task.wait(0.5)
                continue
            end

            -- Find nearest orb
            local orb = getNearestOrb()
            if not orb then
                task.wait(2)
                continue
            end

            local part = getOrbPart(orb)
            if not part then continue end

            local pos = part.Position

            -- Fly to orb at its actual Y, but drop to collectY if wave/geyser nearby
            local timeout = 0
            repeat
                task.wait()
                if not _G.AutoPhantomOrbs then break end
                if not root or not root.Parent then break end
                if not orb.Parent then break end

                pos = part.Position

                local targetY
                if isDangerous(pos) then
                    targetY = collectY
                else
                    targetY = pos.Y
                end

                local target = Vector3.new(pos.X, targetY, pos.Z)
                local dir = (target - root.Position).Unit
                bv.Velocity = dir * 1100  -- faster speed
                TweenService:Create(root, TweenInfo.new(0.05), {CFrame = CFrame.new(root.Position.X, targetY, root.Position.Z)}):Play()
                timeout += 0.016
            until (root.Position - pos).Magnitude < 3 or timeout > 8 or not orb.Parent
            bv.Velocity = Vector3.zero

            task.wait(0.05)

            -- Check if maxed after grabbing
            if getPhantomOrbCount() >= 100 then
                flyTo(phantomSubmitPos.X, collectY, phantomSubmitPos.Z, "AutoPhantomOrbs")
                flyTo(phantomSubmitPos.X, phantomSubmitPos.Y, phantomSubmitPos.Z, "AutoPhantomOrbs")
                spamEAtSubmit()
                task.wait(0.5)
            end
        end

        _G.PhantomOrbsRunning = false
        if bv and not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice and not _G.AutoTowerTrial then
            bv.MaxForce = Vector3.zero
            bg.MaxTorque = Vector3.zero
        end
    end)
end

-- ============================================================
--  AUTO PHANTOM SHARDS
-- ============================================================
_G.AutoPhantomShards = false
_G.PhantomShardsRunning = false

local phantomShardBombParts = workspace:FindFirstChild("PhantomShardBombParts")

local function getShardPart(shard)
    local meshes = shard:FindFirstChild("Meshes/shard")
    return meshes or shard:FindFirstChildWhichIsA("BasePart")
end

local function getShardTargets()
    if not phantomShardBombParts or not phantomShardBombParts.Parent then
        phantomShardBombParts = workspace:FindFirstChild("PhantomShardBombParts")
    end
    if not phantomShardBombParts then return {} end
    local targets = {}
    for _, shard in pairs(phantomShardBombParts:GetChildren()) do
        if shard:IsA("Model") then
            table.insert(targets, shard)
        end
    end
    return targets
end

local function collectShard(shard, checkFlag)
    if not shard or not shard.Parent then return false end
    if not root or not root.Parent then return false end
    local part = getShardPart(shard)
    if not part then return false end
    local pos = part.Position
    if isDangerous(pos) then return false end
    local ok = flyTo(pos.X, collectY, pos.Z, checkFlag)
    if not ok then return false end
    if not shard or not shard.Parent then return false end
    flyTo(pos.X, pos.Y, pos.Z, checkFlag)
    task.wait(0.2)
    return true
end

local function autoPhantomShardsLoop()
    if _G.PhantomShardsRunning then return end
    _G.PhantomShardsRunning = true
    task.spawn(function()
        while _G.AutoPhantomShards do
            local targets = getShardTargets()
            if #targets == 0 then task.wait(2) continue end

            for _, shard in ipairs(targets) do
                if not _G.AutoPhantomShards then break end
                if not root or not root.Parent then break end
                if not shard or not shard.Parent then continue end
                local part = getShardPart(shard)
                if not part then continue end
                if isDangerous(part.Position) then task.wait(0.5) continue end
                collectShard(shard, "AutoPhantomShards")
                task.wait(0.1)
            end

            returnToSpawn("AutoPhantomShards")
            task.wait(1)
        end
        _G.PhantomShardsRunning = false
        if bv and not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice and not _G.AutoTowerTrial and not _G.AutoPhantomOrbs then
            bv.MaxForce = Vector3.zero
            bg.MaxTorque = Vector3.zero
        end
    end)
end

-- ============================================================
--  SETUP CHARACTER
-- ============================================================
local function setupCharacter(newChar)
    char = newChar
    root = char:WaitForChild("HumanoidRootPart")
    enableGodMode()

    if bv then bv:Destroy() end
    if bg then bg:Destroy() end

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.zero
    bv.Velocity = Vector3.zero
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.zero
    bg.CFrame = root.CFrame
    bg.Parent = root

    task.spawn(function()
        while char and char.Parent do
            task.wait()
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)

    task.wait(2)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

    if _G.WasFarmingBrainrots then
        _G.AutoFarmBrainrots = true
        _G.WasFarmingBrainrots = false
        startFarmLoop()
    end
    if _G.WasFarmingBlocks then
        _G.AutoFarmBlocks = true
        _G.WasFarmingBlocks = false
        startBlockFarmLoop()
    end
    if _G.WasSacrificing then
        _G.AutoSacrifice = true
        _G.WasSacrificing = false
        task.spawn(function()
            local waited = 0
            while not isEventActive() and waited < 10 do
                task.wait(0.5)
                waited += 0.5
            end
            if isEventActive() then
                autoSacrificeLoop()
            else
                _G.AutoSacrifice = false
            end
        end)
    end
    -- Tower trial resume is handled after autoTowerLoop is defined (see bottom of script)
    if _G.WasPhantomOrbs then
        _G.AutoPhantomOrbs = true
        _G.WasPhantomOrbs = false
        autoPhantomOrbsLoop()
    end
    if _G.WasPhantomShards then
        _G.AutoPhantomShards = true
        _G.WasPhantomShards = false
        autoPhantomShardsLoop()
    end
    if _G.WasRainbow then
        _G.AutoRainbow = true
        _G.WasRainbow = false
        _G.RainbowRunning = false
        _G.RainbowSpeedOverride = nil
        task.spawn(function()
            task.wait(3)
            if _G.AutoRainbow and _G.startAutoRainbow then
                _G.startAutoRainbow()
            end
        end)
    end

    local anyActive = _G.AutoFarmBrainrots or _G.AutoFarmBlocks or _G.AutoSacrifice
        or _G.AutoTowerTrial or _G.AutoPhantomOrbs or _G.AutoPhantomShards or _G.AutoRainbow
    if not anyActive then
        bv.MaxForce = Vector3.zero
        bg.MaxTorque = Vector3.zero
    end
end

-- ============================================================
--  CHARACTER RESPAWN LISTENER
-- ============================================================
player.CharacterRemoving:Connect(function()
    _G.WasFarmingBrainrots = _G.AutoFarmBrainrots
    _G.WasFarmingBlocks = _G.AutoFarmBlocks
    _G.WasSacrificing = _G.AutoSacrifice
    _G.WasTowerTrialing = _G.AutoTowerTrial
    _G.WasPhantomOrbs = _G.AutoPhantomOrbs
    _G.WasPhantomShards = _G.AutoPhantomShards
    _G.WasRainbow = _G.AutoRainbow
    _G.AutoFarmBrainrots = false
    _G.AutoFarmBlocks = false
    _G.AutoSacrifice = false
    _G.AutoTowerTrial = false
    _G.AutoPhantomOrbs = false
    _G.AutoPhantomShards = false
    _G.AutoRainbow = false
    _G.FarmLoopRunning = false
    _G.BlockLoopRunning = false
    _G.SacrificeLoopRunning = false
    _G.TowerLoopRunning = false
    _G.PhantomOrbsRunning = false
    _G.PhantomShardsRunning = false
    _G.RainbowRunning = false
    _G.RainbowSpeedOverride = nil
end)

player.CharacterAdded:Connect(function(newChar)
    task.wait(0.5)
    setupCharacter(newChar)
end)

setupCharacter(player.Character or player.CharacterAdded:Wait())

-- ============================================================
--  CAMERA MODS
-- ============================================================
local camera = workspace.CurrentCamera
player.CameraMaxZoomDistance = 500
player.CameraMinZoomDistance = 0
RunService.RenderStepped:Connect(function()
    camera.CameraType = Enum.CameraType.Custom
end)
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    player.CameraMaxZoomDistance = 500
    player.CameraMinZoomDistance = 0
end)

-- ============================================================
--  AUTO DELETE TARGETS
-- ============================================================
local function deleteTargets()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "___" or v.Name == "DefaultMap_SharedInstances" or v.Name == "Spawners" then
            pcall(function() v:Destroy() end)
        end
    end
end
deleteTargets()
workspace.DescendantAdded:Connect(function(v)
    if v.Name == "___" or v.Name == "DefaultMap_SharedInstances" or v.Name == "Spawners" then
        pcall(function() v:Destroy() end)
    end
end)

-- ============================================================
--  RESIZE AND DUPLICATE GAPS
-- ============================================================
local function setupGaps()
    if workspace:FindFirstChild("Gaps") then return end
    local defaultMap = workspace:FindFirstChild("DefaultMap")
    if not defaultMap then print("DefaultMap not found") return end
    local gaps = defaultMap:FindFirstChild("Gaps")
    if not gaps then print("Gaps not found") return end
    for i = 1, 9 do
        local gap = gaps:FindFirstChild("Gap" .. i)
        if gap then
            for _, part in pairs(gap:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = Vector3.new(part.Size.X, part.Size.Y, 2048)
                    part.Anchored = true
                end
            end
        end
    end
    local cloned = gaps:Clone()
    cloned.Parent = workspace
    print("Gaps duplicated to workspace!")
end
setupGaps()
workspace.ChildAdded:Connect(function(v)
    if v.Name == "DefaultMap" then
        task.wait(0.5)
        setupGaps()
    end
end)

-- ============================================================
--  AUTO DELETE VIPWALLS
-- ============================================================
local function deleteVIPWalls()
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "VIPWalls" then
            pcall(function() v:Destroy() end)
        end
    end
end
deleteVIPWalls()
workspace.DescendantAdded:Connect(function(v)
    if v.Name == "VIPWalls" then
        pcall(function() v:Destroy() end)
    end
end)

-- ============================================================
--  GUI CONNECTIONS
-- ============================================================
local brainrotrarityList = main:MultiDropdown("Select Brainrots Rarity", BrainrotRarityList, function(selectedItems)
    _G.SelectedBrainrotRarity = selectedItems
end)

local luckyblockrarityList = main:MultiDropdown("Select Lucky Blocks Rarity", LuckyBlockRarityList, function(selectedItems)
    _G.SelectedLuckyBlockRarity = selectedItems
end)

local function getCarryOptions()
    local max = getMaxCarry()
    local options = {}
    for i = 1, max do
        table.insert(options, tostring(i))
    end
    return options
end

_G.SelectedCarryAmount = 1
local carryOptions = getCarryOptions()
main:Dropdown("Carry Amount", carryOptions, function(selected)
    _G.SelectedCarryAmount = tonumber(selected) or 1
end)

local toggleFarmBrainrots = main:Toggle("Auto Farm Brainrots", false, function(FarmBrainrots)
    _G.AutoFarmBrainrots = FarmBrainrots
    if FarmBrainrots then
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        startFarmLoop()
    else
        _G.FarmLoopRunning = false
        if bv then
            bv.Velocity = Vector3.zero
            if not _G.AutoFarmBlocks then
                bv.MaxForce = Vector3.zero
                bg.MaxTorque = Vector3.zero
            end
        end
        if root and root.Parent and not _G.AutoFarmBlocks then
            root.CFrame = CFrame.new(spawnAbove)
        end
    end
end)

local toggleFarmBlocks = main:Toggle("Auto Farm Blocks", false, function(FarmBlocks)
    _G.AutoFarmBlocks = FarmBlocks
    if FarmBlocks then
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        startBlockFarmLoop()
    else
        _G.BlockLoopRunning = false
        if bv then
            bv.Velocity = Vector3.zero
            if not _G.AutoFarmBrainrots then
                bv.MaxForce = Vector3.zero
                bg.MaxTorque = Vector3.zero
            end
        end
        if root and root.Parent and not _G.AutoFarmBrainrots then
            root.CFrame = CFrame.new(spawnAbove)
        end
    end
end)

local toggleSacrifice = main:Toggle("Auto Sacrifice", false, function(sacrifice)
    _G.AutoSacrifice = sacrifice
    if sacrifice then
        if not isEventActive() then
            _G.AutoSacrifice = false
            print("Auto Sacrifice: Event is not active or team not assigned yet!")
            return
        end
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        print("Team:", getTeam() or "Unknown")
        autoSacrificeLoop()
    else
        _G.SacrificeLoopRunning = false
        if bv then
            bv.Velocity = Vector3.zero
            if not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks then
                bv.MaxForce = Vector3.zero
                bg.MaxTorque = Vector3.zero
            end
        end
    end
end)

local togglePhantomOrbs = main:Toggle("Auto Phantom Orbs", false, function(v)
    _G.AutoPhantomOrbs = v
    if v then
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        autoPhantomOrbsLoop()
    else
        _G.PhantomOrbsRunning = false
        if bv then
            bv.Velocity = Vector3.zero
            if not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice and not _G.AutoTowerTrial then
                bv.MaxForce = Vector3.zero
                bg.MaxTorque = Vector3.zero
            end
        end
        if root and root.Parent then
            root.CFrame = CFrame.new(spawnAbove)
        end
    end
end)

local togglePhantomShards = main:Toggle("Auto Phantom Shards", false, function(v)
    _G.AutoPhantomShards = v
    if v then
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        autoPhantomShardsLoop()
    else
        _G.PhantomShardsRunning = false
        if bv then
            bv.Velocity = Vector3.zero
            if not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice and not _G.AutoTowerTrial and not _G.AutoPhantomOrbs then
                bv.MaxForce = Vector3.zero
                bg.MaxTorque = Vector3.zero
            end
        end
        if root and root.Parent then
            root.CFrame = CFrame.new(spawnAbove)
        end
    end
end)

-- ============================================================
--  AUTO ST PATRICKS RAINBOW
-- ============================================================
if _G.AutoRainbow == nil then _G.AutoRainbow = false end
if _G.RainbowRunning == nil then _G.RainbowRunning = false end

local function getPotOfGoldPrompt()
    local pot = workspace:FindFirstChild("PotOfGold")
    if not pot then return nil end
    for _, v in pairs(pot:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.ActionText == "Submit Brainrots" then
            return v
        end
    end
    return nil
end

local function getRainbowBrainrotTargets()
    local targets = {}
    for _, rarity in ipairs(BrainrotRarityList) do
        if #targets >= 6 then break end
        local folder = brainrots:FindFirstChild(rarity)
        if folder then
            for _, model in pairs(folder:GetChildren()) do
                if #targets >= 6 then break end
                if model:IsA("Model") and model.Parent then
                    if getBrainrotTimer(model) > 5 then
                        table.insert(targets, model)
                    end
                end
            end
        end
    end
    return targets
end

local function countCarriedBrainrots()
    local count = 0
    if char then
        for _, v in pairs(char:GetChildren()) do
            if v.Name == "RenderedBrainrot" then count += 1 end
        end
    end
    return count
end

local function getClaimRewardPrompt()
    local pot = workspace:FindFirstChild("PotOfGold")
    if not pot then return nil end
    for _, v in pairs(pot:GetDescendants()) do
        if v:IsA("ProximityPrompt") and v.ActionText == "Claim Reward" then
            return v
        end
    end
    return nil
end

local function autoRainbowLoop()
    if _G.RainbowRunning then return end
    _G.RainbowRunning = true
    _G.RainbowSpeedOverride = 800
    task.spawn(function()
        while _G.AutoRainbow do
            if not root or not root.Parent then task.wait(1) continue end

            -- Wait for PotOfGold to appear
            local pot = workspace:FindFirstChild("PotOfGold")
            if not pot then
                task.wait(5)
                continue
            end

            -- Check if Claim Reward is available (rainbow 100% done)
            local claimPrompt = getClaimRewardPrompt()
            if claimPrompt then
                -- Fly to pot and claim reward
                local potPos = pot:GetPivot().Position
                flyTo(potPos.X, collectY, potPos.Z, "AutoRainbow", 800)
                if not _G.AutoRainbow then break end
                flyTo(potPos.X, potPos.Y, potPos.Z, "AutoRainbow", 500)
                if not _G.AutoRainbow then break end
                task.wait(0.5)
                -- Spam claim for a few seconds
                for attempt = 1, 20 do
                    if not _G.AutoRainbow then break end
                    local cp = getClaimRewardPrompt()
                    if not cp then break end
                    fireproximityprompt(cp)
                    task.wait(0.3)
                end
                -- Return to spawn and wait for new pot
                returnToSpawn("AutoRainbow")
                task.wait(2)
                continue
            end

            -- Step 1: Collect 6 brainrots (highest rarity first)
            local collected = 0
            local targets = getRainbowBrainrotTargets()

            if #targets == 0 then
                task.wait(2)
                continue
            end

            for _, model in ipairs(targets) do
                if not _G.AutoRainbow then break end
                if collected >= 6 then break end
                if not model.Parent then continue end
                if getBrainrotTimer(model) <= 5 then continue end
                local success = collectTarget(model, "AutoRainbow", "RenderedBrainrot")
                if success then collected += 1 end
                task.wait(0.2)
            end

            if not _G.AutoRainbow then break end

            -- Skip if nothing collected
            if collected == 0 then
                task.wait(2)
                continue
            end

            -- Step 2: Fly to PotOfGold
            pot = workspace:FindFirstChild("PotOfGold")
            if not pot then
                task.wait(2)
                continue
            end

            local potPos = pot:GetPivot().Position
            flyTo(potPos.X, collectY, potPos.Z, "AutoRainbow", 800)
            if not _G.AutoRainbow then break end
            flyTo(potPos.X, potPos.Y, potPos.Z, "AutoRainbow", 500)
            if not _G.AutoRainbow then break end

            task.wait(0.5)

            -- Step 3: Fire Submit Brainrots prompt + confirm Yes dialog
            for attempt = 1, 15 do
                if not _G.AutoRainbow then break end
                local prompt = getPotOfGoldPrompt()
                if prompt then
                    fireproximityprompt(prompt)
                end
                pcall(function()
                    local btn = player.PlayerGui.ChoiceGui.Choice.Choices.Yes
                    firesignal(btn.Activated)
                end)
                task.wait(0.3)
                if countCarriedBrainrots() == 0 then break end
            end

            task.wait(0.5)

            -- Step 4: Return to spawn and repeat
            returnToSpawn("AutoRainbow")
            task.wait(0.5)
        end
        _G.RainbowRunning = false
        _G.RainbowSpeedOverride = nil
        if bv and not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice and not _G.AutoTowerTrial and not _G.AutoPhantomOrbs and not _G.AutoPhantomShards then
            bv.MaxForce = Vector3.zero
            bg.MaxTorque = Vector3.zero
        end
    end)
end

-- Register so setupCharacter can call it after respawn
_G.startAutoRainbow = autoRainbowLoop

local toggleRainbow = main:Toggle("Auto St Patricks Rainbow", false, function(v)
    _G.AutoRainbow = v
    if v then
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        autoRainbowLoop()
    else
        _G.RainbowRunning = false
        if bv then
            bv.Velocity = Vector3.zero
            if not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice and not _G.AutoTowerTrial and not _G.AutoPhantomOrbs and not _G.AutoPhantomShards then
                bv.MaxForce = Vector3.zero
                bg.MaxTorque = Vector3.zero
            end
        end
        if root and root.Parent then
            root.CFrame = CFrame.new(spawnAbove)
        end
    end
end)

main:Line()
main:Label(""):Refresh("Auto Tower Trial")
-- ============================================================
--  AUTO TOWER TRIAL (FIXED v7)
-- ============================================================
local towerPos = Vector3.new(4327.2626953125, 6.174729824066162, -3.816185474395752)

local towerStatusLabel = main:Label("")
local towerProgressLabel = main:Label("")
local towerRequirementLabel = main:Label("")
local towerCooldownLabel = main:Label("")

local function getTowerPrompt()
    local ok, p = pcall(function()
        return workspace.GameObjects.PlaceSpecific.root.Tower.Main.Prompt.ProximityPrompt
    end)
    if ok and p then
        p.HoldDuration = 0
        return p
    end
    return nil
end

local function getCooldownText()
    local ok, text = pcall(function()
        return workspace.GameObjects.PlaceSpecific.root.Tower.Main.Billboard.BillboardGui.Frame.Info.CooldownContainer.TimeLabel.Text
    end)
    if ok and text then return text end
    return "-"
end

local function isReadyToStart()
    local p = getTowerPrompt()
    if not p then return false end
    return p.ActionText == "Start Trial!"
end

-- Returns true if a trial is currently in progress (timer bar is visible with time remaining)
local function isTrialActive()
    local ok, visible = pcall(function()
        return player.PlayerGui.TowerTrialHUD.TrialBar.Visible
    end)
    return ok and visible == true
end

local function getRequirementText()
    local ok, text = pcall(function()
        return player.PlayerGui.TowerTrialHUD.TrialBar.Requirement.Text
    end)
    if ok and text then
        return text:gsub("<[^>]+>", ""):gsub("^%s+", ""):gsub("%s+$", "")
    end
    return ""
end

local function parseRequirement()
    local text = getRequirementText()
    if text == "" then return nil, nil end
    local rarities = {"Infinity","Divine","Celestial","Secret","Cosmic","Mythical","Legendary","Epic","Rare","Uncommon","Common"}
    local detectedRarity = nil
    for _, r in ipairs(rarities) do
        if text:find(r) then detectedRarity = r break end
    end
    if not detectedRarity then return nil, nil end
    return detectedRarity, nil
end

local function parseProgress()
    local ok, text = pcall(function()
        return player.PlayerGui.TowerTrialHUD.TrialBar.Deposits.Text
    end)
    if ok and text then
        local current, max = text:match("(%d+)/(%d+)")
        return tonumber(current) or 0, tonumber(max) or 20
    end
    return 0, 20
end

local function updateTowerLabels()
    local p = getTowerPrompt()
    local actionText = p and p.ActionText or "-"
    towerCooldownLabel:Refresh("Cooldown: " .. getCooldownText() .. " | " .. actionText)
    local req = getRequirementText()
    towerRequirementLabel:Refresh("Requirement: " .. (req ~= "" and req or "-"))
    local current, max = parseProgress()
    towerProgressLabel:Refresh("Progress: " .. current .. "/" .. max)
end

local function findOneTowerBrainrot(rarity, specificName)
    if not rarity then return nil end
    local folder = brainrots:FindFirstChild(rarity)
    if not folder then return nil end
    if not root or not root.Parent then return nil end

    local nearest = nil
    local nearestDist = math.huge

    for _, model in pairs(folder:GetChildren()) do
        if model:IsA("Model") and model.Parent then
            if getBrainrotTimer(model) <= 5 then continue end
            if specificName then
                if not model.Name:lower():find(specificName:lower()) then continue end
            end
            local dist = (model:GetPivot().Position - root.Position).Magnitude
            if dist < nearestDist then
                nearestDist = dist
                nearest = model
            end
        end
    end

    return nearest
end

local function clickYesTower()
    pcall(function()
        local btn = player.PlayerGui.ChoiceGui.Choice.Choices.MultiChoice_normal
        firesignal(btn.Activated)
    end)
end

_G.AutoTowerTrial = false

local function autoTowerLoop()
    if _G.TowerLoopRunning then return end
    _G.TowerLoopRunning = true

    task.spawn(function()

        local towerSpeed = 1200

        local function flyToTower(targetX, targetY, targetZ)
            if not root or not root.Parent then return false end
            local target = Vector3.new(targetX, targetY, targetZ)
            repeat
                task.wait()
                if not _G.AutoTowerTrial then return false end
                if not root or not root.Parent then return false end
                local current = root.Position
                local dir = (target - current).Unit
                bv.Velocity = dir * towerSpeed
                root.CFrame = CFrame.new(current.X, targetY, current.Z)
            until (Vector3.new(root.Position.X, 0, root.Position.Z) - Vector3.new(targetX, 0, targetZ)).Magnitude < 3
            bv.Velocity = Vector3.zero
            return true
        end

        local function countHeldBrainrots()
            local count = 0
            if char then
                for _, v in pairs(char:GetChildren()) do
                    if v.Name == "RenderedBrainrot" then count += 1 end
                end
            end
            return count
        end

        local function submitHeld()
            flyToTower(towerPos.X, collectY, towerPos.Z)
            flyToTower(towerPos.X, towerPos.Y, towerPos.Z)
            if not _G.AutoTowerTrial then return end
            local timeout = 0
            while countHeldBrainrots() > 0 and _G.AutoTowerTrial and timeout < 10 do
                local prompt = getTowerPrompt()
                if prompt then fireproximityprompt(prompt) end
                task.wait(0.3)
                timeout += 0.3
            end
        end

        local function flyAndStartTrial()
            flyToTower(towerPos.X, collectY, towerPos.Z)
            flyToTower(towerPos.X, towerPos.Y, towerPos.Z)
            if not _G.AutoTowerTrial then return end
            local timeout = 0
            while _G.AutoTowerTrial and timeout < 5 do
                local p = getTowerPrompt()
                if not p then break end
                if not isReadyToStart() then break end
                fireproximityprompt(p)
                task.wait(0.2)
                timeout += 0.2
            end
            task.wait(1)
        end

        -- Wait briefly for HUD to load after respawn before checking trial state
        local hudWait = 0
        while hudWait < 3 and not isTrialActive() and not isReadyToStart() do
            task.wait(0.5)
            hudWait += 0.5
        end

        local currentOnStart, maxOnStart = parseProgress()
        -- Use TrialBar visibility as the primary check - if bar is visible, trial is still running
        local trialAlreadyRunning = isTrialActive() or (currentOnStart > 0 and currentOnStart < maxOnStart and not isReadyToStart())

        if not trialAlreadyRunning then
            towerStatusLabel:Refresh("Status: Flying to tower...")
            flyToTower(towerPos.X, collectY, towerPos.Z)
            flyToTower(towerPos.X, towerPos.Y, towerPos.Z)

            towerStatusLabel:Refresh("Status: Waiting for tower...")
            while _G.AutoTowerTrial do
                if isReadyToStart() then break end
                towerStatusLabel:Refresh("Status: Cooldown " .. getCooldownText())
                towerCooldownLabel:Refresh("Cooldown: " .. getCooldownText())
                task.wait(1)
            end
            if not _G.AutoTowerTrial then _G.TowerLoopRunning = false return end

            towerStatusLabel:Refresh("Status: Starting Trial...")
            flyAndStartTrial()
        else
            local cur, mx = parseProgress()
            towerStatusLabel:Refresh("Status: Trial still active! Resuming " .. cur .. "/" .. mx .. "...")
        end

        while _G.AutoTowerTrial do
            pcall(updateTowerLabels)

            local current, max = parseProgress()

            -- Check if trial ended mid-loop (prompt says Start Trial! AND TrialBar is gone)
            if isReadyToStart() and not isTrialActive() and current < max then
                towerStatusLabel:Refresh("Status: Trial ended early, restarting...")
                flyAndStartTrial()
                continue
            end

            if current >= max then
                towerStatusLabel:Refresh("Status: 20/20! Claiming reward...")
                flyToTower(towerPos.X, collectY, towerPos.Z)
                flyToTower(towerPos.X, towerPos.Y, towerPos.Z)
                if not _G.AutoTowerTrial then break end

                local claimTimeout = 0
                while _G.AutoTowerTrial and claimTimeout < 15 do
                    local c, m = parseProgress()
                    if c < m then break end
                    local p = getTowerPrompt()
                    if p then fireproximityprompt(p) end
                    clickYesTower()
                    towerStatusLabel:Refresh("Status: Claiming reward... (" .. c .. "/" .. m .. ")")
                    task.wait(0.5)
                    claimTimeout += 0.5
                end

                towerStatusLabel:Refresh("Status: Waiting for next round...")
                local waitTimeout = 0
                while _G.AutoTowerTrial and not isReadyToStart() and waitTimeout < 300 do
                    towerStatusLabel:Refresh("Status: Cooldown " .. getCooldownText())
                    towerCooldownLabel:Refresh("Cooldown: " .. getCooldownText())
                    task.wait(1)
                    waitTimeout += 1
                end
                if not _G.AutoTowerTrial then break end

                towerStatusLabel:Refresh("Status: Starting New Round...")
                flyAndStartTrial()
                continue
            end

            if countHeldBrainrots() > 0 then
                towerStatusLabel:Refresh("Status: Submitting held brainrot...")
                submitHeld()
                task.wait(2)
                continue
            end

            local rarity, specificName = parseRequirement()
            if not rarity then
                towerStatusLabel:Refresh("Status: Reading requirement...")
                task.wait(0.5)
                continue
            end

            local reqDisplay = specificName and (specificName .. " " .. rarity) or rarity
            towerStatusLabel:Refresh("Status: Finding nearest " .. reqDisplay .. " (" .. current .. "/" .. max .. ")")

            local lockedTarget = findOneTowerBrainrot(rarity, specificName)
            if not lockedTarget then
                towerStatusLabel:Refresh("Status: No " .. reqDisplay .. " found, waiting...")
                task.wait(2)
                continue
            end

            local lockedName = lockedTarget.Name
            towerStatusLabel:Refresh("Status: Grabbing " .. lockedName .. "...")

            local success = collectTarget(lockedTarget, "AutoTowerTrial", "RenderedBrainrot")

            if not success then
                towerStatusLabel:Refresh("Status: Failed to grab, retrying...")
                task.wait(1)
                continue
            end

            towerStatusLabel:Refresh("Status: Submitting " .. lockedName .. "...")
            submitHeld()

            task.wait(3.5)
            towerStatusLabel:Refresh("Status: Submitted! Reading next...")
        end

        _G.TowerLoopRunning = false
        towerStatusLabel:Refresh("Status: Idle")
        if bv and not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice then
            bv.MaxForce = Vector3.zero
            bg.MaxTorque = Vector3.zero
        end
    end)
end

local toggleTowerTrial = main:Toggle("Auto Tower Trial", false, function(v)
    _G.AutoTowerTrial = v
    if v then
        if bv then bv.MaxForce = Vector3.new(9e9, 9e9, 9e9) end
        if bg then bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9) end
        autoTowerLoop()
    else
        _G.TowerLoopRunning = false
        towerStatusLabel:Refresh("Status: Idle")
        if bv and not _G.AutoFarmBrainrots and not _G.AutoFarmBlocks and not _G.AutoSacrifice then
            bv.MaxForce = Vector3.zero
            bg.MaxTorque = Vector3.zero
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        pcall(updateTowerLabels)
    end
end)

-- ============================================================
--  TOWER TRIAL RESPAWN RESUME
--  Must be here, AFTER autoTowerLoop is defined
-- ============================================================
player.CharacterAdded:Connect(function()
    -- Wait for setupCharacter to finish rebuilding bv/bg/root (it waits 2s internally)
    task.wait(2.5)
    if not _G.WasTowerTrialing then return end
    _G.WasTowerTrialing = false
    _G.AutoTowerTrial = true
    _G.TowerLoopRunning = false
    towerStatusLabel:Refresh("Status: Respawned - resuming trial...")
    autoTowerLoop()
end)

    main:Line()
    main:Label(""):Refresh("Automated Machines")
-- ==========================
-- Machine Image Map
-- ==========================
local MACHINE_IMAGES = {
	["Carnival"]        = "rbxassetid://91539936244995",
	["LuckyClover"]     = "rbxassetid://104071312523652",
    ["PhantomSummoner"] = "rbxassetid://95154178039042",
    ["FireAndIce"]      = "rbxassetid://73516589533890",
    ["Doom"]            = "rbxassetid://84132224946901",
    ["ATM"]             = "rbxassetid://109664817855554",
    ["Arcade"]          = "rbxassetid://89524338654697",
    ["Blackhole"]       = "rbxassetid://84647330352070",
    ["Valentines"]      = "rbxassetid://80922593096338",
}

-- ==========================
-- Event Checker (image-based)
-- ==========================
local function isMachineEventActive(machineName)
    local expectedImage = MACHINE_IMAGES[machineName]
    if not expectedImage then return false end

    local ok, buffs = pcall(function()
        return game:GetService("Players").LocalPlayer.PlayerGui.HUD.BottomRight.Buffs:GetChildren()
    end)
    if not ok or not buffs then return false end

    for _, template in ipairs(buffs) do
        -- ✅ Template IS the ImageButton, check image directly on it
        if template:IsA("ImageButton") and template.Image == expectedImage then
            return template.Visible == true
        end
    end

    return false
end

-- ==========================
-- Machine List
-- ==========================
local brainrotList = {
	"Granado Tasmaniello Feroce",
	"Meta Jukebossa Sanguinfinita",
	"Mastodontico Giostraccio",
	"Los Clownitos Vampiroseppios",
    "Arcobaleno Camellino",
    "Cornettino Fuaco",
	"Pastapot Infernotto",
    "Dutchmello Velerino",
    "Crostina Gelifio",
    "Draculini Meowlini",
    "Cupitron Consoletron",
    "Freezeti Cobretti",
    "Galactio Fantasma",
    "Din Din Vaultero",
    "Strawberry Elephant",
    "Grappellino D'oro",
    "Martino Gravitino",
    "Burgerini Bearini",
    "Bulbito Bandito Traktorito"
}

local brainrotsSizes = {
    "Colossal",
    "Big",
    "Normal",
    "Mini",
    "Baby",
    "Lil Baby"
}

local machineList = {
	"Carnival",
	"LuckyClover",
    "PhantomSummoner",
    "FireAndIce",
    "Doom",
    "ATM",
    "Arcade",
    "Blackhole",
    "Valentines"
}

-- ==========================
-- Dropdowns
-- ==========================
local brainrotDropdown = main:MultiDropdown("Select Brainrots", brainrotList, function(selectedItems)
    _G.SelectedBrainrots = selectedItems
end)

local sizesList = main:MultiDropdown("Select Sizes", brainrotsSizes, function(selectedItems)
    _G.SelectedSizes = selectedItems
end)

local machinesLists = main:MultiDropdown("Select Machines", machineList, function(selectedItems)
    _G.SelectedMachines = selectedItems
end)

main:Button("Clear Dropdown", function()
    brainrotDropdown:Clear()
    sizesList:Clear()
    machinesLists:Clear()
end)

-- ==========================
-- Helper Functions
-- ==========================
local function getMachine()
    local sm = game:GetService("Workspace"):FindFirstChild("GameObjects")
    if not sm then return nil, nil end
    sm = sm:FindFirstChild("PlaceSpecific")
    if not sm then return nil, nil end
    sm = sm:FindFirstChild("root")
    if not sm then return nil, nil end
    sm = sm:FindFirstChild("SpawnMachines")
    if not sm then return nil, nil end

    local machines = {
        ["Blackhole"]       = "BLACKHOLE",
        ["ATM"]             = "ATM",
        ["Arcade"]          = "ARCADE",
        ["Valentines"]      = "VALENTINES",
        ["Doom"]            = "DOOM",
        ["FireAndIce"]      = "FIREANDICE",
        ["PhantomSummoner"] = "PHANTOMSUMMONER",
		["LuckyClover"] = "LUCKYCLOVER",
		["Carnival"] = "CARNIVAL"
    }

    for name, kind in pairs(machines) do
        if sm:FindFirstChild(name) then
            return sm[name], kind
        end
    end

    return nil, nil
end

-- ✅ Convert KIND back to friendly name for image lookup
local KIND_TO_NAME = {
    ["BLACKHOLE"]       = "Blackhole",
    ["ATM"]             = "ATM",
    ["ARCADE"]          = "Arcade",
    ["VALENTINES"]      = "Valentines",
    ["DOOM"]            = "Doom",
    ["FIREANDICE"]      = "FireAndIce",
    ["PHANTOMSUMMONER"] = "PhantomSummoner",
	["LUCKYCLOVER"] = "LuckyClover",
	["CARNIVAL"] = "Carnival",
}

local function machineHasPet(machine)
    if not machine then return false end
    local main = machine:FindFirstChild("Main")
    if not main then return false end
    local billboard = main:FindFirstChild("Billboard")
    if not billboard then return false end
    local gui = billboard:FindFirstChild("BillboardGui")
    if not gui then return false end
    local frame = gui:FindFirstChild("Frame")
    if not frame then return false end
    local brainrots = frame:FindFirstChild("Brainrots")
    if not brainrots then return false end
    return brainrots:FindFirstChild("Line_1") ~= nil
end

local function machineHas2Pets(machine)
    if not machine then return false end
    local main = machine:FindFirstChild("Main")
    if not main then return false end
    local billboard = main:FindFirstChild("Billboard")
    if not billboard then return false end
    local gui = billboard:FindFirstChild("BillboardGui")
    if not gui then return false end
    local frame = gui:FindFirstChild("Frame")
    if not frame then return false end
    local brainrots = frame:FindFirstChild("Brainrots")
    if not brainrots then return false end
    return brainrots:FindFirstChild("Line_2") ~= nil
end

local function getHeldPetName()
    local player = game:GetService("Players").LocalPlayer
    local char = player.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local debris = game:GetService("Workspace"):FindFirstChild("Debris")
    if not debris then return nil end

    local closestPet = nil
    local closestDist = math.huge

    for _, obj in ipairs(debris:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name == "BillboardTemplate" then
            local gui = obj:FindFirstChildWhichIsA("SurfaceGui") or obj:FindFirstChildWhichIsA("BillboardGui")
            if gui then
                local nameLabel = gui:FindFirstChild("BrainrotName", true)
                if nameLabel then
                    local distance = (hrp.Position - obj.Position).Magnitude
                    if distance < closestDist then
                        closestDist = distance
                        closestPet = nameLabel.Text
                    end
                end
            end
        end
    end

    return closestPet
end

-- ==========================
-- Machine Positions
-- ==========================
local MACHINE_POSITIONS = {
    ["ATM"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
    ["BLACKHOLE"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
    ["ARCADE"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
    ["VALENTINES"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
    ["DOOM"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
    ["FIREANDICE"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
    ["PHANTOMSUMMONER"] = Vector3.new(894.1641235351562, 3.307554006576538, 5.001921653747559),
	["LUCKYCLOVER"] = Vector3.new(895.1651611328125, 3.242981195449829, 2.0569493770599365),
	["CARNIVAL"] = Vector3.new(895.1651611328125, 3.242981195449829, 2.0569493770599365)
}

local function getSelectedPetsList()
    local selectedBrainrots = _G.SelectedBrainrots or {}
    local selectedSizes = _G.SelectedSizes or {}

    if #selectedBrainrots == 0 then selectedBrainrots = brainrotList end
    if #selectedSizes == 0 then selectedSizes = brainrotsSizes end

    local validPets = {}
    for _, brainrot in ipairs(selectedBrainrots) do
        for _, size in ipairs(selectedSizes) do
            if size == "Normal" then
                table.insert(validPets, brainrot)
            else
                table.insert(validPets, size .. " " .. brainrot)
            end
        end
    end
    return validPets
end

local function isSelectedPetEquipped()
    local validPets = getSelectedPetsList()
    local held = getHeldPetName()
    if not held then return false end
    for _, pet in ipairs(validPets) do
        if held:lower() == pet:lower() then return true end
    end
    return false
end

-- ==========================
-- Auto Equip Function
-- ==========================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local delayBetweenEquip = 0.35

local function autoEquipPet()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local backpack = player:WaitForChild("Backpack")

    local tools = {}
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then table.insert(tools, tool) end
    end

    for _, tool in ipairs(tools) do
        if tool and tool.Parent == backpack then
            humanoid:EquipTool(tool)
            task.wait(delayBetweenEquip)
            local heldPet = getHeldPetName()
            if heldPet then
                for _, valid in ipairs(getSelectedPetsList()) do
                    if heldPet:lower() == valid:lower() then return end
                end
            end
        end
    end
end

-- ==========================
-- Platform Helper
-- ==========================
local currentPlatform = nil

local function createPlatformAt(pos)
    if currentPlatform and currentPlatform.Parent then
        currentPlatform:Destroy()
    end
    local platform = Instance.new("Part")
    platform.Name = "MachinePlatform"
    platform.Size = Vector3.new(20, 1, 20)
    platform.Position = Vector3.new(pos.X, pos.Y - 2.5, pos.Z)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Transparency = 1
    platform.Parent = workspace
    currentPlatform = platform
end

local function removePlatform()
    if currentPlatform and currentPlatform.Parent then
        currentPlatform:Destroy()
        currentPlatform = nil
    end
end

-- ==========================
-- Spawn Remote
-- ==========================
local SpawnMachineRemote = game:GetService("ReplicatedStorage")
    :WaitForChild("Shared"):WaitForChild("Remotes")
    :WaitForChild("Networking"):WaitForChild("RF/SpawnMachineAction")

local lastDeposit = 0

-- ==========================
-- Auto Machine Loop
-- ==========================
local function startAutoMachineLoop()
    task.spawn(function()
        while _G.AutoMachine do
            task.wait(0.15)
            local machine, kind = getMachine()
            if not machine then continue end

            local char = player.Character
            if not char then continue end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end

            local selectedMachines = _G.SelectedMachines or {}
            if #selectedMachines == 0 then
                selectedMachines = {"Carnival","LuckyClover","PhantomSummoner","FireAndIce","ATM","Arcade","Blackhole","Valentines","Doom"}
            end

            local machineAllowed = false
            for _, m in ipairs(selectedMachines) do
                if string.find(string.upper(kind), string.upper(m)) then
                    machineAllowed = true
                    break
                end
            end
            if not machineAllowed then continue end

            -- ✅ Check event is active for this machine
            local friendlyName = KIND_TO_NAME[kind]
            if not friendlyName or not isMachineEventActive(friendlyName) then
                task.wait(1)
                continue
            end

            -- Withdraw
            if machineHas2Pets(machine) then
                pcall(function()
                    SpawnMachineRemote:InvokeServer("Withdraw", machine)
                end)
                task.wait(0.2)
            end

            -- ✅ Teleport + Deposit
            if isSelectedPetEquipped() then
                local pos = MACHINE_POSITIONS[kind]
                if pos then
                    hrp.CFrame = CFrame.new(pos)
                end

                if not machineHasPet(machine) and tick() - lastDeposit > 1 then
                    lastDeposit = tick()
                    pcall(function()
                        SpawnMachineRemote:InvokeServer("Deposit", machine)
                    end)
                end
            end

            -- Combine
            pcall(function()
                SpawnMachineRemote:InvokeServer("Combine", machine)
            end)
        end
    end)
end

-- ==========================
-- God Mode
-- ==========================
local function enableGodMode()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.BreakJointsOnDeath = false
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    game:GetService("RunService").Heartbeat:Connect(function()
        if humanoid and humanoid.Parent then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

-- ==========================
-- GUI Toggles
-- ==========================
_G.AutoEquip = false
local toggleEquip = main:Toggle("Auto Equip Brainrots", false, function(equipToggle)
    _G.AutoEquip = equipToggle
    if equipToggle then
        task.spawn(function()
            while _G.AutoEquip do
                local machine, kind = getMachine()
                local friendlyName = KIND_TO_NAME[kind or ""]
                local selectedMachines = _G.SelectedMachines or {}

                if machine and kind and kind ~= "DEFAULT" and friendlyName then
                    -- ✅ Only equip if event is active for this machine
                    local isAllowed = false
                    for _, m in ipairs(selectedMachines) do
                        if string.upper(kind) == string.upper(m) then
                            isAllowed = true
                            break
                        end
                    end

                    if isAllowed and isMachineEventActive(friendlyName) then
                        autoEquipPet()
                    end
                end

                task.wait(0.35)
            end
        end)
    end
end)

_G.AutoMachine = false
local toggleMachine = main:Toggle("Auto Machines", false, function(machineToggle)
    _G.AutoMachine = machineToggle
    if machineToggle then
        startAutoMachineLoop()
        enableGodMode()
    end
end)
    
    main:Line()
    main:Label(""):Refresh("Others")
    local speedList =
    {
        "10",
        "1"
    }

    local coinsList =
    {
        "All",
        "Galaxy",
        "Magma",
        "Arcade",
        "Doom",
        "FireAndIce",
        "Money",
        "Radioactive",
        "UFO",
        "Valentines",
        "Phantom"
    }

    local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function getRemote(name)
	return ReplicatedStorage:FindFirstChild(name, true)
end

local UpgradeSpeedRemote = getRemote("UpgradeSpeed")
local RebirthRemote = getRemote("Rebirth")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local Networking = ReplicatedStorage
	:WaitForChild("Shared")
	:WaitForChild("Remotes")
	:WaitForChild("Networking")

local Remote = Networking:WaitForChild("RF/PlotAction")

_G.AutoCollect = false
local cachedBaseUUID = nil

local function getBaseUUID()
	if cachedBaseUUID then
		return cachedBaseUUID
	end
	
	for _, base in pairs(Workspace:WaitForChild("Bases"):GetChildren()) do
		local title = base:FindFirstChild("Title")
		if title then
			local titleGui = title:FindFirstChild("TitleGui")
			if titleGui then
				local frame = titleGui:FindFirstChild("Frame")
				if frame and frame:FindFirstChild("PlayerName") then
					
					local nameText = frame.PlayerName.Text
					
					if nameText == player.DisplayName or nameText == player.Name then
						cachedBaseUUID = base.Name
						print("Cached Base UUID:", cachedBaseUUID)
						return cachedBaseUUID
					end
				end
			end
		end
	end
	
	return nil
end

_G.AutoSpeed = false
_G.AutoRebirth = false
_G.SelectedSpeed = {}

    speedlistDropdown = main:MultiDropdown("Select Speed", speedList, function(selectedItems)
        print("Selected Speed:")
        for i, selectSpeed in ipairs(selectedItems) do
            print(i, selectSpeed)
        end
        _G.SelectedSpeed = selectedItems
    end)
    
local toggleSpeed = main:Toggle("Auto Buy Speed", false, function(autospeedFunc)
			if autospeedFunc == true then
				_G.AutoSpeed = true
			elseif autospeedFunc == false or destroygui then
				_G.AutoSpeed = false
			end
    end)

    -- AUTO REBIRTH
local toggleRebirth = main:Toggle("Auto Rebirth", false, function(autorebirthFunc)
			if autorebirthFunc == true then
				_G.AutoRebirth = true
			elseif autorebirthFunc == false or destroygui then
				_G.AutoRebirth = false
			end
    end)

    -- AUTO COLLECT (ALL)
local toggleCollect = main:Toggle("Auto Collect", false, function(autocollectFunc)
			if autocollectFunc == true then
				_G.AutoCollect = true
			elseif autocollectFunc == false or destroygui then
				_G.AutoCollect = false
			end
    end)
    -- AUTO UPGRADE BRAINROTS (ALL)
local toggleUpgrade = main:Toggle("Auto Upgrade All", false, function(autoupgradeFunc)
			if autoupgradeFunc == true then
				_G.AutoUpgrade = true
			elseif autoupgradeFunc == false or destroygui then
				_G.AutoUpgrade = false
			end
    end)
    main:Line()

    coinListDropdown = main:MultiDropdown("Select Coins", coinsList, function(selectedItems)
        print("Selected Coins:")
        for i, coinsList in ipairs(selectedItems) do
            print(i, coinsList)
        end
        _G.CoinsList = selectedItems
    end)

local toggleCoins = main:Toggle("Auto Collect Coins", false, function(autocollectCoins)
			if autocollectCoins == true then
				_G.AutoCollectCoins = true
			elseif autocollectCoins == false or destroygui then
				_G.AutoCollectCoins = false
			end
    end)

    task.spawn(function()
	task.wait(5)
	
	while task.wait(1) do
		if _G.AutoCollect then
			
			local baseUUID = getBaseUUID()
			
			if not baseUUID then
				warn("Base UUID not found!")
				continue
			end
			
			for slot = 1, 40 do
				if not _G.AutoCollect then
					break
				end
				
				pcall(function()
					Remote:InvokeServer("Collect Money", baseUUID, tostring(slot))
				end)
				
				task.wait(0.2)
			end
			
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		if _G.AutoUpgrade then
			
			local baseUUID = getBaseUUID()
			if not baseUUID then
				warn("Base UUID not found!")
				continue
			end
			
			for slot = 1, 40 do
				if not _G.AutoUpgrade then
					break
				end
				
				pcall(function()
					Remote:InvokeServer("Upgrade Brainrot", baseUUID, tostring(slot))
				end)
				
				task.wait(0.05)
			end
			
		end
	end
end)

    task.spawn(function()
	while task.wait(0.1) do
		if _G.AutoSpeed and UpgradeSpeedRemote then
			
			if _G.SelectedSpeed and #_G.SelectedSpeed > 0 then
				for _, speedValue in ipairs(_G.SelectedSpeed) do
					pcall(function()
						UpgradeSpeedRemote:InvokeServer(tonumber(speedValue))
					end)
				end
			end
			
		end
	end
end)

task.spawn(function()
	while task.wait(1) do
		if _G.AutoRebirth and RebirthRemote then
			pcall(function()
				RebirthRemote:InvokeServer()
			end)
		end
	end
end)


    -- PLAYERS TAB
local SelectedKillPlayer = nil
local Spectate = false

local PlayerName = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(PlayerName, v.Name)
end
local Players = serv:Channel("Players","http://www.roblox.com/asset/?id=7252023075")

local SelectPlayer = Players:Dropdown("Selected Player", PlayerName, function(vu)
    SelectedKillPlayer = vu
end)

Players:Button("Refresh Player", function()
    local newList = {}
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            table.insert(newList, v.Name)
        end
    end
    -- Clear and rebuild dropdown
    SelectPlayer:Clear()
    for i, name in ipairs(newList) do
        SelectPlayer:Add(name)
    end
end)

Players:Toggle("Spectate Player", false, function(vu)
    Spectate = vu
    if Spectate and SelectedKillPlayer then
        local targetPlayer = game.Players:FindFirstChild(SelectedKillPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
            game.Workspace.Camera.CameraSubject = targetPlayer.Character.Humanoid
        end
    else
        Spectate = false
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Workspace.Camera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
        end
    end
end)

Players:Line()

Players:Slider("WalkSpeed", 30, 1000, 16, function(t)
    if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = t
    end
end)

Players:Slider("Jump Power", 80, 1000, 50, function(t)
    if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = t
    end
end)

Players:Slider("Gravity", 0, 500, 196, function(t)
    workspace.Gravity = t
end)

local Trade = serv:Channel("Trade","http://www.roblox.com/asset/?id=7044284832")
local SelectedKillPlayer = nil
local Spectate = false
_G.AutoTrade = false
_G.AutoInsertPet = false
_G.AutoAccept = false
_G.AutoAcceptRequest = false

local PlayerName = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do
    table.insert(PlayerName, v.Name)
end


local SelectPlayer = Trade:Dropdown("Selected Player", PlayerName, function(vu)
    SelectedKillPlayer = vu
end)

Trade:Button("Refresh Player", function()
    local newList = {}
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            table.insert(newList, v.Name)
        end
    end
    -- Clear and rebuild dropdown
    SelectPlayer:Clear()
    for i, name in ipairs(newList) do
        SelectPlayer:Add(name)
    end
end)

local insertpetList = { "8","7","6","5","4","3","2","1" }

local insertpetDropdown = Trade:Dropdown("Select Pet Count", insertpetList, function(selectedItems)
    local rawValue

    -- Make sure we get the first selected item as a number
    if type(selectedItems) == "table" then
        rawValue = tonumber(selectedItems[1])
    else
        rawValue = tonumber(selectedItems)
    end

    if not rawValue then
        rawValue = 1
    end

    -- Adjust by +1 to match internal slot logic
    _G.SelectPetNumber = rawValue + 1
    print("[AUTO TRADE] Selected Pet Count (adjusted):", _G.SelectPetNumber)
end)

Trade:Toggle("Auto Insert Pet", false, function(v)
    _G.AutoInsertPet = v
end)

Trade:Toggle("Auto Trade", false, function(v)
    _G.AutoTrade = v
end)

Trade:Toggle("Auto Accept", false, function(v)
    _G.AutoAccept = v
end)

Trade:Toggle("Auto Accept Request", false, function(v)
    _G.AutoAcceptRequest = v
end)

--// =========================
--// SERVICES
--// =========================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")

--// =========================
--// REMOTES
--// =========================
local Net = ReplicatedStorage.Shared.Remotes:FindFirstChild("Networking")
local SendTrade = Net and Net:FindFirstChild("RF/TradeSendTrade")
local SetSlot = Net and Net:FindFirstChild("RF/TradeSetSlotOffer")
local ReadyTrade = Net and Net:FindFirstChild("RE/Trading/TradeReadyTrade")
local RespondTrade = Net and Net:FindFirstChild("RF/TradeRespondToOffer")

--// =========================
--// PET INSERT (ONCE)
--// =========================
local petsInserted = false

local function insertPetsOnce()
    local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("Menus")
    if not tradeGui then return end

    local trade = tradeGui:FindFirstChild("Trade")
    if not trade or not trade.Visible then return end
    if petsInserted then return end

    petsInserted = true

    task.spawn(function()
        -- REQUIRED delay so slots exist
        task.wait(1)
        print("[AUTO TRADE] inserting pets")

        local maxPets = _G.SelectPetNumber or 9
        local slot = 1

        for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                if SetSlot then
                    pcall(function()
                        SetSlot:InvokeServer(tostring(slot), tool.Name)
                    end)
                else
                    print("[AUTO TRADE] SetSlot remote not found, skipping slot insert")
                end
                slot += 1
                task.wait(0.05)
                if slot > maxPets then break end
            end
        end
    end)
end

-- Reset petsInserted whenever a new trade GUI opens
task.spawn(function()
    local lastVisible = false
    while task.wait(0.2) do
        local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("Menus")
        local trade = tradeGui and tradeGui:FindFirstChild("Trade")
        local visible = trade and trade.Visible or false

        if visible and not lastVisible then
            -- New trade just opened
            petsInserted = false
            print("[AUTO TRADE] New trade detected → reset petsInserted")
        end

        lastVisible = visible
    end
end)

task.spawn(function()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    local function hook(gui)
        gui.DescendantAdded:Connect(function(v)
            if v:IsA("TextLabel") and v.Text == "Trade Completed!" then
                petsInserted = false
            end
        end)
    end

    for _,g in ipairs(playerGui:GetChildren()) do
        if g:IsA("ScreenGui") then
            hook(g)
        end
    end

    playerGui.ChildAdded:Connect(function(g)
        if g:IsA("ScreenGui") then
            hook(g)
        end
    end)
end)

local function allSlotsFilled()
    local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("Menus")
    local trade = tradeGui and tradeGui:FindFirstChild("Trade")
    if not trade or not trade.Visible then return false end

    local offer = trade:FindFirstChild("GiveOffer")
    local scroll = offer and offer:FindFirstChild("ScrollingFrame")
    local frame = scroll and scroll:FindFirstChild("Frame")
    if not frame then return false end

    for _,slot in ipairs(frame:GetChildren()) do
        if slot:IsA("Frame") then
            local btn = slot:FindFirstChild("ImageButton")
            if btn and (not btn:FindFirstChild("NameLabel") or btn.NameLabel.Text == "") then
                return false
            end
        end
    end
    return true
end

local acceptFired = false

local function tryAcceptTrade()
    local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("Menus")
    local trade = tradeGui and tradeGui:FindFirstChild("Trade")
    if not trade or not trade.Visible then return end

    local accept = trade:FindFirstChild("Accept")
    local label = accept and accept:FindFirstChild("TextLabel")

    if label and label.Text == "Accept" and not acceptFired then
        acceptFired = true
        for i = 1, 20 do
            ReadyTrade:FireServer(true, i)
            task.wait(0.1)
        end
    end
end

task.spawn(function()
    while task.wait(0.35) do
        local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("Menus")
        local trade = tradeGui and tradeGui:FindFirstChild("Trade")
        local tradeVisible = trade and trade.Visible

        -- Auto Trade
        if _G.AutoTrade and SelectedKillPlayer and not tradeVisible then
            local plr = Players:FindFirstChild(SelectedKillPlayer)
            if plr then
                pcall(function()
                    SendTrade:InvokeServer(plr)
                end)
            end
        end

        -- Insert Pets
        if _G.AutoInsertPet and tradeVisible then
            insertPetsOnce()
        end

        -- Auto Accept
        if _G.AutoAccept and tradeVisible and allSlotsFilled() then
            tryAcceptTrade()
        end

        -- Auto Accept Requests
        if _G.AutoAcceptRequest and SelectedKillPlayer then
            local plr = Players:FindFirstChild(SelectedKillPlayer)
            if plr then
                pcall(function()
                    RespondTrade:InvokeServer(tostring(plr.UserId), true)
                end)
            end
        end
    end
end)

task.spawn(function()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")

    local function hook(gui)
        gui.DescendantAdded:Connect(function(v)
            if v:IsA("TextLabel") and v.Text == "Trade Completed!" then
                petsInserted = false
                acceptFired = false
                print("[AUTO TRADE] Reset after trade")
            end
        end)
    end

    for _,g in ipairs(playerGui:GetChildren()) do
        if g:IsA("ScreenGui") then
            hook(g)
        end
    end

    playerGui.ChildAdded:Connect(function(g)
        if g:IsA("ScreenGui") then
            hook(g)
        end
    end)
end)

local Other = serv:Channel("Other","http://www.roblox.com/asset/?id=7040410130")
Other:Label(""):Refresh("Webhook")

--// =========================
-- SERVICES
--// =========================
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

--// =========================
-- GLOBAL STATE (UI CONTROLLED)
--// =========================
_G.InventoryTrackerEnabled = false
_G.WebhookURL = ""
_G.WebhookInterval = 16 -- minutes (default slider)
_G.LastWebhookTime = 0

--// =========================
-- UI ELEMENTS (YOUR LIBRARY)
--// =========================

-- Webhook TextBox
Other:TextBox(
	"Webhook URL",
	"Enter your webhook",
	function(val)
		_G.WebhookURL = val
		print("Webhook set to:", val)
	end,
	"",
	false
)

-- Interval Slider (Minutes)
Other:Slider("Minutes", 10, 60, 16, function(v)
	_G.WebhookInterval = v
	print("Interval set to:", v, "minutes")
end)

-- Inventory Tracker Toggle
Other:Toggle("Inventory Tracker", false, function(v)
	_G.InventoryTrackerEnabled = v

	if v then
		sendInventoryEmbeds(_G.WebhookURL)
		_G.LastWebhookTime = tick()
	end
end)

local lastTest = 0

Other:Button("Test Webhook", function()
	if tick() - lastTest < 5 then
		warn("Please wait before testing again")
		return
	end
	lastTest = tick()

	if not _G.WebhookURL or _G.WebhookURL == "" then
		warn("Webhook URL is empty")
		return
	end

	sendInventoryEmbeds(_G.WebhookURL)
end)

--// =========================
-- INVENTORY GUI PATHS
--// =========================
local backpackGui = player.PlayerGui:WaitForChild("BackpackGui")
local backpack = backpackGui:WaitForChild("Backpack")
local hotbar = backpack:WaitForChild("Hotbar")
local inventory = backpack:WaitForChild("Inventory")
local inventoryGrid = inventory:WaitForChild("ScrollingFrame"):WaitForChild("UIGridFrame")
local bagCountLabel = inventory:WaitForChild("BagCountLabel")

--// =========================
-- WHITELIST
--// =========================
local allowedBrainrots = {
    ["Dutchmello Velerino"] = true,
	["Freezeti Cobretti"] = true,
	["Glacierello Infernetti"] = true,
	["Galactio Fantasma"] = true,
	["Cupitron Consoletron"] = true,
	["Biscotti Macarotti"] = true,
    ["Crostina Gelifio"] = true,
}

--// =========================
-- HELPERS
--// =========================
local function stripRichText(text)
	return text:gsub("<[^>]->", "")
end

local function extractMutation(text)
	return text:match("<font.-?>(.-)</font>")
end

local function detectSize(text)
	local mult = tonumber(text:match("(%d+%.?%d*)x")) or 0
	if mult >= 2.0 then return "Colossal"
	elseif mult >= 1.5 then return "Big"
	elseif mult >= 1.0 then return "Medium"
	else return "Small" end
end

local function getExecutorHWID()
	if gethwid then
		return gethwid()
	end
	return "Unknown"
end

--// =========================
-- PROCESS SLOT
--// =========================
local function processSlot(slot)
	local attribute = slot:FindFirstChild("AttributeLabel")
	local level = slot:FindFirstChild("LevelLabel")
	local toolName = slot:FindFirstChild("ToolName")
	if not (attribute and level and toolName) then return nil end

	local sizeText = attribute.Text or ""
	local levelText = (level.Text or ""):gsub("Lvl%.", "Lv.")
	local rawName = toolName.Text or ""

	local mutation = extractMutation(rawName)
	local cleanName = stripRichText(rawName)
	if mutation then cleanName = cleanName:gsub(mutation, "") end
	cleanName = cleanName:gsub("^%s+", ""):gsub("%s+$", "")

	if cleanName:find("Basic Bat", 1, true) then return nil end

	local allowed = false
	for name in pairs(allowedBrainrots) do
		if cleanName:find(name, 1, true) then
			allowed = true
			break
		end
	end
	if not allowed then return nil end

	if mutation then
		return sizeText .. " " .. mutation .. " " .. cleanName .. " " .. levelText
	end
	return sizeText .. " " .. cleanName .. " " .. levelText
end

--// =========================
-- COLLECT INVENTORY
--// =========================
local function collectInventory()
	local results = {}

	local function scan(container)
		for _, item in ipairs(container:GetChildren()) do
			local result = processSlot(item)
			if result then table.insert(results, result) end
		end
	end

	scan(hotbar)
	scan(inventoryGrid)

	table.sort(results, function(a, b)
		local order = {Colossal=4, Big=3, Medium=2, Small=1}
		return (order[detectSize(a)] or 0) > (order[detectSize(b)] or 0)
	end)

	return results
end

--// =========================
-- CALCULATE TOTALS
-- =========================
local function calculateTotals(list)
	local totals = {}
	for _, item in ipairs(list) do
		totals[item] = (totals[item] or 0) + 1
	end

	local summary = {}
	for name, count in pairs(totals) do
		table.insert(summary, name .. " - " .. count .. "x")
	end

	table.sort(summary)
	return summary
end

--// =========================
-- SEND WEBHOOK
--// =========================
function sendInventoryEmbeds(url)
	if not url or url == "" then return end

	local inventoryList = collectInventory()
	if #inventoryList == 0 then return end

	local totals = calculateTotals(inventoryList)
	local bagText = bagCountLabel.Text or "0/0"
	local hwid = getExecutorHWID()

	local content = table.concat(totals, "\n")

	local embed = {
		title = "✾ Ashh Inventory Tracker",
		color = 65280,
		fields = {
			{name="💼 Bag Capacity", value=bagText, inline=true},
			{name="👤 Username", value=player.Name, inline=true},
			{name="ⓘ UserId", value=tostring(player.UserId), inline=true},
			{name="⚙️ HWID", value=hwid, inline=false},
			{name="📦 Inventory", value="```"..content.."```", inline=false}
		},
		footer = {text="Ashleng on top"},
		timestamp = DateTime.now():ToIsoDate()
	}

	request({
		Url = url,
		Method = "POST",
		Headers = {["Content-Type"] = "application/json"},
		Body = HttpService:JSONEncode({embeds = {embed}})
	})
end

--// =========================
-- HEARTBEAT LOOP
--// =========================
spawn(function()
	while true do
		RunService.Heartbeat:Wait()

		if _G.InventoryTrackerEnabled
		and _G.WebhookURL ~= ""
		and tick() - (_G.LastWebhookTime or 0) >= (_G.WebhookInterval * 60) then

			sendInventoryEmbeds(_G.WebhookURL)
			_G.LastWebhookTime = tick()
		end
	end
end)

    -- Add more tabs/channels as needed
    local settings = serv:Channel("Settings", "http://www.roblox.com/asset/?id=7040347038")
    settings:Label(""):Refresh("Game")
    settings:Button("Reduce Lag", function()
        loadstring(game:HttpGet("https://pastebin.com/raw/f2YJBP8g"))()
    end)

-- ============================================================
--  CONFIG SYSTEM
--  Add this inside your Settings channel section
--  Replace SERVER_URL with your actual Railway URL
--  _G.UserKey must be set when the player validates their key
-- ============================================================

-- Forward declarations so applyConfig can access dropdowns defined in inner scopes
local speedlistDropdown
local coinListDropdown

local CONFIG_SERVER = "https://ashlenghub.up.railway.app"

-- Helper: collect all current toggle/dropdown states
local function collectConfig()
    return {
        AutoFarmBrainrots   = _G.AutoFarmBrainrots   or false,
        AutoFarmBlocks      = _G.AutoFarmBlocks      or false,
        AutoSacrifice       = _G.AutoSacrifice       or false,
        AutoPhantomOrbs     = _G.AutoPhantomOrbs     or false,
        AutoPhantomShards   = _G.AutoPhantomShards   or false,
        AutoTowerTrial      = _G.AutoTowerTrial      or false,
        AutoEquip           = _G.AutoEquip           or false,
        AutoMachine         = _G.AutoMachine         or false,
        AutoSpeed           = _G.AutoSpeed           or false,
        AutoRebirth         = _G.AutoRebirth         or false,
        AutoCollect         = _G.AutoCollect         or false,
        AutoUpgrade         = _G.AutoUpgrade         or false,
        AutoCollectCoins    = _G.AutoCollectCoins    or false,
        SelectedBrainrotRarity  = _G.SelectedBrainrotRarity  or {},
        SelectedLuckyBlockRarity = _G.SelectedLuckyBlockRarity or {},
        SelectedCarryAmount = _G.SelectedCarryAmount or 1,
        SelectedBrainrots   = _G.SelectedBrainrots   or {},
        SelectedSizes       = _G.SelectedSizes       or {},
        SelectedMachines    = _G.SelectedMachines    or {},
        SelectedSpeed       = _G.SelectedSpeed       or {},
        CoinsList           = _G.CoinsList           or {},
        AutoRainbow         = _G.AutoRainbow         or false,
    }
end

local function applyConfig(cfg)
    _G.AutoFarmBrainrots        = cfg.AutoFarmBrainrots   or false
    _G.AutoFarmBlocks           = cfg.AutoFarmBlocks      or false
    _G.AutoSacrifice            = cfg.AutoSacrifice       or false
    _G.AutoPhantomOrbs          = cfg.AutoPhantomOrbs     or false
    _G.AutoPhantomShards        = cfg.AutoPhantomShards   or false
    _G.AutoTowerTrial           = cfg.AutoTowerTrial      or false
    _G.AutoEquip                = cfg.AutoEquip           or false
    _G.AutoMachine              = cfg.AutoMachine         or false
    _G.AutoSpeed                = cfg.AutoSpeed           or false
    _G.AutoRebirth              = cfg.AutoRebirth         or false
    _G.AutoCollect              = cfg.AutoCollect         or false
    _G.AutoUpgrade              = cfg.AutoUpgrade         or false
    _G.AutoCollectCoins         = cfg.AutoCollectCoins    or false
    _G.AutoRainbow              = cfg.AutoRainbow         or false
    _G.SelectedBrainrotRarity   = cfg.SelectedBrainrotRarity  or {}
    _G.SelectedLuckyBlockRarity = cfg.SelectedLuckyBlockRarity or {}
    _G.SelectedCarryAmount      = cfg.SelectedCarryAmount or 1
    _G.SelectedBrainrots        = cfg.SelectedBrainrots   or {}
    _G.SelectedSizes            = cfg.SelectedSizes       or {}
    _G.SelectedMachines         = cfg.SelectedMachines    or {}
    _G.SelectedSpeed            = cfg.SelectedSpeed       or {}
    _G.CoinsList                = cfg.CoinsList           or {}

    if toggleFarmBrainrots then toggleFarmBrainrots:Set(cfg.AutoFarmBrainrots or false) end
    if toggleFarmBlocks    then toggleFarmBlocks:Set(cfg.AutoFarmBlocks or false) end
    if toggleSacrifice     then toggleSacrifice:Set(cfg.AutoSacrifice or false) end
    if togglePhantomOrbs   then togglePhantomOrbs:Set(cfg.AutoPhantomOrbs or false) end
    if togglePhantomShards then togglePhantomShards:Set(cfg.AutoPhantomShards or false) end
    if toggleTowerTrial    then toggleTowerTrial:Set(cfg.AutoTowerTrial or false) end
    if toggleEquip         then toggleEquip:Set(cfg.AutoEquip or false) end
    if toggleMachine       then toggleMachine:Set(cfg.AutoMachine or false) end
    if toggleSpeed         then toggleSpeed:Set(cfg.AutoSpeed or false) end
    if toggleRebirth       then toggleRebirth:Set(cfg.AutoRebirth or false) end
    if toggleCollect       then toggleCollect:Set(cfg.AutoCollect or false) end
    if toggleUpgrade       then toggleUpgrade:Set(cfg.AutoUpgrade or false) end
    if toggleCoins         then toggleCoins:Set(cfg.AutoCollectCoins or false) end
    if toggleRainbow       then toggleRainbow:Set(cfg.AutoRainbow or false) end

    if brainrotrarityList  then brainrotrarityList:SetSelected(cfg.SelectedBrainrotRarity or {}) end
    if luckyblockrarityList then luckyblockrarityList:SetSelected(cfg.SelectedLuckyBlockRarity or {}) end
    if brainrotDropdown    then brainrotDropdown:SetSelected(cfg.SelectedBrainrots or {}) end
    if sizesList           then sizesList:SetSelected(cfg.SelectedSizes or {}) end
    if machinesLists       then machinesLists:SetSelected(cfg.SelectedMachines or {}) end
    if speedlistDropdown   then speedlistDropdown:SetSelected(cfg.SelectedSpeed or {}) end
    if coinListDropdown    then coinListDropdown:SetSelected(cfg.CoinsList or {}) end
end


settings:Line()
settings:Label(""):Refresh("Config System")

local configStatusLabel = settings:Label("")

settings:Button("Save Config", function()
    local key = _G.UserKey
    if not key or key == "" then
        configStatusLabel:Refresh("Status: No key found!")
        return
    end
    configStatusLabel:Refresh("Status: Saving...")
    local cfg = collectConfig()
    local HttpService = game:GetService("HttpService")
    local encoded = HttpService:JSONEncode(cfg)
    local ok, result = pcall(function()
        return request({
            Url = CONFIG_SERVER .. "/config/save",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({ key = key, configData = encoded })
        })
    end)
    if ok and result and result.Body then
        local data
        pcall(function() data = HttpService:JSONDecode(result.Body) end)
        if data and data.success then
            configStatusLabel:Refresh("Status: ✅ Config saved!")
        else
            configStatusLabel:Refresh("Status: ❌ " .. (data and data.message or "Error"))
        end
    else
        configStatusLabel:Refresh("Status: ❌ Request failed")
    end
end)

settings:Button("Load Config", function()
    local key = _G.UserKey
    if not key or key == "" then
        configStatusLabel:Refresh("Status: No key found!")
        return
    end
    configStatusLabel:Refresh("Status: Loading...")
    local HttpService = game:GetService("HttpService")
    local ok, result = pcall(function()
        return request({
            Url = CONFIG_SERVER .. "/config/get?key=" .. key,
            Method = "GET",
        })
    end)
    if ok and result and result.Body then
        local data
        pcall(function() data = HttpService:JSONDecode(result.Body) end)
        if data and data.success and data.configData then
            local cfg
            pcall(function() cfg = HttpService:JSONDecode(data.configData) end)
            if cfg then
                applyConfig(cfg)
                configStatusLabel:Refresh("Status: ✅ Config loaded!")
            else
                configStatusLabel:Refresh("Status: ❌ Failed to parse config")
            end
        else
            configStatusLabel:Refresh("Status: ❌ " .. (data and data.message or "No config saved yet"))
        end
    else
        configStatusLabel:Refresh("Status: ❌ Request failed")
    end
end)

task.spawn(function()
    task.wait(3)
    local key = _G.UserKey
    if not key or key == "" then return end
    local HttpService = game:GetService("HttpService")
    local ok, result = pcall(function()
        return request({
            Url = CONFIG_SERVER .. "/config/get?key=" .. key,
            Method = "GET",
        })
    end)
    if ok and result and result.Body then
        local data
        pcall(function() data = HttpService:JSONDecode(result.Body) end)
        if data and data.success and data.configData then
            local cfg
            pcall(function() cfg = HttpService:JSONDecode(data.configData) end)
            if cfg then
                applyConfig(cfg)
                configStatusLabel:Refresh("Status: ✅ Auto-loaded config!")
            end
        end
    end
end)
    
    local ProximityPromptService = game:GetService("ProximityPromptService")

for _, prompt in ipairs(workspace:GetDescendants()) do
    if prompt:IsA("ProximityPrompt") then
        prompt.HoldDuration = 0
    end
end

workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        descendant.HoldDuration = 0
    end
end)

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer

player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

print("✅ Anti-AFK enabled")
    
    warn("Ashleng on Top!")
    warn("Press " .. tostring(_G.Toggle) .. " to toggle GUI")
end

-- ===============================
-- AZRAHUB FLOATING TOGGLE BUTTON
-- (Non-Following Version)
-- ===============================

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Remove old toggle if exists
local old = CoreGui:FindFirstChild("AZRAHUB_Toggle")
if old then old:Destroy() end

-- Wait for main GUI
local mainGui = CoreGui:WaitForChild("AZRAHUB GUI", 10)
if not mainGui then return end

local mainFrame = mainGui:WaitForChild("MainFrame", 10)
if not mainFrame then return end

-- Create ScreenGui
local ToggleGui = Instance.new("ScreenGui")
ToggleGui.Name = "AZRAHUB_Toggle"
ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleGui.Parent = CoreGui

-- Create Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 60, 0, 60)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Parent = ToggleGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 30)
FrameCorner.Parent = Frame

-- Create Button
local Button = Instance.new("ImageButton")
Button.Size = UDim2.new(1, 0, 1, 0)
Button.BackgroundTransparency = 1
Button.BorderSizePixel = 0
Button.Image = "rbxassetid://111288454784622"
Button.AutoButtonColor = false
Button.Parent = Frame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 30)
ButtonCorner.Parent = Button

-- ===============================
-- INITIAL POSITION (Above Main)
-- ===============================

task.wait() -- ensure GUI is rendered

Frame.Position = UDim2.new(
	0,
	mainFrame.AbsolutePosition.X + (mainFrame.AbsoluteSize.X / 2) - 30,
	0,
	mainFrame.AbsolutePosition.Y - 70
)

-- ===============================
-- TOGGLE LOGIC
-- ===============================

local guiVisible = true

Button.MouseButton1Click:Connect(function()
	guiVisible = not guiVisible
	mainGui.Enabled = guiVisible
end)

-- ===============================
-- DRAG SYSTEM
-- ===============================

local dragging = false
local dragStart, startPos

Button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local backpack = player.Backpack

local function removeItem(item)
	local tooltip = item:GetAttribute("ToolTip") or (item:FindFirstChild("ToolTip") and item.ToolTip.Value)
	
	-- Also check the ToolTip property directly
	local ok, tip = pcall(function() return item.ToolTip end)
	
	if ok and (tip == "Basic Bat" or tip == "Sign") then
		item:Destroy()
	end
end

-- Check existing items
for _, item in ipairs(backpack:GetChildren()) do
	removeItem(item)
end

-- Watch for new items added
backpack.ChildAdded:Connect(function(item)
	removeItem(item)
end)

-- Also handle when character respawns (backpack resets)
player.CharacterAdded:Connect(function()
	task.wait(1) -- slight delay for backpack to populate
	for _, item in ipairs(backpack:GetChildren()) do
		removeItem(item)
	end
end)
print("Basic Bat and Sign Deleted!")
