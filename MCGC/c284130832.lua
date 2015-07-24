-- MC群的幻影 节操
function c284130832.initial_effect(c)
    -- 放置到后场
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_MONSTER_SSET)
    e1:SetValue(TYPE_SPELL)
    c:RegisterEffect(e1)

    -- 破坏特招
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCondition(c284130832.condition)
    e2:SetOperation(c284130832.regop)
    c:RegisterEffect(e2)

    -- 反转发动
    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(284130832, 1))
    e3:SetCategory(CATEGORY_TOHAND)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e3:SetCode(EVENT_FLIP)
    e3:SetTarget(c284130832.thtg)
    e3:SetOperation(c284130832.thop)
    c:RegisterEffect(e3)
end

function c284130832.filter(c)
    return((c:IsCode(284130832)) or(c:IsCode(284130833))) and c:IsCanBeSpecialSummoned(e2, 0, tp, false, false, POS_FACEUP)
end

function c284130832.condition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEDOWN) and c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) then return true end
end

function c284130832.regop(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousPosition(POS_FACEDOWN) and c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) then
        local g = Duel.SelectMatchingCard(tp, c284130832.filter, tp, LOCATION_DECK + LOCATION_HAND + LOCATION_GRAVE, 0, 1, 3, nil)
        Duel.SpecialSummon(g, 0, tp, tp, false, false, POS_FACEUP)
    end
end

function c284130832.thtg(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return Duel.GetMatchingGroup(c284130832.tohandfilter, tp, LOCATION_GRAVE, 0, nil) end
    Duel.SetOperationInfo(0, CATEGORY_FLIP, nil, 0, tp, 1)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, 1)
    Duel.SetOperationInfo(0, CATEGORY_SEARCH, nil, 0, tp, 1)
end

function c284130832.thop(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.SelectMatchingCard(tp, c284130832.tohandfilter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SendtoHand(tc, tp, REASON_EFFECT)
    if tc:GetCount(tc) > 0 then
        local sg = Duel.GetFieldGroup(tp, LOCATION_HAND, 0, nil)
        local ag = sg:RandomSelect(ep, 2)
        Duel.SendtoGrave(ag, REASON_DISCARD + REASON_EFFECT)
    end
end

function c284130832.tohandfilter(c)
    return c:IsSetCard(0x2222)
end
