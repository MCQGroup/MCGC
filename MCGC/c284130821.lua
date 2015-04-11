-- MC群的现充 玲音
function c284130821.initial_effect(c)
    -- 超量
    aux.AddXyzProcedure(c, nil, 4, 2)
    c:EnableReviveLimit()

    -- 除外
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCost(c284130821.removeCost)
    e1:SetTarget(c284130821.removeTarget)
    e1:SetOperation(c284130821.removeOperation)
    c:RegisterEffect(e1)

    -- 禁止盖伏怪兽
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_MSET)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(1, 1)
    e2:SetCondition(c284130821.setCondition)
    e2:SetTarget(aux.TRUE)
    c:RegisterEffect(e2)

    local e3 = e2:Clone()
    e3:SetCode(EFFECT_CANNOT_TURN_SET)
    c:RegisterEffect(e3)

    local e4 = e2:Clone()
    e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e4:SetTarget(c284130821.specialSummonLimit)
    c:RegisterEffect(e4)
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
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if g:GetCount() > 0 then
        Duel.Remove(g, POS_FACEUP, REASON_EFFECT)
        -- TODO: 怎么使卡片效果不能发动？
    end
end

function c284130821.setCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return c:IsFaceup() and c:GetOverlayCount() > 0
end

function c284130821.specialSummonLimit(e, c, sump, sumtype, sumpos, targetp)
    return bit.band(sumpos, POS_FACEDOWN) > 0
end