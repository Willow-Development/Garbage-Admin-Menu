local player = game.Players.LocalPlayer
local ChatService = game:GetService("Chat")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

if player.Name == "LockedCorrection" then
	local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
	local menuFrame = Instance.new("Frame")
	menuFrame.Size = UDim2.new(0, 300, 0, 250)
	menuFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
	menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	menuFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	menuFrame.BorderSizePixel = 0
	menuFrame.Visible = false
	menuFrame.Parent = screenGui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 40)
	title.Position = UDim2.new(0, 0, 0, 0)
	title.Text = "Admin Menu"
	title.TextColor3 = Color3.new(1, 1, 1)
	title.TextScaled = true
	title.Font = Enum.Font.SourceSansBold
	title.BackgroundTransparency = 1
	title.Parent = menuFrame

	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0, 30, 0, 30)
	closeButton.Position = UDim2.new(1, -40, 0, 0)
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.new(1, 0, 0)
	closeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	closeButton.Parent = menuFrame

	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Size = UDim2.new(0, 30, 0, 30)
	minimizeButton.Position = UDim2.new(1, -80, 0, 0)
	minimizeButton.Text = "-"
	minimizeButton.TextColor3 = Color3.new(1, 1, 0)
	minimizeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	minimizeButton.Parent = menuFrame

	local usernameInput = Instance.new("TextBox")
	usernameInput.Size = UDim2.new(0, 250, 0, 40)
	usernameInput.Position = UDim2.new(0.5, -125, 0.2, 0)
	usernameInput.PlaceholderText = "Enter Username"
	usernameInput.TextColor3 = Color3.new(1, 1, 1)
	usernameInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	usernameInput.Parent = menuFrame

	local cageButton = Instance.new("TextButton")
	cageButton.Size = UDim2.new(0, 250, 0, 40)
	cageButton.Position = UDim2.new(0.5, -125, 0.4, 0)
	cageButton.Text = "Cage Player"
	cageButton.TextColor3 = Color3.new(1, 1, 1)
	cageButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	cageButton.Parent = menuFrame

	local killButton = Instance.new("TextButton")
	killButton.Size = UDim2.new(0, 250, 0, 40)
	killButton.Position = UDim2.new(0.5, -125, 0.6, 0)
	killButton.Text = "Kill Player"
	killButton.TextColor3 = Color3.new(1, 1, 1)
	killButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	killButton.Parent = menuFrame

	local teleportButton = Instance.new("TextButton")
	teleportButton.Size = UDim2.new(0, 250, 0, 40)
	teleportButton.Position = UDim2.new(0.5, -125, 0.8, 0)
	teleportButton.Text = "Teleport to Player"
	teleportButton.TextColor3 = Color3.new(1, 1, 1)
	teleportButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	teleportButton.Parent = menuFrame

	local dragging, dragStart, startPos

	local function updateInput(input)
		if dragging then
			local delta = input.Position - dragStart
			menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end

	title.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = menuFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(updateInput)

	local openButton = Instance.new("TextButton")
	openButton.Size = UDim2.new(0, 200, 0, 50)
	openButton.Position = UDim2.new(0, 0, 0.5, 0)
	openButton.Text = "Open Admin Menu"
	openButton.TextColor3 = Color3.new(1, 1, 1)
	openButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
	openButton.Parent = screenGui

	openButton.MouseButton1Click:Connect(function()
		menuFrame.Visible = true
		openButton.Visible = false
		ChatService:Chat(player.Character.Head, "Welcome Developer", Enum.ChatColor.Blue)

		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.MaxHealth = math.huge
			humanoid.Health = math.huge
		end
	end)

	closeButton.MouseButton1Click:Connect(function()
		menuFrame.Visible = false
		openButton.Visible = true
		ChatService:Chat(player.Character.Head, "Goodbye Developer", Enum.ChatColor.Red)

		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.MaxHealth = 100
			humanoid.Health = 100
		end
	end)

	minimizeButton.MouseButton1Click:Connect(function()
		menuFrame.Visible = false
		openButton.Visible = true

		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.MaxHealth = 100
			humanoid.Health = 100
		end
	end)

	local function handleCommand(command, username)
		local targetPlayer = Players:FindFirstChild(username)

		if targetPlayer and targetPlayer.Name == "LockedCorrection" then
			ChatService:Chat(player.Character.Head, "Error: You cannot use commands on an admin.", Enum.ChatColor.Red)
			return false
		end

		return targetPlayer
	end

	cageButton.MouseButton1Click:Connect(function()
		local username = usernameInput.Text
		local targetPlayer = handleCommand("Cage", username)

		if targetPlayer and targetPlayer.Character then
			local cage = Instance.new("Part")
			cage.Size = Vector3.new(5, 10, 5)
			cage.Position = targetPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0)
			cage.Anchored = true
			cage.CanCollide = true
			cage.BrickColor = BrickColor.new("Bright red")
			cage.Material = Enum.Material.Neon
			cage.Transparency = 0.5
			cage.Parent = workspace

			local roof = cage:Clone()
			roof.Size = Vector3.new(5, 1, 5)
			roof.Position = cage.Position + Vector3.new(0, 5, 0)
			roof.Parent = workspace

			ChatService:Chat(player.Character.Head, "Caged " .. username .. ".", Enum.ChatColor.Green)
		elseif targetPlayer == false then
		else
			ChatService:Chat(player.Character.Head, "Player not found or not in the game.", Enum.ChatColor.Red)
		end
	end)

	killButton.MouseButton1Click:Connect(function()
		local username = usernameInput.Text
		local targetPlayer = handleCommand("Kill", username)

		if targetPlayer and targetPlayer.Character then
			local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				humanoid.Health = 0
				ChatService:Chat(player.Character.Head, "Killed " .. username .. ".", Enum.ChatColor.Green)
			end
		elseif targetPlayer == false then
		else
			ChatService:Chat(player.Character.Head, "Player not found or not in the game.", Enum.ChatColor.Red)
		end
	end)

	teleportButton.MouseButton1Click:Connect(function()
		local username = usernameInput.Text
		local targetPlayer = handleCommand("Teleport", username)

		if targetPlayer and targetPlayer.Character and player.Character then
			player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
			ChatService:Chat(player.Character.Head, "Teleported to " .. username .. ".", Enum.ChatColor.Green)
		elseif targetPlayer == false then
		else
			ChatService:Chat(player.Character.Head, "Player not found or not in the game.", Enum.ChatColor.Red)
		end
	end)
end
