-- MC群的追忆 木头
-- e1 参考[23015896]炎王神兽 大鹏不死鸟、[75500286]封印之黄金柜
-- e2 参考[10736540]湖中少女 薇薇安
-- e3 参考[40640059]栗子球

function c84130831.initial_effect(c)
    -- 不能通常召唤
    c:EnableReviveLimit()

    -- 除外延迟特招
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e1:SetCost(c84130831.removeForSpSummonCost)
    e1:SetOperation(c84130831.removeForSpSummonOperation)
    c:RegisterEffect(e1)

    -- 不入墓地
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
    e2:SetValue(LOCATION_REMOVED)
    c:RegisterEffect(e2)

    -- 手卡丢弃免伤
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_QUICK_O)
    e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    e3:SetRange(LOCATION_HAND)
    e3:SetCondition(c84130831.preBattleTriggerCondition)
    e3:SetCost(c84130831.preBattleTriggerCost)
    e3:SetOperation(c84130831.preBattleTriggerOperation)
    c:RegisterEffect(e3)
end


function c84130831.removeForSpSummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_COST + REASON_TEMPORARY)
end

function c84130831.removeForSpSummonOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGraveAsCost, tp, LOCATION_DECK, 0, 1, 1, nil)
    Duel.SendtoGrave(g, REASON_EFFECT)

    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetRange(LOCATION_REMOVED)
    e1:SetCondition(c84130831.delayTriggerCondition)
    e1:SetOperation(c84130831.delayTriggerOperation)
    c:RegisterEffect(e1)
end

function c84130831.delayTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c84130831.delayTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local sel = Duel.SelectYesNo(tp, aux.Stringid(84130831, 0))

    if sel then
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, true, true, pos)
        c:CompleteProcedure()
    else
        Duel.SendtoHand(c, tp, REASON_EFFECT)
    end
    e:Reset()
end


function c84130831.preBattleTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() ~= tp and ep == tp
end

function c84130831.preBattleTriggerCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():IsDiscardable()
    end
    Duel.SendtoGrave(e:GetHandler(), REASON_COST + REASON_DISCARD)
end

function c84130831.preBattleTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.ChangeBattleDamage(ep, 0)
end
