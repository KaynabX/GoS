if GetObjectName(myHero) ~= "Brand" then return end

require('Deftlib')

local BrandMenu = Menu("Brand", "Brand")
BrandMenu:SubMenu("Combo", "Combo")
BrandMenu.Combo:Boolean("Q", "Use Q", true)
BrandMenu.Combo:Boolean("W", "Use W", true)
BrandMenu.Combo:Boolean("E", "Use E", true)
BrandMenu.Combo:Boolean("R", "Use R", true)

BrandMenu:SubMenu("Harass", "Harass")
BrandMenu.Harass:Boolean("Q", "Use Q", true)
BrandMenu.Harass:Boolean("W", "Use W", true)
BrandMenu.Harass:Boolean("E", "Use E", true)
BrandMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

BrandMenu:SubMenu("Killsteal", "Killsteal")
BrandMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
BrandMenu.Killsteal:Boolean("W", "Killsteal with W", true)
BrandMenu.Killsteal:Boolean("E", "Killsteal with E", true)

BrandMenu:SubMenu("Misc", "Misc")
BrandMenu.Misc:Boolean("AutoIgnite", "Auto Ignite", true)
BrandMenu.Misc:Boolean("Autolvl", "Auto level", true)
BrandMenu.Misc:List("Autolvltable", "Priority", 1, {"W-Q-E", "Q-W-E"})
BrandMenu.Misc:Boolean("Interrupt", "Interrupt Spells (Q)", true)

BrandMenu:SubMenu("Drawings", "Drawings")
BrandMenu.Drawings:Boolean("Q", "Draw Q Range", true)
BrandMenu.Drawings:Boolean("W", "Draw W Range", true)
BrandMenu.Drawings:Boolean("E", "Draw E Range", true)
BrandMenu.Drawings:Boolean("R", "Draw R Range", true)

OnLoop(function(myHero)

  if IOW:Mode() == "Combo" then
	
    local target = GetCurrentTarget()
    local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,250,1050,160,true,true)
    local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,1000,900,240,false,true)
	
    if CanUseSpell(myHero, _E) == READY and BrandMenu.Combo.E:Value() and GoS:ValidTarget(target, 625) then
    CastTargetSpell(target, _E)
    end
    
    if CanUseSpell(myHero, _W) == READY and BrandMenu.Combo.W:Value() and WPred.HitChance == 1 and GoS:ValidTarget(target, 900) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		 end
		 
		 if CanUseSpell(myHero, _Q) == READY and BrandMenu.Combo.Q:Value() and QPred.HitChance == 1 and GotBuff(target, "brandablaze") > 0 and GoS:ValidTarget(target, 1050) then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		 end
		 
		 if CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _R) == READY and BrandMenu.Combo.R:Value() and GoS:ValidTarget(target, 750) and GotBuff(target, "brandablaze") > 0 and 100*GetCurrentHP(target)/GetMaxHP(target) < 40 then
		 CastTargetSpell(target, _R)
		 end
		 
	 end
	
	 if IOW:Mode() == "Harass" and 100*GetCurrentMana(myHero)/GetMaxMana(myHero) >= BrandMenu.Harass.Mana:Value() then
	
    local target = GetCurrentTarget()
    local QPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,250,1050,160,true,true)
    local WPred = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),math.huge,1000,900,240,false,true)
	
    if CanUseSpell(myHero, _E) == READY and BrandMenu.Harass.E:Value() and GoS:ValidTarget(target, 625) then
    CastTargetSpell(target, _E)
    end
    
    if CanUseSpell(myHero, _W) == READY and BrandMenu.Harass.W:Value() and WPred.HitChance == 1 and GoS:ValidTarget(target, 900) then
    CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		 end
		 
		 if CanUseSpell(myHero, _Q) == READY and BrandMenu.Harass.Q:Value() and QPred.HitChance == 1 and GoS:ValidTarget(target, 1050) then
    CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		 end
		 
	 end
	 
	 for i,enemy in pairs(GoS:GetEnemyHeroes()) do
	 
	  
	   
                local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
	        ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
				
		if Ignite and BrandMenu.Misc.AutoIgnite:Value() then
                  if CanUseSpell(myHero,Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2.5 and GoS:ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
  end
  
if BrandMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,1050,1,128,0xff00ff00) end
if BrandMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,900,1,128,0xff00ff00) end
if BrandMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,625,1,128,0xff00ff00) end
if BrandMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,750,1,128,0xff00ff00) end

end)
