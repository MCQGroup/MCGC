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
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e3:SetCountLimit(1)
    e3:SetOperation(c284130814.costOperation)
    e3:SetReset(RESET_EVENT + 0x1fe0000)
    c:RegisterEffect(e3)
end

function c284130814.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130814.toDeckOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c284130814.filter, tp, LOCATION_HAND + LOCATION_GRAVE + LOCATION_REMOVED, 0, nil)
    Duel.SendtoDeck(g, tp, nil, REASON_EFFECT)
    Duel.Draw(tp, 5 - Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0), REASON_EFFECT)
end

function c284130814.costOperation(e, tp, eg, ep, ev, re, r, rp)
    if Duel.GetTurnPlayer() ~= tp then
        return
    end
    if Duel.GetLP(tp) > 1000 and Duel.SelectYesNo(tp, aux.Stringid(284130814, 0)) then
        Duel.PayLPCost(tp, 1000)
    else
        Duel.Remove(e:GetHandler(), REASON_RULE)
        local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
        if g:GetCount() > 0 then
            Duel.SendtoGrave(g:RandomSelect(tp, 1), REASON_EFFECT + REASON_DISCARD)
        end
    end
end