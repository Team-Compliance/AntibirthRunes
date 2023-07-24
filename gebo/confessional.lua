local function ConfessionalMachine(slot, player, uses, rng)
	if uses > 0 then
		local sprite = slot:GetSprite()
		---@cast sprite Sprite
		if sprite:GetAnimation() == "Death" or sprite:GetAnimation() == "Broken" then
			return true
		end
		if sprite:IsPlaying("Idle") and not sprite:IsOverlayPlaying("CoinInsert") then
			sprite:PlayOverlay("CoinInsert", true)
		end
		if sprite:IsFinished("Initiate") then
			sprite:Play("Wiggle", true)
		end
		if sprite:IsFinished("NoPrize") then
			uses = uses - 1
			sprite:Play("Idle", true)
		end
		if sprite:IsEventTriggered("Prize") then
			uses = uses - 1
		end
		if sprite:WasEventTriggered("Explosion") then
			slot:Die()
			Isaac.Explode(slot.Position, nil, 0)
		end
		if sprite:IsFinished("Death") then
			sprite:Play("Broken", true)
		end
	end
	return uses
end

Gebo.AddMachineBeggar(17, ConfessionalMachine)