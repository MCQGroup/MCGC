-- MC群的现充拍档 玲音&手滑

function c284130841.initial_effect(c)
    -- 次元融合
    -- 参考[56655675]圣灵兽骑 地火狮
    c:EnableReviveLimit()
    -- 因为是族融合所以不填融合素材

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetValue(SUMMON_TYPE_FUSION)
    e2:SetCondition(c284130841.fusionCondition)
    e2:SetOperation(c284130841.fusionOperation)
    c:RegisterEffect(e2)

    -- 攻击聚焦
    -- 参考[50449881]鲨鱼要塞
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
    e3:SetRange(LOCATION_MZONE)
    e3:SetTargetRange(0, LOCATION_MZONE)
    -- e3:SetCondition(c284130841.atkFocusCondition)
    -- [66865880]棉花糖的眼镜有正面表示检查而鲨鱼要塞没有，因此这里注释，测试后视情况更改
    e3:SetValue(c284130841.atkFocus)
    c:RegisterEffect(e3)

    -- 攻守上升
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_UPDATE_ATTACK)
    e4:SetValue(c284130841.update)
    c:RegisterEffect(e4)

    local e5 = e4:Clone()
    e5:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e5)
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
    Duel.SendtoDeck(g1, nil, nil, REASON_COST)
end

function c284130841.atkFocusCondition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler():IsFaceup()
end

function c284130841.atkFocus(e, c)
    return c ~= e:GetHandler()
end

function c284130841.updateFilter(c)
    return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and(c284130841.lainFilter(c) or c284130841.shouhuaFilter(c))
end

function c284130841.update(e, c)
    return 300 * Duel.GetMatchingGroupCount(c284130841.updateFilter, tp, LOCATION_MZONE + LOCATION_EXTRA, 0, nil)
end