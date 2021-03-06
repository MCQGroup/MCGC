-- MC群的智者 二鱼

function c84130836.initial_effect(c)
    -- spsummon
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(84130836, 0))
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetTarget(c84130836.sptg)
    e1:SetOperation(c84130836.spop)
    c:RegisterEffect(e1)
end

function c84130836.filter(c, e, tp)
    return c:GetLevel() <= 4 and c:IsCanBeSpecialSummoned(e, 0, tp, false, false) and c:IsSetCard(0x2222)
end

function c84130836.sptg(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
        and Duel.IsExistingMatchingCard(c84130836.filter, tp, LOCATION_GRAVE, 0, 1, nil, e, tp)
    end
    local g = Duel.SelectTarget(tp, c84130836.filter, tp, LOCATION_GRAVE, 0, 1, 1, nil, e, tp)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, nil, 1, tp, LOCATION_GRAVE)
end

function c84130836.spop(e, tp, eg, ep, ev, re, r, rp)
    if Duel.GetLocationCount(tp, LOCATION_MZONE) <= 0 then
        return
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
    local tc = Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc, 0, tp, tp, false, false, POS_FACEUP) then
        local e1 = Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetReset(RESET_EVENT + 0x1FE0000)
        tc:RegisterEffect(e1)

        local e2 = e1:Clone()
        e2:SetCode(EFFECT_DISABLE_EFFECT)
        tc:RegisterEffect(e2)
    end
    Duel.SpecialSummonComplete()
end
