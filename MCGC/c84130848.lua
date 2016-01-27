-- region *.lua
-- 2015-11-24
-- 此文件由[BabeLua]插件自动生成

-- MC群的大小姐 木头
function c84130848.initial_effect(c)
    -- 超量
    c:EnableReviveLimit()
    aux.AddXyzProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, 0x2222), 6, 4, c84130848.ovfilter, aux.Stringid(84130848, 0))

    -- 超量成功触发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c84130848.xyzSuccessCondition)
    e1:SetOperation(c84130848.xyzSuccessOperation)
    c:RegisterEffect(e1)

    -- 一回合一次
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c84130848.ignitionCondition)
    e2:SetCost(c84130848.ignitionCost)
    e2:SetOperation(c84130848.ignitionOperation)
    c:RegisterEffect(e2)

end

function c84130848.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130848.ovfilter(c)
    return c:IsCode(84130831)
end

function c84130848.xyzSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return bit.band(c:GetSummonType(), SUMMON_TYPE_XYZ) == SUMMON_TYPE_XYZ and c:GetMaterial():IsExists(Card.IsCode, 1, nil, 84130831)
end

function c84130848.xyzSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToGrave, tp, LOCATION_DECK, 0, 1, 3, nil)
    Duel.SendtoGrave(g, REASON_EFFECT)
    local val = 100 * g:GetCount()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(val)
    c:RegisterEffect(e1)
end

function c84130848.ignitionFilter(c)
    return c84130848.filter(c) and c:IsType(TYPE_MONSTER)
end

function c84130848.ignitionCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(c84130848.ignitionFilter, tp, LOCATION_ONFIELD, 0, 1, nil)
end

function c84130848.ignitionCost(e, tp, eg, ep, ev, re, r, rp, chk)
    local c = e:GetHandler()
    if chk == 0 then
        return c:CheckRemoveOverlayCard(tp, 1, REASON_COST)
    end
    c:RemoveOverlayCard(tp, 1, 1, REASON_COST)
end

function c84130848.ignitionOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DIRECT_ATTACK)
    e1:SetReset(RESET_PHASE + PHASE_END)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CHANGE_DAMAGE)
    e2:SetCondition(c84130848.halfValCondition)
    e2:SetValue(c84130848.halfVal)
    e2:SetReset(RESET_PHASE + PHASE_END)
    c:RegisterEffect(e2)
end

function c84130848.halfValCondition(e, tp, eg, ep, ev, re, r, rp)
    Debug.Message(e)
    Debug.Message(tp)
    Debug.Message(eg)
    Debug.Message(ep)
    Debug.Message(ev)
    Debug.Message(re)
    Debug.Message(r)
    Debug.Message(rp)
    return ep == 1 - tp
end

function c84130848.halfVal(e, re, val, r, rp, rc)
    return val / 2
end

-- endregion
