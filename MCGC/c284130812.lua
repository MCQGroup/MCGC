-- MC群的群主 纸睡
function c284130812.initial_effect(c)
    -- 通常召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
    e1:SetCondition(c284130812.summonCondition)
    e1:SetOperation(c284130812.summonOperation)
    e1:SetValue(SUMMON_TYPE_ADVANCE)
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetCode(EFFECT_LIMIT_SET_PROC)
    c:RegisterEffect(e2)

    -- 特殊召唤
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD)
    e3:SetCode(EFFECT_SPSUMMON_PROC)
    e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e3:SetRange(LOCATION_HAND)
    e3:SetCondition(c284130812.spSummonCondition)
    e3:SetOperation(c284130812.spSummonOperation)
    e3:SetValue(SUMMON_TYPE_SPECIAL + 0x2222222)
    c:RegisterEffect(e3)

    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e4:SetCode(EFFECT_SPSUMMON_CONDITION)
    e4:SetValue(c284130812.spSummonLimit)
    c:RegisterEffect(e4)

    -- 手卡召唤
    local e5 = Effect.CreateEffect(c)
    e5:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_DAMAGE)
    e5:SetType(EFFECT_TYPE_TRIGGER_O + EFFECT_TYPE_SINGLE)
    e5:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e5:SetCode(EVENT_SPSUMMON_SUCCESS)
    e5:SetTarget(c284130812.spSummonFromHandTarget)
    e5:SetOperation(c284130812.spSummonFromHandOperation)
    c:RegisterEffect(e5)

    -- 卡组检索
    local e6 = Effect.CreateEffect(c)
    e6:SetCategory(CATEGORY_SEARCH + CATEGORY_TOHAND)
    e6:SetType(EFFECT_TYPE_TRIGGER_F + EFFECT_TYPE_SINGLE)
    e6:SetCode(EVENT_SPSUMMON_SUCCESS)
    e6:SetOperation(c284130812.deckSearchOperation)
    c:RegisterEffect(e6)
end

function c284130812.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130812.getTributeCount(c)
    local g = Duel.GetMatchingGroup(c284130812.filter, c:GetControler(), LOCATION_GRAVE, 0, nil)
    local tributeCount = 3 - g:GetClassCount(Card.GetCode)
    if tributeCount < 0 then
        tributeCount = 0
    end
    return tributeCount
end

function c284130812.summonCondition(e, c)
    if c == nil then
        return true
    end
    return Duel.GetTributeCount(c) >= c284130812.getTributeCount(c) and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
end

function c284130812.summonOperation(e, tp, eg, ep, ev, re, r, rp, c)
    local tributeCount = c284130812.getTributeCount(c)
    if tributeCount > 0 then
        local g = Duel.SelectTribute(tp, c, tributeCount, tributeCount)
        c:SetMaterial(g)
        Duel.Release(g, REASON_SUMMON + REASON_MATERIAL)
    end
end

function c284130812.spSummonCondition(e, c)
    if c == nil then
        return true
    end
    local targetPlayer = c:GetControler()
    return Duel.GetLocationCount(targetPlayer, LOCATION_MZONE) > 0
    and Duel.IsExistingMatchingCard(c284130812.filter, targetPlayer, LOCATION_GRAVE, 0, 1, nil)
end

function c284130812.spSummonOperation(e, tp, eg, ep, ev, re, r, rp, c)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g = Duel.SelectMatchingCard(tp, c284130812.filter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.Remove(g, POS_FACEUP, REASON_COST)
end

function c284130812.spSummonLimit(e, se, sp, st)
    return bit.band(st, SUMMON_TYPE_SPECIAL + 0x2222222) == SUMMON_TYPE_SPECIAL + 0x2222222
end

function c284130812.deckSearchOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local g = Duel.SelectMatchingCard(tp, c284130812.filter, tp, LOCATION_DECK, 0, 1, 1, nil)
    if g:GetCount() > 0 then
        Duel.SendtoHand(g, nil, REASON_EFFECT)
        Duel.ConfirmCards(1 - tp, g)
    end
end

function c284130812.spSummonFromHandTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130812.filter, tp, LOCATION_HAND, 0, 1, nil) and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
    end
    local g = Duel.GetMatchingGroup(c284130812.filter, tp, LOCATION_HAND, 0, nil)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), 0, 0)
end

function c284130812.spSummonFromHandOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, c284130812.spSummonFromHandFilter, tp, LOCATION_HAND, 0, 0, Duel.GetLocationCount(tp, LOCATION_MZONE), nil, e, tp)
    Duel.SpecialSummon(g, 0, tp, tp, false, false, POS_FACEUP)
    Duel.PayLPCost(tp, g:GetSum(Card.GetAttack))
end

function c284130812.spSummonFromHandFilter(c, e, tp)
    return c284130812.filter(c) and c:IsCanBeSpecialSummoned(e, 0, tp, false, false)
end