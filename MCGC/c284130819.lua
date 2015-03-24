-- MC群的画师 玲音
function c284130819.initial_effect(c)
    -- 卡组检索
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SEARCH + CATEGORY_TOHAND)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetOperation(c284130819.operation)
end

function c284130819.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130819.operation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local g = Duel.SelectMatchingCard(tp, c284130819.filter, tp, LOCATION_DECK, 0, 1, 1, nil)
    if g:GetCount() > 0 then
        Duel.SendtoHand(g, nil, REASON_EFFECT)
        Duel.ConfirmCards(1 - tp, g)
    end
end