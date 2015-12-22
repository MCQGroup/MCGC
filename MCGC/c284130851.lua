-- MC群服务器卡死

function c284130851.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetOperation(c284130851.operation)
    c:RegisterEffect(e1)
end

function c284130851.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130851.desdroyFilter(c)
    return c284130851.filter(c) and c:IsType(TYPE_MONSTER) and c:IsDestructable()
end

function c284130851.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c284130851.desdroyFilter, tp, LOCATION_ONFIELD, 0, nil)
    local count = g:GetCount()
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)

    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_CONTINUOUS)
    e1:SetCondition(EVENT_PHASE + PHASE_STANDBY)
    e1:SetCondition(c284130851.delayCondition)
    e1:SetOperation(c284130851.delayOperation)
end

function c284130851.delayCondition(e, tp, eg, ep, ev, re, r, rp)
    
end

function c284130851.delayOperation(e, tp, eg, ep, ev, re, r, rp)
end