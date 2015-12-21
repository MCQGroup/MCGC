-- MC群服务器卡死

function c284130851.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetOperation()
    c:RegisterEffect(e1)
end

function c284130851.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130851.operation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
end