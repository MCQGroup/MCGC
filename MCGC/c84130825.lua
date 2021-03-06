-- MC群的现充 手滑

function c84130825.initial_effect(c)
    -- 灵摆规则
    aux.EnablePendulumAttribute(c)

    -- 手卡发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetCondition(c84130825.OnHandActivationCondition)
    e1:SetOperation(c84130825.OnHandActivationOperation)
    c:RegisterEffect(e1)

    -- 限制特招
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetRange(LOCATION_PZONE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c84130825.limitSpecialSummon)
    c:RegisterEffect(e2)

    -- 回复
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetCategory(CATEGORY_TODECK + CATEGORY_RECOVER + CATEGORY_SEARCH + CATEGORY_TOHAND)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_PZONE)
    e3:SetCountLimit(1)
    e3:SetCost(c84130825.recoverCost)
    e3:SetTarget(c84130825.recoverTarget)
    e3:SetOperation(c84130825.recoverOperation)
    c:RegisterEffect(e3)

    -- 特招触发
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_DELAY + EFFECT_FLAG_CARD_TARGET)
    e4:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_ATKCHANGE)
    e4:SetCode(EVENT_SPSUMMON_SUCCESS)
    e4:SetCondition(c84130825.spsummonSuccessCondition)
    e4:SetTarget(c84130825.spsummonSuccessTarget)
    e4:SetOperation(c84130825.spsummonSuccessOperation)
    c:RegisterEffect(e4)
end

function c84130825.lainFilter(c)
    return c:GetCode() >= 84130816 and c:GetCode() <= 84130823
end

function c84130825.OnHandActivationCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.CheckLocation(tp, LOCATION_SZONE, 6) or Duel.CheckLocation(tp, LOCATION_MZONE, 7) or(Duel.IsExistingMatchingCard(c84130825.lainFilter, tp, LOCATION_MZONE + LOCATION_GRAVE + LOCATION_REMOVED, 0, 1, nil) and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0)
end

function c84130825.OnHandActivationOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local choose = 0
    local test1 = Duel.CheckLocation(tp, LOCATION_SZONE, 6) or Duel.CheckLocation(tp, LOCATION_SZONE, 7)
    local test2 = Duel.IsExistingMatchingCard(c84130825.lainFilter, tp, LOCATION_MZONE + LOCATION_GRAVE + LOCATION_REMOVED, 0, 1, nil) and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0

    if test1 and test2 then
        choose = Duel.SelectOption(tp, aux.Stringid(84130825, 0), aux.Stringid(84130825, 1))
    elseif test1 then
        choose = 0
    elseif test2 then
        choose = 1
    end

    if choose == 0 then
        Duel.MoveToField(c, tp, tp, LOCATION_SZONE, POS_FACEUP, true)
        if Duel.CheckLocation(tp, LOCATION_SZONE, 6) then
            Duel.MoveSequence(c, 6)
        elseif Duel.CheckLocation(tp, LOCATION_SZONE, 7) then
            Duel.MoveSequence(c, 7)
        end
    elseif choose == 1 then
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL + 0x2222, tp, tp, false, false, pos)
    end
end

function c84130825.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130825.limitSpecialSummon(e, c)
    return not c84130825.filter(c)
end

function c84130825.recoverCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(aux.TRUE, tp, LOCATION_HAND, 0, 2, nil)
    end
    local g = Duel.SelectMatchingCard(tp, aux.TRUE, tp, LOCATION_HAND, 0, 2, 2, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_COST)
    Duel.ShuffleDeck(tp)
end

function c84130825.recoverTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return true
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1000)
    Duel.SetOperationInfo(0, CATEGORY_RECOVER, nil, 0, tp, 1000)
end

function c84130825.recoverOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Recover(tp, 1000, REASON_EFFECT)
    if Duel.SelectYesNo(tp, aux.Stringid(84130825, 2)) then
        local g = Duel.SelectMatchingCard(tp, aux.TRUE, tp, LOCATION_REMOVED, 0, 1, 1, nil)
        Duel.SendtoHand(g, tp, REASON_EFFECT)
    end
end

function c84130825.spsummonSuccessFilter(c, e)
    return c84130825.lainFilter(c) and c:IsCanBeSpecialSummoned(e, SUMMON_TYPE_SPECIAL, c:GetControler(), false, false)
end

function c84130825.spsummonSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    return bit.band(e:GetHandler():GetSummonType(), 0x2222) == 0x2222 and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
end

function c84130825.spsummonSuccessTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c84130825.spsummonSuccessFilter, tp, LOCATION_HAND + LOCATION_GRAVE, 0, 1, nil, e)
    end
    local g = Duel.SelectMatchingCard(tp, c84130825.spsummonSuccessFilter, tp, LOCATION_HAND + LOCATION_GRAVE, 0, 1, 1, nil, e)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), nil, 0)
end

function c84130825.spsummonSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
    local c1 = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS):GetFirst()
    local pos = Duel.SelectPosition(tp, c1, POS_FACEUP)
    Duel.SpecialSummon(c1, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos)

    local c2 = e:GetHandler()
    local e1 = Effect.CreateEffect(c2)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_EVENT + 0x1ff0000)
    e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
    e1:SetValue(c1:GetAttack())
    c2:RegisterEffect(e1)
end
