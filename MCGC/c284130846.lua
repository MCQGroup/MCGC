-- MC群的技术宅 饭2

function c284130846.initial_effect(c)
	-- 超量
	-- 7星【MC群】*2或【MC群】二星以下或三阶以上
	aux.AddXyzProcedure(c, c284130846.filter, 7, 2, c284130846.ovfilter, aux.Stringid(284130846, 0))
    c:EnableReviveLimit()
	
	-- 战破免疫
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetValue(1)
    c:RegisterEffect(e1)
	
	-- 效果代破
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS + EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e2)
	
	-- 维持代价
	
end

function c284130846.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130846.ovfilter(c)
	return c284130846.filter(c) and c:IsFaceup() and (c:GetLevel() <= 2 or c:GetRank() >= 3)
end