-- 玲音的镰刀尺

function c284130826.initial_effect(c)
    -- Activate
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_EQUIP)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetTarget(c284130826.target)
    e1:SetOperation(c284130826.operation)
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetRange(LOCATION_GRAVE + LOCATION_REMOVED)
    e2:SetOperation(c284130826.operation2)
    c:RegisterEffect(e2)

    -- Atk up
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_EQUIP)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetValue(500)
    c:RegisterEffect(e3)

    -- Equip limit
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_EQUIP_LIMIT)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e4:SetValue(c284130826.equipLimit)
    c:RegisterEffect(e4)

    -- 战破触发抽卡
    local e5 = Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(284130826, 0))
    e5:SetCategory(CATEGORY_DRAW)
    e5:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e5:SetCode(EVENT_BATTLE_DESTROYING)
    e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e5:SetRange(LOCATION_SZONE)
    e5:SetCondition(c284130826.drawCondition)
    e5:SetTarget(c284130826.drawTarget)
    e5:SetOperation(c284130826.drawOperation)
    c:RegisterEffect(e5)

    -- 代破
    local e6 = Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_EQUIP)
    e6:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e6:SetCode(EFFECT_DESTROY_SUBSTITUTE)
    e6:SetCondition(c284130826.condition)
    e6:SetValue(1)
    c:RegisterEffect(e6)

    -- 反击效果
    local e7 = Effect.CreateEffect(c)
    e7:SetDescription(aux.Stringid(284130826, 0))
    e7:SetCategory(CATEGORY_DISABLE)
    e7:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_QUICK_O)
    e7:SetCode(EVENT_CHAINING)
    e7:SetRange(LOCATION_SZONE)
    e7:SetCondition(c284130826.reflectCondition)
    e7:SetTarget(c284130826.reflectTarget)
    e7:SetOperation(c284130826.reflectOperation)
    c:RegisterEffect(e7)
end

function c284130826.filter(c)
    local code = c:GetCode()
    return c:IsFaceup() and code >= 284130816 and code <= 284130823
end

function c284130826.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:GetLocation() == LOCATION_MZONE and c284130826.filter(chkc)
    end
    if chk == 0 then
        return Duel.IsExistingTarget(c284130826.filter, tp, LOCATION_MZONE, 0, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_EQUIP)
    Duel.SelectTarget(tp, c284130826.filter, tp, LOCATION_MZONE, 0, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_EQUIP, e:GetHandler(), 1, 0, 0)
end

function c284130826.operation(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.GetFirstTarget()
    if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Equip(tp, e:GetHandler(), tc)
    end
end

function c284130826.operation2(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.GetFirstTarget()
    if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Equip(tp, e:GetHandler(), tc)
    end
end

function c284130826.equipLimit(e, c)
    return c284130826.filter(c)
end

function c284130826.drawCondition(e, tp, eg, ep, ev, re, r, rp)
    local ec = eg:GetFirst()
    local bc = ec:GetBattleTarget()
    return e:GetHandler():GetEquipTarget() == eg:GetFirst() and ec:IsControler(tp)
    and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE)
end

function c284130826.drawTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, 1)
end

function c284130826.drawOperation(e, tp, eg, ep, ev, re, r, rp)
    if not e:GetHandler():IsRelateToEffect(e) then
        return
    end
    local p, d = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    Duel.Draw(p, d, REASON_EFFECT)
end

function c284130826.condition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler():GetPreviousLocation() == LOCATION_HAND
end

function c284130826.reflectCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local ec = c:GetEquipTarget()

    if e:GetHandler():GetPreviousLocation() ~= LOCATION_HAND or c:IsStatus(STATUS_BATTLE_DESTROYED) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
        return false
    end

    local loc, tg = Duel.GetChainInfo(ev, CHAININFO_TRIGGERING_LOCATION, CHAININFO_TARGET_CARDS)
    if tg and tg:IsContains(ec) then
        return Duel.IsChainDisablable(ev) and loc ~= LOCATION_DECK
    else
        return false
    end
end

function c284130826.reflectTarget(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    local c = e:GetHandler()
    Duel.SendtoDeck(c, nil, 2, REASON_COST)
    Duel.SetOperationInfo(0, CATEGORY_DISABLE, eg, 1, 0, 0)
end

function c284130826.reflectOperation(e, tp, eg, ep, ev, re, r, rp, chk)
    Duel.NegateEffect(ev)
    Duel.Destroy(re:GetHandler(), REASON_EFFECT)
end
