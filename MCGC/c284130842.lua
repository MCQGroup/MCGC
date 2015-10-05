-- MC群的团员 TF

function c284130842.initial_effect(c)
	-- 融合召唤
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c, c284130842.fusionFilter1, c284130842.fusionFilter2, false)
	
	local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetRange(LOCATION_EXTRA)
    c:RegisterEffect(e1)
	
	-- 不被效果破坏
	-- 参考[94977269]神影依·米德拉什
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(c284130842.indestructableValue)
	c:RegisterEffect(e2)
	
	-- 攻击上升
	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
	e3:SetCode()
	
	-- 防御穿透
		
end

function c284130842.fusionFilter1(c)
	return c:IsSetCard(0x2222)
end

function c284130842.fusionFilter2(c)
	return c:IsAttribute(ATTRIBUTE_FIRE)
end

function c284130842.indestructableValue(e, re, tp)
	return tp ~= e:GetHandlerPlayer()
end