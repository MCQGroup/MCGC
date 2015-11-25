-- region *.lua
-- 2015-11-24
-- 此文件由[BabeLua]插件自动生成

-- MC群的大小姐 木头
function c284130848.initial_effect(c)
    -- 超量
    c:EnableReviveLimit()
    aux.AddXyzProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, 0x2222), 6, 4, c284130848.ovfilter, aux.Stringid(284130848, 0))

    -- 超量成功触发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition()
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 一回合一次
    local e2 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCondition(c284130848.ignitionCondition)
    e1:SetCost(c284130848.ignitionCost)
    e1:SetOperation(c284130848.ignitionOperation)
    c:RegisterEffect(e2)

end

function c284130848.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130848.ovfilter(c)
    return c:IsCode(284130831)
end

function c284130848.xyzSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return bit.band(c:GetSummonType(), SUMMON_TYPE_XYZ) == SUMMON_TYPE_XYZ and c:GetMaterial():IsExists(Card.IsCode, 1, nil, 284130831)
end

function c284130848.xyzSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGrave, tp, LOCATION_DECK, 0, 1, 3, nil)
    Duel.SendtoGrave(g, REASON_EFFECT)
    local val = 100 * g:GetCount()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetValue(val)
    c:RegisterEffect(e1)
end

function c284130848.ignitionFilter(c)
    return c284130848.filter(c) and c:IsType(TYPE_MONSTER)
end

function c284130848.ignitionCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(c284130848.ignitionFilter, tp, LOCATION_ONFIELD, 0, nil)
end

function c284130848.ignitionCost(e, tp, eg, ep, ev, re, r, rp, chk)
    local c = e:GetHandler()
    if chk == 0 then
        return c:GetOverlayCount() > 0
    end
    c:RemoveOverlayCard(tp, 1, 1, REASON_COST)
end

function c284130848.ignitionOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DIRECT_ATTACK)
    e1:SetReset(RESET_PHASE + PHASE_END)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_CHANGE_DAMAGE)
    e2:SetValue(c284130848.halfVal)
    e2:SetReset(RESET_PHASE + PHASE_END)
    c:RegisterEffect(e2)
end

function c284130848.halfVal(e, re, val, r, rp, rc)
    return val / 2
end

-- endregion
