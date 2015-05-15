-- MC群的追忆 木头
-- e1 参考[23015896]炎王神兽 大鹏不死鸟、[75500286]封印之黄金柜
-- e2 参考[10736540]湖中少女 薇薇安
-- e3 参考[19113101]阻碍番茄

function c284130831.initial_effect(c)
    -- 不能通常召唤
    c:EnableReviveLimit()

    -- 除外延迟特招
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e1:SetCost(c284130831.removeForSpSummonCost)
    e1:SetOperation(c284130831.removeForSpSummonOperation)
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
    e3:SetCode(EVENT_DAMAGE)
    e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    c:RegisterEffect(e3)
end


function c284130831.removeForSpSummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(Card.IsAbleToGraveAsCost, tp, LOCATION_DECK, 0, nil) > 0
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGraveAsCost, tp, LOCATION_DECK, 0, nil)
    Duel.SendtoGrave(g, REASON_COST)
end

function c284130831.removeForSpSummonOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()

    Duel.Remove(c, POS_FACEUP, REASON_EFFECT)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetRange(LOCATION_REMOVED)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetCountLimit(1)
    e1:SetReset(RESET_EVENT + 0x1fe0000 + RESET_PHASE + PHASE_STANDBY + RESET_SELF_TURN)
    e1:SetOperation(c284130831.delayTriggerOperation)
    c:RegisterEffect(e1)
end

function c284130831.delayTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    if Duel.GetTurnPlayer == tp then
        local c = e:GetHandler()
        local sel = Duel.SelectYesNo(tp, aux.Stringid(284130831, 0))
        if sel then
            Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, true, true, POS_FACEUP_ATTACK)
            c:CompleteProcedure()
        else
            Duel.SendtoHand(c, tp, REASON_EFFECT)
        end
    end
end