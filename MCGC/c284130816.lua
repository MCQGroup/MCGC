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
    e3:SetType(EFFECT_TYPE_SINGLE)
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
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e4:SetCode(EFFECT_SUMMON_PROC)
    e4:SetCondition(c284130816.summonCondition)
    c:RegisterEffect(e4)

    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_SUMMON_COST)
    e5:SetOperation(c284130816.summonOperation)
    c:RegisterEffect(e5)

    local e6 = e4:Clone(c)
    e6:SetCode(EFFECT_SET_PROC)
    c:RegisterEffect(e6)

    local e7 = e5:Clone(c)
    e7:SetCode(EFFECT_MSET_COST)
    c:RegisterEffect(e7)

    -- 加入手卡
    local e8 = Effect.CreateEffect(c)
    e8:SetCategory(CATEGORY_TOHAND + CATEGORY_SEARCH)
    e8:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e8:SetCode(EVENT_SUMMON_SUCCESS)
    e8:SetCategory(CATEGORY_TOHAND)
    e8:SetCountLimit(1)
    e8:SetTarget(c284130816.toHandTarget)
    e8:SetOperation(c284130816.toHandOperation)
    c:RegisterEffect(e8)

    local e9 = e8:Clone()
    e9:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e9)

    local e10 = e8:Clone()
    e10:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    c:RegisterEffect(e10)
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

function c284130816.drawTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
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

function c284130816.summonCondition(e, c, minc)
    if c == nil then
        return true
    end
    return minc == 0 and c:GetLevel() > 4 and Duel.GetLocationCount(c:GetControler(), LOCATION_MZONE) > 0
end

function c284130816.summonOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CHANGE_LEVEL)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition(c284130816.summonOperationCondition)
    e1:SetValue(4)
    e1:SetReset(RESET_EVENT + 0xff0000)
    c:RegisterEffect(e1)
end

function c284130816.summonOperationCondition(e)
    return e:GetHandler():GetMaterialCount() == 0 and bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_NORMAL) == SUMMON_TYPE_NORMAL
end

function c284130816.toHandTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingTarget(Card.IsCode, tp, LOCATION_DECK, 0, 1, nil, 284130826)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local g = Duel.SelectTarget(tp, Card.IsCode, tp, LOCATION_DECK, 0, 1, 1, nil, 284130826)
    Duel.SetOperationInfo(0, CATEGORY_SEARCH + CATEGORY_TOHAND, g, 1, 0, 0)
end

function c284130816.toHandOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local g = Duel.GetOperationInfo(0, CHAININFO_TARGET_CARDS)
    if c:IsRelateToEffect(e) and g:GetFirst():IsRelateToEffect(e) then
        Duel.SendtoHand(tc, tp, REASON_EFFECT)
    end
end