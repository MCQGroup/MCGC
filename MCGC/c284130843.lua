-- MC群的最终领袖 纸睡前辈

function c284130843.intial_effect(c)
	-- 同调召唤
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c, c284130843.synchroFilter1, c284130843.synchroFilter2, 2)
	
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
	
	-- 展示
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c284130843.showCondition)
	e2:SetCost(c284130843.showCost)
	e2:SetOperation(c284130843.showOperation)
	c:RegisterEffect(e2) 
	
	-- 魔免
	
	
	-- 控制权
	-- 无效效果
	-- 亡语
end	

function c284130843.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130843.synchroFilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsType(TYPE_SYNCHRO)
end

function c284130843.synchroFilter2(c)
	return (c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ) or c:IsType(TYPE_PENDULUM))
end

function c284130843.showCondition(e, tp, eg, ep, ev, re, r, rp)
	return Duel.GetTurnPlayer() == tp and bit.band(Duel.GetCurrentPhase(), PHASE_MAIN1 + PHASE_MAIN2)
end

function c284130843.showCost(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then
		return true
	end
	Duel.ConfirmCards(1 - tp, e:GetHandler())
end

function c284130843.showOperation(e, tp, eg, ep, ev, re, r, rp)
	-- 这尼玛怎么写！
end