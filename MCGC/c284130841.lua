-- MC群的现充拍档 玲音&手滑

function c284130841.initial_effect(c)
	-- 次元融合
    -- 参考[56655675]圣灵兽骑 地火狮
    c:EnableReviveLimit()
    -- 因为是族融合所以不填融合素材
    
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
    
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetValue(SUMMON_TYPE_FUSION)
    e2:SetCondition(c284130841.fusionCondition)
    e2:SetOperation(c56655675.fusionOperation)
    c:RegisterEffect(e2)
	
	-- 攻击聚焦
	
	
	-- 攻守上升

end

function c284130841.lainFilter(c)
    return c:GetCode() >= 284130816 and c:GetCode() <= 284130823
end

function c284130841.fusionFilter1(c)
    return c284130841.lainFilter(c) and c:IsAbleToDeckAsCost() and c:IsCanBeFusionMaterial()
end

function c284130841.shouhuaFilter(c)
    return c:IsCode(284130825) or c:IsCode(284130841)
end

function c284130841.fusionFilter2(c)
    return c284130841.shouhuaFilter(c) and c:IsAbleToDeckAsCost() and c:IsCanBeFusionMaterial()
end

function c284130841.fusionCondition(e, c)
    if c == nil then
        return true
    end
    local tp = c:GetControler()
    return Duel.GetLocationCount(tp, LOCATION_MZONE) > -2 and Duel.IsExistingMatchingCard(c284130841.fusionFilter1, tp, LOCATION_MZONE, 0, 1, nil) and Duel.IsExistingMatchingCard(c284130841.fusionFilter2, tp, LOCATION_MZONE, 0, 1, nil)
end

function c284130841.fusionOperation(e, tp, eg, ep, ev, re, r, rp, c)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g1 = Duel.SelectMatchingCard(tp, c284130841.fusionFilter1, tp, LOCATION_MZONE, 0, 1, 1, nil)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g2 = Duel.SelectMatchingCard(tp, c284130841.fusionFilter2, tp, LOCATION_MZONE, 0, 1, 1, nil)
    g1:Merge(g2)
    c:SetMaterial(g1)
    Duel.SendToDeck(g1, nil, nil, REASON_COST)
end

-- 以下是参考用代码