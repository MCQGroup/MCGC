-- 罐罐子的倾家荡产？！
function c284130854.initial_effect(c)
    -- Activate
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TODECK + CATEGORY_DRAW)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c284130854.target)
    e1:SetOperation(c284130854.activate)
    c:RegisterEffect(e1)
end

function c284130854.target(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsPlayerCanDraw(tp)
        and Duel.IsExistingMatchingCard(Card.IsAbleToDeck, tp, LOCATION_HAND, 0, 1, e:GetHandler())
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetOperationInfo(0, CATEGORY_TODECK, nil, 1, tp, LOCATION_HAND)
end

function c284130854.activate(e, tp, eg, ep, ev, re, r, rp)
    p = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER)
    Duel.Hint(HINT_SELECTMSG, p, HINTMSG_TODECK)
    Group.CreateGroup(g)
    g = Duel.SelectMatchingCard(p, Card.IsAbleToDeckAsCost, p, LOCATION_HAND, 0, 1, 63, nil)
    if g:GetCount() == 0 then return end
    d = g:GetCount() + 1
    Duel.SendtoDeck(g, nil, 2, REASON_EFFECT)
    Duel.ShuffleDeck(p)
    Duel.BreakEffect()
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE + PHASE_END)
    e1:SetReset(RESET_PHASE + PHASE_END)
    e1:SetCountLimit(1)
    e1:SetOperation(c284130854.draw)
    Duel.RegisterEffect(e1, tp)
end

function c284130854.draw(e, tp, eg, ep, ev, re, r, rp)
    Duel.Draw(p, d, REASON_EFFECT)
end
