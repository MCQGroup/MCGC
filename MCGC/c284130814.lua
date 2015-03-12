-- 植吧MC群
function c284130814.initial_effect(c)
    -- 返回卡组、抽卡
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TODECK + CATEGORY_DRAW)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation(c284130814.toDeckOperation)
    c:RegisterEffect(e1)

    -- 防止破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetRange(LOCATION_SZONE)
    e2:SetTargetRange(LOCATION_MZONE, 0)
    e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard, 0x2222))
    e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
    e2:SetCountLimit(1)
    e2:SetValue(1)
    c:RegisterEffect(e2)

    -- 维持代价
end

function c284130814.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130814.toDeckOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c284130814.filter, tp, LOCATION_HAND + LOCATION_GRAVE + LOCATION_REMOVED, 0, nil)
    Duel.SendtoDeck(g, tp, nil, REASON_EFFECT)
    Duel.Draw(tp, 5 - Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0), REASON_EFFECT)
end