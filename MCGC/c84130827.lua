-- 手滑的盘子

function c84130827.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_EQUIP)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e1:SetTarget(c84130827.target)
    e1:SetOperation(c84130827.operation)
    c:RegisterEffect(e1)

    -- 攻击力上升
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_EQUIP)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(500)
    c:RegisterEffect(e2)

    -- 贯穿伤害
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_EQUIP)
    e3:SetCode(EFFECT_PIERCE)
    c:RegisterEffect(e3)

    -- 代破
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_EQUIP)
    e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e4:SetCode(EFFECT_DESTROY_SUBSTITUTE)
    e4:SetValue(1)
    c:RegisterEffect(e4)

    -- 装备限制
    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_EQUIP_LIMIT)
    e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e5:SetValue(c84130827.equipLimit)
    c:RegisterEffect(e5)

    -- 战斗伤害触发
    local e6 = Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e6:SetCode(EVENT_BATTLE_DAMAGE)
    e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e6:SetRange(LOCATION_SZONE)
    e6:SetCondition(c84130827.battleTriggerCondition)
    e6:SetOperation(c84130827.battleTriggerOperation)
    c:RegisterEffect(e6)
end

function c84130827.filter(c)
    local code = c:GetCode()
    return c:IsFaceup() and(code == 84130825 or code == 84130841)
end

function c84130827.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:GetLocation() == LOCATION_MZONE and c84130827.filter(chkc)
    end
    if chk == 0 then
        return Duel.IsExistingTarget(c84130827.filter, tp, LOCATION_MZONE, 0, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_EQUIP)
    Duel.SelectTarget(tp, c84130827.filter, tp, LOCATION_MZONE, 0, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_EQUIP, e:GetHandler(), 1, 0, 0)
end

function c84130827.operation(e, tp, eg, ep, ev, re, r, rp)
    local tc = Duel.GetFirstTarget()
    local c = e:GetHandler(c)
    if c:GetLocation() == LOCATION_GRAVE then
        c:RegisterFlagEffect(0x2222, RESET_EVENT + RESET_LEAVE, 0, 1)
    end
    if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Equip(tp, c, tc)
    end
end

function c84130827.equipLimit(e, c)
    return c84130827.filter(c)
end

function c84130827.battleTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    local ec = e:GetHandler():GetEquipTarget()
    return ec and eg:IsContains(ec) and ep ~= tp and(ev <= 2000 or e:GetHandler():GetFlagEffect(0x2222) == 0)
end

function c84130827.battleTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    if ev <= 1000 then
        Duel.Recover(tp, ev, REASON_EFFECT)
    elseif ev <= 2000 then
        Duel.Draw(tp, 1, REASON_EFFECT)
    else
        if e:GetHandler():GetFlagEffect(0x2222) == 0 then
            local g = Duel.GetMatchingGroup(Card.IsDiscardable, tp, 0, LOCATION_HAND, nil)
            local dg = g:RandomSelect(tp, math.floor(ev / 1500))
            Duel.SendtoGrave(dg, REASON_DISCARD)
        end
    end
end