require('Inspired')

PrintChat("ADC MAIN | Corki loaded.")
PrintChat("by Noddy")

mainMenu = Menu("ADC MAIN | Corki", "Corki")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q in combo", true)
mainMenu.Combo:Boolean("useE", "Use E in combo", true)
mainMenu.Combo:Boolean("useR", "Use R in combo", true)
mainMenu.Combo:Boolean("useSheen", "SheenProc weaving", true)
mainMenu.Combo:Key("Combo1", "Combo", string.byte(" "))
------------------------------------------
mainMenu:SubMenu("Drawings", "Drawings")
mainMenu.Drawings:Boolean("DrawQ","Draw Q", true)
mainMenu.Drawings:Boolean("DrawW","Draw W", true)
mainMenu.Drawings:Boolean("DrawE","Draw E", true)
mainMenu.Drawings:Boolean("DrawR","Draw R", true)
mainMenu.Drawings:Slider("Quality","Circle Quality", 100 , 1, 255, 1)
mainMenu.Drawings:Boolean("DrawDMG","DrawDmgOverHpBar", true)


OnLoop (function (myHero)

local myHeroPos = GetOrigin(myHero)
local target = GetCurrentTarget()

Killsteal()
Drawings()

if mainMenu.Drawings.DrawDMG:Value() then
	DrawDmgOverHpBar(target,GetCurrentHP(target),DPS,0,0xff00ff00)
end
-- Items
local Sheen = GetItemSlot(myHero,3057)
local TonsOfDamage = GetItemSlot(myHero,3078)

if mainMenu.Combo.Combo1:Value() then
-- Combo - noSheen

if GoS:ValidTarget(target,GetCastRange(myHero,_R)) then

if not mainMenu.Combo.useSheen:Value() then

	local QPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1000, 250, GetCastRange(myHero,_Q), 250, false, true)
	if QPred.HitChance == 1 and CanUseSpell(myHero,_Q) == READY and mainMenu.Combo.useQ:Value() then
		CastSkillShot(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
	end
	
	local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),5000, 150, GetCastRange(myHero,_E), 250, false, true)
	if EPred.HitChance == 1 and CanUseSpell(myHero,_E) == READY and mainMenu.Combo.useE:Value() then
		CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
	end
if not GotBuff(myHero,"mbcheck2") then	
	local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 75, true, true)
	if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
		CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
	end
elseif GotBuff(myHero,"mbcheck2") then
	local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 150, true, true)
	if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
		CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
	end
end	
end
-- Combo SheenWeave

if Sheen >= 1 or TonsOfDamage >= 1 and mainMenu.Combo.useSheen:Value() then

	if GoS:ValidTarget(target,GetRange(myHero)) and GotBuff(myHero,"sheen") == 1 then
		
	elseif GoS:ValidTarget(target,GetRange(myHero)) and GotBuff(myHero,"sheen") == 0 then
	
		local QPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1000, 250, GetCastRange(myHero,_Q), 250, false, true)
			if QPred.HitChance == 1 and CanUseSpell(myHero,_Q) == READY and mainMenu.Combo.useQ:Value() then
				CastSkillShot(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
			end
	
		local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),5000, 150, GetCastRange(myHero,_E), 250, false, true)
			if EPred.HitChance == 1 and CanUseSpell(myHero,_E) == READY and mainMenu.Combo.useE:Value() then
				CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
			end
		if not GotBuff(myHero,"mbcheck2") then	
			local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 75, true, true)
				if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
		elseif GotBuff(myHero,"mbcheck2") then
			local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 150, true, true)
				if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
		end
		
	elseif GoS:ValidTarget(target,GetCastRange(myHero,_R)) then
		
		local QPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1000, 250, GetCastRange(myHero,_Q), 250, false, true)
			if QPred.HitChance == 1 and CanUseSpell(myHero,_Q) == READY and mainMenu.Combo.useQ:Value() then
				CastSkillShot(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
			end
	
		local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),5000, 150, GetCastRange(myHero,_E), 250, false, true)
			if EPred.HitChance == 1 and CanUseSpell(myHero,_E) == READY and mainMenu.Combo.useE:Value() then
				CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
			end
		if not GotBuff(myHero,"mbcheck2") then	
			local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 75, true, true)
				if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
		elseif GotBuff(myHero,"mbcheck2") then
			local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 150, true, true)
				if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
		end

	end	

	
elseif GoS:ValidTarget(target,GetCastRange(myHero,_R)) then
		
		local QPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1000, 250, GetCastRange(myHero,_Q), 250, false, true)
			if QPred.HitChance == 1 and CanUseSpell(myHero,_Q) == READY and mainMenu.Combo.useQ:Value() then
				CastSkillShot(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
			end
	
		local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),5000, 150, GetCastRange(myHero,_E), 250, false, true)
			if EPred.HitChance == 1 and CanUseSpell(myHero,_E) == READY and mainMenu.Combo.useE:Value() then
				CastSkillShot(_E, EPred.PredPos.x, EPred.PredPos.y, EPred.PredPos.z)
			end
		if not GotBuff(myHero,"mbcheck2") then	
			local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 75, true, true)
				if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
		elseif GotBuff(myHero,"mbcheck2") then
			local RPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),1670, 250, GetCastRange(myHero,_R), 150, true, true)
				if RPred.HitChance == 1 and CanUseSpell(myHero,_R) == READY and mainMenu.Combo.useR:Value() then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
		end
end


end
end	
end)

function Killsteal()
       for i,enemy in pairs(GoS:GetEnemyHeroes()) do
			
			if CanUseSpell(myHero,_Q) == READY then 
				qDMG = GoS:CalcDamage(myHero, enemy, 0, (30*GetCastLevel(myHero,_Q)+50+(0.5*(GetBaseDamage(myHero) + GetBonusDmg(myHero)))+(0.5*GetBonusAP(myHero))))
				local QPred = GetPredictionForPlayer(myHeroPos, enemy, GetMoveSpeed(enemy),1000, 250, GetCastRange(myHero,_Q), 250, false, true)
				if CanUseSpell (myHero,_Q) == READY and QPred.HitChance == 1 and GoS:ValidTarget(enemy,GetCastRange(myHero,_Q)) and GetCurrentHP(enemy) < qDMG then
					CastSkillShot(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
				end
			else
				qDMG = 0
			end
			
			if CanUseSpell(myHero,_R) == READY then
				rDMG = GoS:CalcDamage(myHero, enemy, 0, (50*GetCastLevel(myHero,_R)+20+((0.1*(GetCastLevel(myHero,_R))+0.1)*(GetBaseDamage(myHero) + GetBonusDmg(myHero)))+(0.3*GetBonusAP(myHero))))
				local RPred = GetPredictionForPlayer(myHeroPos, enemy, GetMoveSpeed(enemy),1670, 250, GetCastRange(myHero,_R), 75, true, true)
				if CanUseSpell (myHero,_R) == READY and RPred.HitChance == 1 and GoS:ValidTarget(enemy,GetCastRange(myHero,_R)) and GetCurrentHP(enemy) < rDMG then
					CastSkillShot(_R, RPred.PredPos.x, RPred.PredPos.y, RPred.PredPos.z)
				end
			else
				rDMG = 0
			end
		DPS = qDMG + rDMG
      end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and mainMenu.Drawings.DrawQ:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),1,mainMenu.Drawings.Quality:Value(),0xff00ff00)
	elseif CanUseSpell(myHero, _Q) == ONCOOLDOWN and mainMenu.Drawings.DrawQ:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),1,mainMenu.Drawings.Quality:Value(),0xffff0000)
	end
if CanUseSpell(myHero, _W) == READY and mainMenu.Drawings.DrawW:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),1,mainMenu.Drawings.Quality:Value(),0xff00ff00)
	elseif CanUseSpell(myHero, _W) == ONCOOLDOWN and mainMenu.Drawings.DrawW:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_W),1,mainMenu.Drawings.Quality:Value(),0xffff0000)
	end
if CanUseSpell(myHero, _E) == READY and mainMenu.Drawings.DrawE:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),1,mainMenu.Drawings.Quality:Value(),0xff00ff00) 
	elseif CanUseSpell(myHero, _E) == ONCOOLDOWN and mainMenu.Drawings.DrawE:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_E),1,mainMenu.Drawings.Quality:Value(),0xffff0000)
	end
if CanUseSpell(myHero, _R) == READY and mainMenu.Drawings.DrawR:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),2,mainMenu.Drawings.Quality:Value(),0xff00ff00) 
	elseif CanUseSpell(myHero, _R) == ONCOOLDOWN and mainMenu.Drawings.DrawR:Value() then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),1,mainMenu.Drawings.Quality:Value(),0xffff0000)
	end
end
