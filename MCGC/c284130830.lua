-- MC群的隐者 柠檬

function c284130830.initial_effect(c)
    -- 不能特殊召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    -- 通常召唤触发
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_DAMAGE)
    e2:SetType(EFFECT_TYPE_TRIGGER_O + EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_CARD_TARGET)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetTarget(c284130830.summonTriggerTarget)
    e2:SetOperation(c284130830.summonTriggerOperation)
    c:RegisterEffect(e2)
end

function c284130830.summonTriggerTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(Card.IsType, tp, 0, LOCATION_MZONE, nil, TYPE_MONSTER) > 0
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsType, tp, 0, LOCATION_MZONE, 1, 1, nil, TYPE_MONSTER)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_ATKCHANGE, g, g:GetCount(), nil, 0)
end

function c284130830.summonTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS):GetFirst()
    local e1 = Effect.CreateEffect(tc)
    e1:SetCategory(CATEGORY_ATKCHANGE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(-1000)
    tc:RegisterEffect(e1)

    local c = e:GetHandler()
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(EFFECT_CANNOT_ATTACK)
    e2:SetReset(RESET_END)
    c:RegisterEffect(e2)
end