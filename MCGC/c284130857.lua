-- 来自植吧的使者

function c284130857.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW + CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c284130857.sptarget)
    e1:SetOperation(c284130857.operation)
    c:RegisterEffect(e1)
end

function c284130857.sptarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsPlayerCanDiscardDeck(tp, 1)
        and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
    end
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, 1)
end

function c284130857.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetDecktopGroup(tp, 1)
    local tc = g:GetFirst()
    Duel.Draw(tp, 1, REASON_EFFECT)
    if tc then
        Duel.ConfirmCards(1 - tp, tc)
        Duel.BreakEffect()
        if tc:IsSetCard(0X2222) then
            Duel.SpecialSummon(tc, 0, tp, tp, false, false, POS_FACEUP)
        else
            Duel.SendtoGrave(tc, REASON_EFFECT)
        end
        Duel.ShuffleHand(tp)
    end
end

