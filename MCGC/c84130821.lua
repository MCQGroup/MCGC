-- MC群的现充 玲音

function c84130821.initial_effect(c)
    -- 超量
    aux.AddXyzProcedure(c, nil, 4, 2)
    c:EnableReviveLimit()

    -- 除外
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCost(c84130821.removeCost)
    e1:SetTarget(c84130821.removeTarget)
    e1:SetOperation(c84130821.removeOperation)
    c:RegisterEffect(e1)

    -- 禁止盖伏怪兽
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_MSET)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTargetRange(1, 1)
    e2:SetCondition(c84130821.cannotSetCondition)
    e2:SetTarget(aux.TRUE)
    c:RegisterEffect(e2)

    local e3 = e2:Clone()
    e3:SetCode(EFFECT_CANNOT_TURN_SET)
    c:RegisterEffect(e3)

    local e4 = e2:Clone()
    e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e4:SetTarget(c84130821.specialSummonLimit)
    c:RegisterEffect(e4)
end

function c84130821.removeCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():CheckRemoveOverlayCard(tp, 1, REASON_COST)
    end
    e:GetHandler():RemoveOverlayCard(tp, 1, 1, REASON_COST)
end

function c84130821.removeFilter(c, e)
    return c:IsAbleToRemove() and c:IsCanBeEffectTarget(e)
end

function c84130821.removeTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c84130821.removeFilter, tp, LOCATION_MZONE, LOCATION_MZONE, 1, e:GetHandler(), e)
    end
    local g = Duel.SelectMatchingCard(tp, c84130821.removeFilter, tp, LOCATION_MZONE, LOCATION_MZONE, 1, 1, e:GetHandler(), e)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, g, 1, nil, 0)
end

function c84130821.removeOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if g:GetCount() > 0 then
        local c = g:GetFirst()
        local e = Effect.CreateEffect(c)
        e:SetCategory(CATEGORY_DISABLE)
        e:SetProperty(EFFECT_FLAG_SINGLE_RANGE + EFFECT_FLAG_IGNORE_IMMUNE)
        e:SetType(EFFECT_TYPE_SINGLE)
        e:SetCode(EFFECT_CANNOT_TRIGGER)
        e:SetReset(RESET_REMOVE)
        c:RegisterEffect(e)

        Duel.Remove(g, POS_FACEUP, REASON_EFFECT)
    end
end

function c84130821.cannotSetCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return c:IsFaceup() and c:GetOverlayCount() > 0
end

function c84130821.specialSummonLimit(e, c, sump, sumtype, sumpos, targetp)
    return bit.band(sumpos, POS_FACEDOWN) == POS_FACEDOWN
end