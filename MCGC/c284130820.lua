-- MC群的触手 玲音

function c284130820.initial_effect(c)
    -- 仪式召唤
    c:EnableReviveLimit()

    -- 特招效果
    e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetTarget(c284130820.toDeckTarget)
    e1:SetOperation(c284130820.toDeckOperation)
    c:RegisterEffect(e1)

    -- 丢弃效果
    e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SEARCH + CATEGORY_TOHAND)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_HAND)
    e2:SetCost(c284130820.toHandCost)
    e2:SetTarget(c284130820.toHandTarget)
    e2:SetOperation(c284130820.toHandOperation)
    c:RegisterEffect(e2)

end

function c284130820.toDeckTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(Card.IsAbleToDeck, tp, 0, LOCATION_HAND, nil) > 0
    end
    local g = Duel.SelectTarget(tp, Card.IsAbleToDeck, tp, 0, LOCATION_HAND, 1, 1, nil)
    if g:GetCount() > 0 then
        Duel.SetTargetCard(g)
        Duel.SetOperationInfo(0, CATEGORY_TODECK, g, 1, 0, 0)
    end
end

function c284130820.toDeckOperation(e, tp, eg, ep, ev, re, r, rp, chk)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if g:GetFirst():IsRelateToEffect(e) then
        Duel.ConfirmCards(1 - tp, g)
        Duel.SendtoDeck(g, nil, 2, REASON_EFFECT)
    end
end

function c284130820.toHandFilter(c)
    return c:IsSetCard(0x2222) and not c:IsCode(284130820)
end

function c284130820.toHandCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    local c = e:GetHandler()
    Duel.SendtoGrave(c, REASON_COST)
end

function c284130820.toHandTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130820.toHandFilter, tp, LOCATION_DECK, 0, 1, nil)
    end
    local g = Duel.SelectTarget(tp, c284130820.toHandFilter, tp, LOCATION_DECK, 0, 1, 1, nil)
    if g:GetCount() > 0 then
        Duel.SetTargetCard(g)
        Duel.SetOperationInfo(0, CATEGORY_SEARCH + CATEGORY_TOHAND, g, 1, nil, 0)
    end
end

function c284130820.toHandOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    local c = g:GetFirst()
    if c:IsRelateToEffect(e) then
        Duel.SendtoHand(c, nil, REASON_EFFECT)
    end
end