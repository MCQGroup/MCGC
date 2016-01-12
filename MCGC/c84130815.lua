-- MC群的大土豪 憨憨

function c84130815.initial_effect(c)
    -- 抽卡和返回卡组
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW + CATEGORY_TODECK)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(c84130815.drawCondition)
    e1:SetCost(c84130815.drawCost)
    e1:SetTarget(c84130815.drawTarget)
    e1:SetOperation(c84130815.drawOperation)
    c:RegisterEffect(e1)

    -- 回复
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_RECOVER)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_TO_GRAVE)
    e2:SetCondition(c84130815.recoverCondition)
    e2:SetTarget(c84130815.recoverTarget)
    e2:SetOperation(c84130815.recoverOperation)
    c:RegisterEffect(e2)
end

function c84130815.drawCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c84130815.drawCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsAbleToDeckAsCost, tp, LOCATION_HAND, 0, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToDeckAsCost, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_COST)
end

function c84130815.drawTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsPlayerCanDraw(tp)
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, 1)
end

function c84130815.drawOperation(e, tp, eg, ep, ev, re, r, rp)
    if not e:GetHandler():IsRelateToEffect(e) then
        return
    end
    local p, d = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    Duel.Draw(p, d, REASON_EFFECT)
end

function c84130815.filter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER)
end

function c84130815.recoverCondition(e, tp, eg, ep, ev, re, r, rp)
    return not e:GetHandler():IsReason(REASON_RETURN)
end

function c84130815.recoverTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return true
    end
    Duel.SetTargetPlayer(tp)
    local lp = Duel.GetMatchingGroupCount(c84130815.filter, tp, LOCATION_MZONE, 0, nil) * 700
    Duel.SetTargetParam(lp)
    Duel.SetOperationInfo(0, CATEGORY_RECOVER, nil, 0, tp, lp)
end

function c84130815.recoverOperation(e, tp, eg, ep, ev, re, r, rp)
    local p, lp = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    Duel.Recover(p, lp, REASON_EFFECT)
end