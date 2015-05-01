-- MC群的铁毡雨
function c284130856.initial_effect(c)
    -- Activate
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY + CATEGORY_DAMAGE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetHintTiming(0, 0x1e1)
    e1:SetTarget(c284130856.target)
    e1:SetOperation(c284130856.activate)
    c:RegisterEffect(e1)
end

function c284130856.cfilter(c)
    return c:IsFaceup() and c:IsCode(284130811) or c:IsCode(284130839)
end

function c284130856.filter(c)
    return c:IsFaceup() and c:IsDestructable()
end

function c284130856.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and c284130856.filter(chkc) end
    if not Duel.IsExistingMatchingCard(c284130856.cfilter, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, nil) then return false end
    if chk == 0 then return Duel.IsExistingTarget(c284130856.filter, tp, LOCATION_MZONE, LOCATION_MZONE, 1, nil) end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_DESTROY)
    local g = Duel.SelectTarget(tp, c284130856.filter, tp, LOCATION_MZONE, LOCATION_MZONE, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, g, 1, 0, 0)
    Duel.SetOperationInfo(0, CATEGORY_DAMAGE, nil, 0, PLAYER_ALL, 0)
end

function c284130856.activate(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFaceup() then
        local atk = tc:GetAttack()
        if Duel.Destroy(tc, REASON_EFFECT) > 0 then
            Duel.Damage(1 - tp, atk, REASON_EFFECT)
            Duel.Damage(tp, atk, REASON_EFFECT)
        end
    end
end
