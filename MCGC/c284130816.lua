-- MC群的软妹 玲音

function c284130816.initial_effect(c)
    -- 灵摆召唤
    aux.AddPendulumProcedure(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 特招限制
    local e2 = Effect.CreateEffect(c)
    e2:SetRange(LOCATION_PZONE)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c284130816.specialSummonLimit)
    c:RegisterEffect(e2)

    -- 除外抽卡
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_REMOVE + CATEGORY_DRAW)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e3:SetRange(LOCATION_PZONE)
    e3:SetCountLimit(1)
    e3:SetCost(c284130816.drawCost)
    e3:SetTarget(c284130816.drawTarget)
    e3:SetOperation(c284130816.drawOperation)
    c:RegisterEffect(e3)

    -- 无祭品普招
    local e4 = Effect.CreateEffect(c)
    c:RegisterEffect(e4)

    -- 加入手卡
    local e5 = Effect.CreateEffect(c)
    e5:SetCategory(CATEGORY_TOHAND)
    c:RegisterEffect(e5)
end

function c284130816.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130816.specialSummonLimit(e, c)
    return not c284130816.filter(c)
end

function c284130816.drawFilter(c)
    return c284130816.filter(c) and Card.IsAbleToRemoveAsCost(c)
end

function c284130816.drawCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130816.drawFilter, tp, LOCATION_HAND, 0, 1, nil) and Duel.CheckLPCost(tp, 1000)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g = Duel.SelectMatchingCard(tp, c284130816.drawFilter, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.Remove(g, POS_FACEUP, REASON_COST)
    Duel.PayLPCost(tp, 1000)
end

function c284130816.drawTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsPlayerCanDraw(tp)
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(2)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, 1)
end

function c284130816.drawOperation(e, tp, eg, ep, ev, re, r, rp)
    if not e:GetHandler():IsRelateToEffect(e) then
        return
    end
    local p, d = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    Duel.draw(p, d, REASON_EFFECT)
end