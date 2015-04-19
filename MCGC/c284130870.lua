-- 与镰刀尺的契约
function c284130870.initial_effect(c)
    aux.AddRitualProcGreater(c, aux.FilterBoolFunction(Card.IsCode, 284130820))

    -- 墓地除外触发特招和装备
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_EQUIP)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCost(c284130870.removeCost)
    e1:SetTarget(c284130870.removeTarget)
    e1:SetOperation(c284130870.removeOperation)
    c:RegisterEffect(e1)

    -- 手卡丢弃触发卡组检索
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SEARCH + CATEGORY_TOHAND)
    e2:SetRange(LOCATION_HAND)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCost(c284130870.toGraveCost)
    e2:SetTarget(c284130870.toGraveTarget)
    e2:SetOperation(c284130870.toGraveOperation)
    c:RegisterEffect(e2)
end

function c284130870.removeFilter(c)
    return c:GetCode() > 284130816 and c:GetCode() < 284130823
end

function c284130870.removeCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():IsAbleToRemoveAsCost()
    end
    Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_COST)
end

function c284130870.removeTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130870.removeFilter, tp, LOCATION_GRAVE, 0, 1, nil) and Duel.IsExistingMatchingCard(Card.IsCode, tp, LOCATION_GRAVE + LOCATION_HAND, 0, 1, nil, 284130826)
    end
    local g = Duel.SelectMatchingCard(tp, c284130870.removeFilter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON + CATEGORY_EQUIP, g, g:GetCount(), nil, 0)
end

function c284130870.removeOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS):GetFirst()
    Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp)

    local equipCard = Duel.SelectMatchingCard(tp, Card.IsCode, tp, LOCATION_HAND + LOCATION_GRAVE, 0, 1, 1, nil, 284130826)
    Duel.Equip(tp, equipCard, c)

    if c:IsRelateToEffect(e) then
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
        e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
        e1:SetCode(EFFECT_DISABLE)
        e1:SetCategory(CATEGORY_DISABLE)
        c:RegisterEffect(e1)
    end

end

function c284130870.toGraveFilter(c)
    return c:IsCode(284130870) or c:IsCode(284130826)
end

function c284130870.toGraveCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():IsAbleToGraveAsCost()
    end
    Duel.SendtoGrave(e:GetHandler(), REASON_COST)
end

function c284130870.toGraveTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130870.toGraveFilter, tp, LOCATION_DECK, 0, 1, nil)
    end
    local g = Duel.SelectTarget(tp, c284130870.toGraveFilter, tp, LOCATION_DECK, 0, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_SEARCH + CATEGORY_TOHAND, g, g:GetCount(), nil, 0)
end

function c284130870.toGraveOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    Duel.SendtoHand(g, tp, REASON_EFFECT)
end