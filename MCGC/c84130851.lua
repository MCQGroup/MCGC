-- MC群服务器卡死

function c84130851.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetOperation(c84130851.operation)
    c:RegisterEffect(e1)
end

function c84130851.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130851.desdroyFilter(c)
    return c84130851.filter(c) and c:IsType(TYPE_MONSTER) and c:IsDestructable()
end

function c84130851.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c84130851.desdroyFilter, tp, LOCATION_ONFIELD, 0, nil)
    local count = g:GetCount()
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)

    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_CONTINUOUS)
    e1:SetLabel(count)
    e1:SetCondition(EVENT_PHASE + PHASE_STANDBY)
    e1:SetCondition(c84130851.delayCondition)
    e1:SetOperation(c84130851.delayOperation)
    c:RegisterEffect(e1)
end

function c84130851.delayCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c84130851.delayOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    local g = Duel.SelectMatchingCard(tp, c84130851.filter, tp, LOCATION_GRAVE, 0, 0, count, nil)
    local c = g:GetFirst()
    while Duel.SpecialSummonStep(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos) do
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT + RESET_TURN_SET + RESET_TOGRAVE + RESET_REMOVE + RESET_TEMP_REMOVE + RESET_TOHAND + RESET_TODECK + RESET_LEAVE)
        c:RegisterEffect(e1)

        c = g:GetNext()
    end
    e:Reset()
end