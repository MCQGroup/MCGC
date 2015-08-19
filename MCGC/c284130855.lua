-- MCÈºµÄºì°ü£¡

function c284130855.initial_effect(c)
    -- Activate
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DAMAGE)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCountLimit(1)
    e1:SetTarget(c284130855.target)
    e1:SetOperation(c284130855.activate)
    c:RegisterEffect(e1)
end

function c284130855.target(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then return true end
    local a = Duel.GetFieldGroupCount(tp, LOCATION_MZONE, 0) * 500
    local b = Duel.GetFieldGroupCount(1 - tp, LOCATION_MZONE, 0) * 500
    dam = a + b
    Duel.SetTargetParam(dam)
    Duel.SetOperationInfo(0, CATEGORY_DAMAGE, nil, 0, 1 - tp, dam)
end

function c284130855.filter(c, e, tp)
    return c:GetCode() == 284130815 and c:IsCanBeSpecialSummoned(e, 0, sp, false, false)
end 

function c284130855.activate(e, tp, eg, ep, ev, re, r, rp)
    local p = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER)
    x = Duel.GetLP(tp)
    Duel.Recover(tp, dam, REASON_EFFECT)
    Duel.Recover(1 - tp, dam, REASON_EFFECT)
    y = Duel.GetLP(tp)
    z = y - x
    if z >= 2000 then
        cg = Duel.GetMatchingGroup(c284130855.filter, tp, LOCATION_DECK + LOCATION_HAND + LOCATION_GRAVE, 0, nil, e, tp)
        if cg:GetCount() > 0 and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0 then
            if Duel.SelectYesNo(tp, aux.Stringid(30241314, 0)) then
                Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
                local sg = cg:Select(tp, 1, 1, nil)
                Duel.SpecialSummon(sg, 0, tp, tp, false, false, POS_FACEUP)
            end
        end
    end
end
