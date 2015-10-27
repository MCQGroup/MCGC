-- MC群的技术宅 饭2

function c284130846.initial_effect(c)
    -- 超量
    -- 7星【MC群】*2或【MC群】二星以下或三阶以上
    aux.AddXyzProcedure(c, c284130846.filter, 7, 2, c284130846.ovfilter, aux.Stringid(284130846, 0))
    c:EnableReviveLimit()

    -- 战破免疫
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetValue(1)
    c:RegisterEffect(e1)

    -- 效果代破
    -- 参考[78156759]发条机雷 发条雷
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_CONTINUOUS + EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(EFFECT_DESTROY_REPLACE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetTarget(c284130846.replaceTarget)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_SEARCH)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_PHASE + PHASE_END)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1)
    e3:SetCondition(c284130846.searchCondition)
    e3:SetTarget(c284130846.searchTarget)
    e3:SetOperation(c284130811.searchOperation)
    c:RegisterEffect(e3)

    -- 维持代价
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e4:SetRange(LOCATION_MZONE)
    e4:SetOperation(c284130846.keepOperation)
    c:RegisterEffect(e4)
end

function c284130846.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130846.ovfilter(c)
    return c284130846.filter(c) and c:IsFaceup() and(c:GetLevel() <= 2 or c:GetRank() >= 3)
end

function c284130846.replaceTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return e:GetHandler():CheckRemoveOverlayCard(tp, 1, REASON_EFFECT)
    end
    if Duel.SelectYesNo(tp, aux.Stringid(284130846, 1)) then
        e:GetHandler():RemoveOverlayCard(tp, 1, 1, REASON_EFFECT)
        e:GetHandler():RegisterFlagEffect(284130846, RESET_EVENT + 0x1fe0000 + RESET_PHASE + PHASE_END, 0, 1)
        return true
    else
        return false
    end
end

function c284130846.searchFilter(c)
    return c:IsType(TYPE_SPELL) and c284130846.filter(c)
end

function c284130846.searchCondition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler():GetFlagEffect(78156759) ~= 0
end

function c284130846.searchTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130846.searchFilter, tp, LOCATION_DECK + LOCATION_GRAVE, 1, 1, nil)
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_ATOHAND)
    local g = Duel.SelectMatchingCard(tp, c284130846.searchFilter, tp, LOCATION_DECK + LOCATION_GRAVE, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_SEARCH, g, 1, nil, nil)
end

function c284130846.searchOperation(e, tp, eg, ep, ev, re, r, rp)
    local test, g, count, player, param = Duel.GetOperationInfo(0, CATEGORY_SEARCH)
    if test then
        Duel.SendtoHand(g, tp, REASON_EFFECT)
    end
end

function c284130846.keepOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if c:CheckRemoveOverlayCard(tp, 1, REASON_DISCARD) then
        local sel = Duel.SelectYesNo(tp, aux.Stringid(284130846, 2))
        if sel then
            c:RemoveOverlayCard(tp, 1, 1, REASON_DISCARD)
            return
        end
    end
    Duel.Destroy(c, REASON_EFFECT, LOCATION_GRAVE)
end