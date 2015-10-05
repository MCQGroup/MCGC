-- MC群的团员 TF

function c284130842.initial_effect(c)
	-- 融合召唤
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c, c284130842.fusionFilter1, c284130842.fusionFilter2, false)
	
	local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
	
	-- 不被效果破坏
	local e2 = Effect.CreateEffect(c)
	
	
	-- 攻击上升
	
	
	-- 防御穿透
		
end

function c284130842.fusionFilter1(c)
	return c:IsSetCard(0x2222)
end

function c284130842.fusionFilter2(c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end