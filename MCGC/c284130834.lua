-- MC群的萌物 菜鸟

function c284130834.initial_effect(c)
    -- 召唤成功触发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetTarget(c284130834.target)
    e1:SetOperation(c284130834.operation)
    c:RegisterEffect(e1)
end

function c284130834.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:IsLocation(LOCATION_GRAVE)
    end
    if chk == 0 then
        return Duel.GetMatchingGroupCount(Card.IsAbleToRemove, tp, LOCATION_GRAVE, 0, nil) > 0
    end
    local g = Duel.SelectTarget(tp, Card.IsAbleToRemove, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, g, g:GetCount(), nil, 0)
end

function c284130834.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)

    -- 除外并且三回合回手
    local c1 = g:GetFirst()
    local e1 = Effect.CreateEffect(c1)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetLabel(0)
    e1:SetCondition(c284130834.thirdTriggerCondition)
    e1:SetOperation(c284130834.thirdTriggerOperation)
    c1:RegisterEffect(e1)
    Duel.Remove(c1, POS_FACEUP, REASON_EFFECT)
    
    -- 战破免疫三回合
    local c2 = e:GetHandler()
    local e2 = Effect.CreateEffect(c2)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e2:SetReset(RESET_STANDBY + RESET_SELF_TURN, 3)
    c2:RegisterEffect(e2)

    -- 送墓触发
    local e3 = Effect.CreateEffect(c2)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_TO_GRAVE)
    e3:SetReset(RESET_STANDBY + RESET_SELF_TURN, 3)
    e3:SetLabelObject(e1)
    e3:SetOperation(c284130834.toGraveTriggerOperation)
    c2:RegisterEffect(e3)
end

function c284130834.thirdTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c284130834.thirdTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    if count == 3 then
        Duel.SendtoHand(e:GetHandler(), tp, REASON_EFFECT)
        e:Reset()
    else
        e:SetLabel(count + 1)
    end
end

function c284130834.toGraveTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local te = e:GetLabelObject()
    Duel.SendtoDeck(te:GetHandler(), tp,nil, REASON_EFFECT)
    te:Reset()
end
