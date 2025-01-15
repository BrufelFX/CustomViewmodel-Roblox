local ViewmodelModule = {
	handItem = nil,
	
	connect = nil
}

local models = script.Models

local swayCF = CFrame.new()

local us = game:GetService("UserInputService")

local runService = game:GetService("RunService")

local function Clean()
	local camera = game.Workspace.CurrentCamera
	
	for _, v in pairs(camera:GetDescendants()) do
		if v:IsA("Model") then
			v:Destroy()
		end
	end
	
	if ViewmodelModule.connect ~= nil then
		ViewmodelModule.connect:Disconnect()
	end
	
	if ViewmodelModule.handItem ~= nil then
		ViewmodelModule.handItem = nil
	end
	return true
end

function ViewmodelModule.Equip(Item : string)
	local camera = game.Workspace.CurrentCamera
	
	if camera:FindFirstChild(Item) then
		return
	end
	
	local result = Clean()
	
	if result then
		local model = models:FindFirstChild(Item)
		if model then
			model = model:Clone()
			model.Parent = camera
			
			ViewmodelModule.handItem = model
			
			ViewmodelModule.connect = runService.RenderStepped:Connect(function()
				local mouse = us:GetMouseDelta()/100
				
				local swayX = math.clamp(mouse.X,-0.2,0.2)
				local swayY = math.clamp(mouse.Y,-0.2,0.2)
				
				swayCF = swayCF:Lerp(CFrame.new(swayX,swayY,0),.3)
				model:SetPrimaryPartCFrame(camera.CFrame * swayCF)
			end)
		end
	end
end

function ViewmodelModule.UnEquip()
	local camera = game.Workspace.CurrentCamera
	
	if camera:FindFirstChild(ViewmodelModule.handItem.Name) then
		ViewmodelModule.connect:Disconnect()
		ViewmodelModule.handItem:Destroy()
	end
end

return ViewmodelModule
