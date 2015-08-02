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
end
