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
    e2:SetRange(LOCATION_PZONE)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c284130825.specialSummonLimit)
    c:RegisterEffect(e2)

    -- 回复
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetCategory(CATEGORY_TODECK + CATEGORY_RECOVER + CATEGORY_SEARCH + CATEGORY_TOHAND)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_PZONE)
    e3:SetCountLimit(1)
    e3:SetCost(c284130816.drawCost)
    e3:SetTarget(c284130816.drawTarget)
    e3:SetOperation(c284130816.drawOperation)
    c:RegisterEffect(e3)

    -- 特招规则

    -- 特招触发

end

function c284130825.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130825.specialSummonLimit(e, c)
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
    local g = Duel.SelectMatchingCard(tp, aux.TRUE, tp, LOCATION_EXTRA, 0, 1, 1, nil)
end