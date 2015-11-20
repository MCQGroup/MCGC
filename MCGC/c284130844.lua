-- MC群的鸟徳 ND

function c284130844.initial_effect(c)
    -- xyz summon
    aux.AddXyzProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, 0x2222), 4, 3, c284130844.ovfilter, aux.Stringid(284130844, 0))
    c:EnableReviveLimit()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetValue(c284130844.atkval)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(284130844, 0))
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetTarget(c284130844.mttg)
    e2:SetOperation(c284130844.mtop)
    c:RegisterEffect(e2)
end

function c284130844.ovfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x2222) and c:GetLevel() == 4
end

function c284130844.atkval(e, c)
    return c:GetRank() * 200
end

function c284130844.mtfilter(c)
    return c:IsSetCard(0x2222)
end

function c284130844.mttg(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end

    if e:GetHandler():GetOverlayCount() > 0 then
        opt = Duel.SelectOption(tp, aux.Stringid(284130844, 1), aux.Stringid(284130844, 2))
        e:SetLabel(opt)
    else
        e:SetLabel(0)
    end

    if e:GetLabel() == 1 then
        local g = e:GetHandler():GetOverlayGroup()
        Duel.SendtoGrave(g, REASON_EFFECT)
    end
end

function c284130844.mtop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if not c:IsRelateToEffect(e) or c:IsFacedown() then
        return
    end
    if e:GetLabel() == 0 then
        Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_XMATERIAL)
        local g = Duel.SelectMatchingCard(tp, c284130844.mtfilter, tp, LOCATION_HAND + LOCATION_GRAVE + LOCATION_REMOVED, 0, 1, 1, nil)
        if g:GetCount() > 0 then
            Duel.Overlay(c, g)
        end
    else
        local e2 = Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_UPDATE_RANK)
        e2:SetReset(RESET_EVENT + 0x1ff0000)
        e2:SetValue(1)
        c:RegisterEffect(e2)
    end
end
