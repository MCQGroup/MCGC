-- MC群的现充 玲音
function c284130821.initial_effect(c)
    -- 超量
    aux.AddXyzProcedure(c, nil, 4, 2)
    c:EnableReviveLimit()

    -- 除外
    e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCost(c284130821.removeCost)
    e1:SetTarget(c284130821.removeTarget)
    e1:SetOperation(c284130821.removeOperation)
    c:RegisterEffect(e1)

    -- 禁止盖伏怪兽
    e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCondition(c284130821.setCondition)
    e2:SetOperation(c284130821.setOperation)
    c:RegisterEffect(e2)
end

function c284130821.removeCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():CheckRemoveOverlayCard(tp, 1, REASON_COST)
    end
    e:GetHandler():RemoveOverlayCard(tp, 1, 1, REASON_COST)
end

function c284130821.removeTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsAbleToRemove, tp, LOCATION_MZONE, LOCATION_MZONE, 1, e:GetHandler())
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToRemove, tp, LOCATION_MZONE, LOCATION_MZONE, 1, 1, e:GetHandler())
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, category_remove, g, 1, nil, 0)
end

function c284130821.removeOperation(e, tp, eg, ep, ev, re, r, rp)
end

function c284130821.setCondition(e, tp, eg, ep, ev, re, r, rp)
end

function c284130821.setOperation(e, tp, eg, ep, ev, re, r, rp)
end