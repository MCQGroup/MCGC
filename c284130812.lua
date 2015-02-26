-- MC群的群主 纸睡
function c284130812.initial_effect(c)
    --通常召唤
	local e1 = Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c284130812.summonCondition)
	e1:SetOperation(c284130812.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)

	local e2=e1:Clone()
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e2)

    --特殊召唤
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_SPSUMMON_PROC)
    e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e3:SetRange(LOCATION_HAND)
    e3:SetCondition(c284130812.spSummonCondition)
    e3:SetOperation(c284130812.spSummonOperation)
    c:RegisterEffect(e3)
    
end

function c284130812.filter(c)
    return c.IsSetCard(0x2222)
end

function c284130812.summonCondition(e,c)
	if c == nil then
        return true
    end
    local tributeCount = 3 - Duel.GetMatchingGroupCount(c284130812.filter, c.GetController(), LOCATION_GRAVE, 0, nil)
    if tributeCount < 0 then
        tributeCount = 0
    end
	return Duel.GetTributeCount(c) >= tributeCount
end

function c284130812.summonOperation(e,tp,eg,ep,ev,re,r,rp,c)
    local tributeCount = 3 - Duel.GetMatchingGroupCount(c284130812.filter, c.GetController(), LOCATION_GRAVE, 0, nil)
    if tributeCount < 0 then
        tributeCount = 0
    else
	    local g = Duel.SelectTribute(tp,c,tributeCount,tributeCount)
	    c:SetMaterial(g)
	    Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
    end
end

function c284130812.spSummonCondition(e,c)
end

function c284130812.spSummonOperation(e,tp,eg,ep,ev,re,r,rp,c)
end