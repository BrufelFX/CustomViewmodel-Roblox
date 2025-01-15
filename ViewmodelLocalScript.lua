local us = game:GetService("UserInputService")

local viewmodel = require(game.ReplicatedStorage.Viewmodel)


us.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.One then
		viewmodel.Equip("ArmModel") --  <--- The name of the model to be visible to the player must be the same one you have in the “Models” folder.
	end
	if input.KeyCode == Enum.KeyCode.Zero then
		viewmodel.UnEquip()
	end
end)