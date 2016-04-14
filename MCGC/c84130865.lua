-- region *.lua
-- Date 2016-4-8
-- 此文件由[BabeLua]插件自动生成

function c84130865.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCountLimit(1)
    e2:SetCost(c84130865.cost)
    e2:SetOperation(c84130865.operation)
    c:RegisterEffect(e2)
end

function c84130865.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130865.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost, tp, LOCATION_HAND, 0, 1, nil)
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGraveAsCost, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.SendtoGrave(g, REASON_COST)
end

function c84130865.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, function(c)
        return c84130865.filter(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
    end , tp, LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SendtoHand(g, tp, REASON_EFFECT)
end

-- endregion
