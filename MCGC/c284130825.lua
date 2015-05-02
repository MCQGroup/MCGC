-- MC群的现充 手滑
function c284130825.initial_effect(c)
    -- 灵摆
    aux.AddPendulumProcedure(c)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 限制特招
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetRange(LOCATION_PZONE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c284130825.limitSpecialSummon)
    c:RegisterEffect(e2)

    -- 回复
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetCategory(CATEGORY_TODECK + CATEGORY_RECOVER + CATEGORY_SEARCH + CATEGORY_TOHAND)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_PZONE)
    e3:SetCountLimit(1)
    e3:SetCost(c284130825.recoverCost)
    e3:SetTarget(c284130825.recoverTarget)
    e3:SetOperation(c284130825.recoverOperation)
    c:RegisterEffect(e3)

    -- 特招规则
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_SPSUMMON_PROC)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e4:SetRange(LOCATION_HAND)
    e4:SetCondition(c284130825.specialSummonCondition)
    e4:SetOperation(c284130825.specialSummonOperation)
    c:RegisterEffect(e4)

    -- 特招触发
    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e5:SetProperty(CATEGORY_SPECIAL_SUMMON + CATEGORY_ATKCHANGE)
    e5:SetCode(EVENT_SPSUMMON_SUCCESS)
    e5:SetCondition(c284130825.spsummonSuccessCondition)
    e5:SetTarget(c284130825.spsummonSuccessTarget)
    e5:SetOperation(c284130825.spsummonSuccessOperation)
    c:RegisterEffect(e5)
end

function c284130825.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130825.limitSpecialSummon(e, c)
    return not c284130825.filter(c)
end

function c284130825.recoverCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(aux.TRUE, tp, LOCATION_HAND, 0, 2, nil)
    end
    local g = Duel.SelectMatchingCard(tp, aux.TRUE, tp, LOCATION_HAND, 0, 2, 2, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_COST)
    Duel.ShuffleDeck(tp)
end

function c284130825.recoverTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return true
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1000)
    Duel.SetOperationInfo(0, CATEGORY_RECOVER, nil, 0, tp, 1000)
end

function c284130825.recoverOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Recover(tp, 1000, REASON_EFFECT)
    if Duel.SelectYesNo(tp, aux.Stringid(284130816, 0)) then
        local g = Duel.SelectMatchingCard(tp, aux.TRUE, tp, LOCATION_REMOVED, 0, 1, 1, nil)
        Duel.SendtoHand(g, tp, REASON_EFFECT)
    end
end

function c284130825.lainFilter(c)
    return c:GetCode() >= 284130816 and c:GetCode() <= 284130823
end

function c284130825.specialSummonCondition(e, c)
    local tp = c:GetControler()
    return Duel.IsExistingMatchingCard(c284130825.lainFilter, tp, LOCATION_MZONE + LOCATION_GRAVE + LOCATION_REMOVED, 0, 2, nil)
end

function c284130825.specialSummonOperation(e, tp, eg, ep, ev, re, r, rp, c)
    e:GetHandler().flag = true
end

function c284130825.spsummonSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler().flag
end

function c284130825.spsummonSuccessTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return ture
    end
    local g = Duel.SelectMatchingCard(tp, c284130825.lainFilter, tp, LOCATION_HAND + LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), nil, 0)
end

function c284130825.spsummonSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
    local c1 = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS):GetFirst()
    Duel.SpecialSummon(c1, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP_ATTACK)

    local c2 = e:GetHandler()
    local e1 = Effect.CreateEffect(c2)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_EVENT + 0x1ff0000)
    e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
    e1:SetValue(c1:GetAttack())
    c2:RegisterEffect(e1)
end
