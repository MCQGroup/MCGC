-- MC群的战神 无情
function c284130811.initial_effect(c)
    -- 不能特殊召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    -- 攻击力上升
    local e2 = Effect.CreateEffect(c)
    e2:SetCateGory(CATEGORY_ATKCHANGE + CATEGORY_REMOVE)
    e2:SetType(EFFECT_TYPE_TRIGGER_F + EFFECT_TYPE_SINGLE)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)

    -- 不能直接攻击
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
    c:RegisterEffect(e3)
end

function c284130811.ATK_UpTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel:GetFieldGroupCount(tp, LOCATION_GRAVE, 0) > 0 and Duel:GetFieldGroupCount(tp, LOCATION_HAND, 0) > 0 and Duel:GetFieldGroupCount(tp, LOCATION_DECK, 0) > 0
    end
end

function c284130811.ATK_UpOperation(e, tp, eg, ep, ev, re, r, rp)
    local g1 = Duel.SelectMatchingCard(tp, Card.IsAbleToRemove, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    local g2 = Duel.SelectMatchingCard(tp, Card.IsAbleToRemove, tp, LOCATION_HAND, 0, 1, 1, nil)
    local g3 = Duel.SelectMatchingCard(tp, Card.IsAbleToRemove, tp, LOCATION_DECK, 0, 1, 1, nil)
    Duel.Remove(g1, 0, REASON_EFFECT)
    Duel.Remove(g2, 0, REASON_EFFECT)
    Duel.Remove(g3, 0, REASON_EFFECT)
    local atkup = g1:GetSum(Card.GetAttack) + g2:GetSum(Card.GetAttack) + g3:GetSum(Card.GetAttack)
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
    if Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_MZONE, 0, nil, 284130812) then
        e1:SetValue(atkup)
    else
        e1:SetValue(atkup / 2)
    end
    c:RegisterEffect(e1)
end