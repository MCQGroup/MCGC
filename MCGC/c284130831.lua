-- MC群的追忆 木头
-- e1, e2 参考[23015896]炎王神兽 大鹏不死鸟

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

    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e2:SetRange(LOCATION_REMOVED)
    e2:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e2:SetLabelObject(e1)
    c:RegisterEffect(e2)

    -- 不入墓地
    local e3 = Effect.CreateEffect(c)
    c:RegisterEffect(e3)

    -- 手卡丢弃免伤
    local e4 = Effect.CreateEffect(c)
    c:RegisterEffect(e4)
end


function c284130831.removeForSpSummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(Card.IsAbleToGraveAsCost, tp, LOCATION_DECK, 0, nil) > 0
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGraveAsCost, tp, LOCATION_DECK, 0, nil)
    Duel.SendtoGrave(g, REASON_COST)
end

function c284130831.removeForSpSummonOperation(e, tp, eg, ep, ev, re, r, rp)

end

function c284130831.delayTriggerCondition(e, tp, eg, ep, ev, re, r, rp)

end

function c284130831.delayTriggerOperation(e, tp, eg, ep, ev, re, r, rp)

end