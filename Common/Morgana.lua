if GetObjectName(myHero) ~= "Morgana" then return end
-- Morgana script --
-- Change log is on my topic, type suggestions and comments in the topic. (Version 1.1) --

-- Script info --

local info = "Rakli's Morgana v1.1"
local thread = "Type suggestions in my topic :)"
local bugs = "If you find any bugs, make sure to report them on topic"
textTable = {info,thread,bugs}
PrintChat(textTable[1])
PrintChat(textTable[2])
PrintChat(textTable[3])

-- Menu --
 
MorganaMenu = Menu("Morgana", "Morgana")
MorganaMenu:SubMenu("Combo", "Combo")
MorganaMenu.Combo:Boolean("Q", "Use Q", true)
MorganaMenu.Combo:Boolean("W", "Use W", false)
MorganaMenu.Combo:Boolean("WQ", "W with Q only", true)
MorganaMenu.Combo:Boolean("E", "Use E on Self", true)
MorganaMenu.Combo:Boolean("Shield", "Use E on Ally", true)
MorganaMenu.Combo:Boolean("R", "Use R", true)
MorganaMenu.Combo:Boolean("TwoR", "Use R on 2+", false)
MorganaMenu.Combo:Boolean("ThreeR", "Use R only 3", false)

MorganaMenu:SubMenu("Harass", "Harass")
MorganaMenu.Harass:Boolean("Q", "Use Q", true)
MorganaMenu.Harass:Boolean("W", "Use W", true)

MorganaMenu:SubMenu("AutoIgnite", "Auto Ignite")
MorganaMenu.AutoIgnite:Boolean("UseIgnite", "Use Ignite", true)

MorganaMenu:SubMenu("LaneClear", "Lane Clear")
MorganaMenu.LaneClear:Boolean("Q", "Use Q", true)
MorganaMenu.LaneClear:Boolean("W", "Use W", true)

MorganaMenu:SubMenu("JungleClear", "Jungle Clear")
MorganaMenu.JungleClear:Boolean("Q", "Use Q", true)
MorganaMenu.JungleClear:Boolean("W", "Use W", true)
MorganaMenu.JungleClear:Key("Junglekey", "Jungle Clear", string.byte("V"))

MorganaMenu:SubMenu("JungleSteal", "Steal Dragon / Baron")
MorganaMenu.JungleSteal:Boolean("Q", "Use Q to Steal", true)

MorganaMenu:SubMenu("Zhonya", "Use Zhonya at % HP:")
MorganaMenu.Zhonya:Boolean("ZhonyaOne", "Zhonya at 50% HP", false)
MorganaMenu.Zhonya:Boolean("ZhonyaTwo", "Zhonya at 40% HP", false)
MorganaMenu.Zhonya:Boolean("ZhonyaThree", "Zhonya at 30% HP", true)
MorganaMenu.Zhonya:Boolean("ZhonyaFour", "Zhonya at 20% HP", false)

MorganaMenu:SubMenu("Killsteal", "Killsteal")
MorganaMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
MorganaMenu.Killsteal:Boolean("R", "Killsteal with R", false)

MorganaMenu:SubMenu("Drawings", "Drawings")
MorganaMenu.Drawings:Boolean("Q", "Draw Q Range", true)
MorganaMenu.Drawings:Boolean("E", "Draw E Range", false)
MorganaMenu.Drawings:Boolean("R", "Draw R Range", false)

OnLoop(function(myHero)

	-- Locals --

	local myHero = GetMyHero()
	local target = GetCurrentTarget()
	local rangeQ = GetCastRange(myHero,_Q)
	local rangeW = GetCastRange(myHero,_W)
	local rangeE = GetCastRange(myHero,_E)
	local rangeR = GetCastRange(myHero,_R)
	local predQ = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,250,1175,75,true,true)
	local EnemyPos = GetOrigin(target)

					-- Combo --

	                if IOW:Mode() == "Combo" and IsTargetable(target) then
                        if MorganaMenu.Combo.Q:Value() and GoS:ValidTarget (target, 1500) and predQ.HitChance == 1 then
                                if CanUseSpell(myHero,_Q) == READY then
                                    CastSkillShot(_Q,predQ.PredPos.x, predQ.PredPos.y, predQ.PredPos.z)
                                end
                        end
 
                        if MorganaMenu.Combo.W:Value() and GoS:ValidTarget(target,rangeW) then
                        	if CanUseSpell(myHero, _W) == READY then
                        		CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
                        	end	
                       
                        elseif MorganaMenu.Combo.WQ:Value() and GoS:ValidTarget (target, rangeW) then
                        	if GotBuff(target, "DarkBindingMissile") == 1 then
                                if CanUseSpell(myHero,_W) == READY then
                                    CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
                                end
                            end
                        end        
 
                        if MorganaMenu.Combo.E:Value() and GoS:ValidTarget (target, 1000) then
                            if (GetCurrentHP(myHero)/GetMaxHP(myHero))<0.6 then
                                if CanUseSpell(myHero,_E) == READY then
                                    CastTargetSpell(myHero,_E)
                                end    
                            end
                        end
               
                        if MorganaMenu.Combo.R:Value() and GoS:ValidTarget (target, rangeR) then
                            if CanUseSpell(myHero,_R) == READY then
                                CastSpell(_R)
                            end    
                        end                 

            			for i,unit in pairs(GoS:GetAllyHeroes()) do
            				if MorganaMenu.Combo.Shield:Value() then
            					if (GetCurrentHP(unit)/GetMaxHP(unit))<0.6 and GoS:GetDistance(unit) < 1000 and CanUseSpell(myHero,_E) == READY then
            						if GoS:ValidTarget(target, 1200) then
            							CastTargetSpell(unit,_E)
            						end
            					end
            				end
           				end  
           			end	                      
 -- Harass --

if IOW:Mode() == "Harass" and IsTargetable(target) then
               
    if MorganaMenu.Harass.Q:Value() and GoS:ValidTarget (target, 1500) and predQ.HitChance == 1 then
        if CanUseSpell(myHero,_Q) == READY then
            CastSkillShot(_Q,predQ.PredPos.x, predQ.PredPos.y, predQ.PredPos.z)
        end    
    end
                       
	if MorganaMenu.Harass.W:Value() and GoS:ValidTarget (target, rangeW) then
		if GotBuff(target, "DarkBindingMissile") == 1 then
    		if CanUseSpell(myHero,_W) == READY then
        		CastSkillShot(_W,EnemyPos.x,EnemyPos.y,EnemyPos.z)
    		end    
		end    
	end 
end

-- Lane Clear --

if IOW:Mode() == "LaneClear" then
	for i,minion in pairs(GoS:GetAllMinions(MINION_ENEMY)) do
		if GoS:ValidTarget(minion, rangeQ) then
			MinionPos = GetOrigin(minion)
				if CanUseSpell(myHero, _Q) == READY and MorganaMenu.LaneClear.Q:Value() then
					CastSkillShot(_Q,MinionPos.x,MinionPos.y,MinionPos.z)
				end

				if CanUseSpell(myHero, _W) == READY and MorganaMenu.LaneClear.W:Value() then
					CastSkillShot(_W,MinionPos.x,MinionPos.y,MinionPos.z)
				end
		end
	end
end					

-- Jungle Clear --

if MorganaMenu.JungleClear.Junglekey:Value() then
	for i,junglemobs in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
		if GoS:ValidTarget(junglemobs, rangeQ) then
			JungleMobPos = GetOrigin(junglemobs)
				if CanUseSpell(myHero, _Q) == READY and MorganaMenu.JungleClear.Q:Value() then
					CastSkillShot(_Q,JungleMobPos.x,JungleMobPos.y,JungleMobPos.z)
				end

				if CanUseSpell(myHero, _W) == READY and MorganaMenu.JungleClear.W:Value() then
					CastSkillShot(_W,JungleMobPos.x,JungleMobPos.y,JungleMobPos.z)
				end	
		end
	end
end	

-- Baron / Dragon Q Steal --

for i,bigmobs in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do

	local myDamage = 25 + 55*GetCastLevel(myHero,_Q) + 0.9*GetBonusAP(myHero)
	local BigMobPos = GetOrigin(bigmobs)

		-- Ludens Echo --

	local Ludens = 0

		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
			Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
		end	

		if GoS:ValidTarget(bigmobs, rangeQ) and GoS:GetDistance(bigmobs) < rangeQ then 
			if CanUseSpell(myHero, _Q) == READY and  GoS:CalcDamage(myHero, bigmobs, 0, myDamage + Ludens) > GetCurrentHP(bigmobs) and GetObjectName(bigmobs) == "SRU_Baron" and MorganaMenu.JungleSteal.Q:Value() then
				CastSkillShot(_Q,BigMobPos.x,BigMobPos.y,BigMobPos.z)
			elseif CanUseSpell(myHero, _Q) == READY and  GoS:CalcDamage(myHero, bigmobs, 0, myDamage + Ludens) > GetCurrentHP(bigmobs) and GetObjectName(bigmobs) == "SRU_Dragon" and MorganaMenu.JungleSteal.Q:Value() then
				CastSkillShot(_Q,BigMobPos.x,BigMobPos.y,BigMobPos.z)
			end
		end
end				

-- Drawings --

if MorganaMenu.Drawings.Q:Value() then
                       
    DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,rangeQ,3,100,0xff00ff000)   
end

if MorganaMenu.Drawings.E:Value() then

	DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,rangeE,3,100,0xff00ff00)
end

if MorganaMenu.Drawings.R:Value() then

	DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,rangeR,3,100,0xff00ff00)
end           			

-- KillSteal--

for i,enemy in pairs(GoS:GetEnemyHeroes()) do

	local Ignited = 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5
	
-- KS Spells--

local QPred = GetPredictionForPlayer(GoS:myHeroPos(),enemy,GetMoveSpeed(enemy),1200,250,1175,75,true,true)
local dmgQ = (GetCastLevel(myHero,_Q))*55 + 25 + 0.9*GetBonusAP(myHero) 
local dmgR = (GetCastLevel(myHero,_R))*75 + 75 + 0.7*GetBonusAP(myHero)

		-- Luden's Echo --

	local Ludens = 0

		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
			Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
		end	

	if IsTargetable(enemy) then
	    
		if CanUseSpell(myHero,_Q) == READY and MorganaMenu.Killsteal.Q:Value() and QPred.HitChance == 1 and GoS:ValidTarget(enemy, 1300) and GoS:CalcDamage(myHero, enemy, 0, dmgQ + Ludens) > GetCurrentHP(enemy) + GetHPRegen(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy) then
			CastSkillShot(_Q,QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z)
		end	
						
		if CanUseSpell(myHero,_R) == READY and MorganaMenu.Killsteal.R:Value() and GoS:ValidTarget(enemy, rangeR) and GoS:CalcDamage(myHero, enemy, 0, dmgR + Ludens) > GetCurrentHP(enemy) + GetHPRegen(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy) then
			CastSpell(_R)
		end	

		if Ignite and MorganaMenu.AutoIgnite.UseIgnite:Value() then
            if CanUseSpell(myHero,Ignite) and Ignited and GoS:ValidTarget(enemy, GetCastRange(myHero,Ignite)) then
                CastTargetSpell(enemy, Ignite)
            end
        end    

        -- Zhonya at customizable health percentages--

		if GetItemSlot(myHero,3157) > 0 and GoS:ValidTarget (enemy, 900) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.50 and MorganaMenu.Zhonya.ZhonyaOne:Value() and GotBuff(enemy, "SoulShackles") > 0 then
        	CastTargetSpell(myHero, GetItemSlot(myHero,3157))
		end

		if GetItemSlot(myHero,3157) > 0 and GoS:ValidTarget (enemy, 900) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.40 and MorganaMenu.Zhonya.ZhonyaTwo:Value() and GotBuff(enemy, "SoulShackles") > 0 then
			CastTargetSpell(myHero, GetItemSlot(myHero,3157))
		end

		if GetItemSlot(myHero,3157) > 0 and GoS:ValidTarget (enemy, 900) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.30 and MorganaMenu.Zhonya.ZhonyaThree:Value() and GotBuff(enemy, "SoulShackles") > 0 then
			CastTargetSpell(myHero, GetItemSlot(myHero,3157))
		end

		if GetItemSlot(myHero,3157) > 0 and GoS:ValidTarget (enemy, 900) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.20 and MorganaMenu.Zhonya.ZhonyaFour:Value() and GotBuff(enemy, "SoulShackles") > 0 then
			CastTargetSpell(myHero, GetItemSlot(myHero,3157))
		end				  

		-- Ult options --

		-- If ulting then cast E on me--

		if GotBuff(enemy, "SoulShackles") > 0 then
			CastTargetSpell(myHero, _E)
		end

		-- Ult only 2 Enemies --

		if IOW:Mode() == "Combo" then	

			if CanUseSpell(myHero, _R) == READY and (CountEnemyHeroInRange(enemy,480))>=2 and GoS:ValidTarget(enemy,480) and MorganaMenu.Combo.TwoR:Value() then
				CastSpell(_R)
			end	

		-- Ult only 3 Enemies --

			if CanUseSpell(myHero, _R) == READY and (CountEnemyHeroInRange(enemy,480))>=3 and GoS:ValidTarget(enemy,480) and MorganaMenu.Combo.ThreeR:Value() then
				CastSpell(_R)
			end	
		end	

	end	
end		

-- Used this function from Maxxell --

function CountEnemyHeroInRange(object,range)
  object = object or myHero
  range = range or 480
  local enemyInRange = 0
  for i, enemy in pairs(GoS:GetEnemyHeroes()) do
    if (enemy~=nil and GetTeam(myHero)~=GetTeam(enemy) and IsDead(enemy)==false) and GoS:GetDistance(object, enemy)<= 480 then
    	enemyInRange = enemyInRange + 1
    end
  end
  return enemyInRange
end
end)