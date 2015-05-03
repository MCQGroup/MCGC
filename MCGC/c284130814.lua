-- 植吧MC群
function c284130814.initial_effect(c)
    -- 返回卡组、抽卡
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TODECK + CATEGORY_DRAW)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c284130814.toDeckTarget)
    e1:SetOperation(c284130814.toDeckOperation)
    c:RegisterEffect(e1)

    -- 防止破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetRange(LOCATION_SZONE)
    e2:SetTargetRange(LOCATION_MZONE, 0)
    e2:SetTarget(aux.TargetBoolFunction(c284130814.filter))
    e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
    e2:SetCountLimit(1)
    e2:SetValue(1)
    c:RegisterEffect(e2)

    -- 维持代价
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e3:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e3:SetRange(LOCATION_SZONE)
    e3:SetCountLimit(1)
    e3:SetCondition(c284130814.costCondition)
    e3:SetOperation(c284130814.costOperation)
    c:RegisterEffect(e3)
end

function c284130814.filter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER)
end

function c284130814.toDeckTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return true
    end
    if chk == 0 then
        return Duel.IsPlayerCanDraw(tp) and Duel.IsExistingTarget(c284130814.filter, tp, LOCATION_GRAVE, 0, 1, nil) and Duel.IsExistingTarget(c284130814.filter, tp, LOCATION_REMOVED, 0, 1, nil) and Duel.IsExistingTarget(c284130814.filter, tp, LOCATION_HAND, 0, 1, e:GetHandler())
    end
    local g = Duel.GetMatchingGroup(c284130814.filter, tp, LOCATION_HAND + LOCATION_REMOVED + LOCATION_GRAVE, 0, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_TODECK, g, g:GetCount(), nil, 0)
end

function c284130814.toDeckOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c284130814.filter, tp, LOCATION_HAND + LOCATION_GRAVE + LOCATION_REMOVED, 0, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_EFFECT)
    Duel.ShuffleDeck(tp)    -- It's reported that the previous line won't shuffle the deck so here do it by hand
    Duel.Draw(tp, 5 - Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0), REASON_EFFECT)
end

function c284130814.costCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c284130814.costOperation(e, tp, eg, ep, ev, re, r, rp)
    if Duel.GetTurnPlayer() ~= tp then
        return
    end
    if Duel.CheckLPCost(tp, 1000) and Duel.SelectYesNo(tp, aux.Stringid(284130814, 0)) then
        Duel.PayLPCost(tp, 1000)
    else
        Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_RULE)
        local g = Duel.GetFieldGroup(tp, LOCATION_HAND, 0)
        if g:GetCount() > 0 then
            Duel.SendtoGrave(g:RandomSelect(tp, 1), REASON_EFFECT + REASON_DISCARD)
        end
    end
end
