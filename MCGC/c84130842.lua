-- MC群的团员 TF

function c84130842.initial_effect(c)
    -- 融合召唤
    c:EnableReviveLimit()
    aux.AddFusionProcFun2(c, c84130842.fusionFilter1, c84130842.fusionFilter2, false)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetRange(LOCATION_EXTRA)
    e1:SetValue(c84130842.summonLimit)
    c:RegisterEffect(e1)

    -- 不被效果破坏
    -- 参考[94977269]神影依·米德拉什
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    e2:SetRange(LOCATION_MZONE)
    e2:SetValue(c84130842.indestructableValue)
    c:RegisterEffect(e2)

    -- 攻击上升
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_BATTLE_START)
    e3:SetCondition(c84130842.atkUpCondition)
    e3:SetOperation(c84130842.atkUpOperation)
    c:RegisterEffect(e3)

    -- 防御穿透
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_PIERCE)
    c:RegisterEffect(e4)
end

function c84130842.fusionFilter1(c)
    return c:IsSetCard(0x2222)
end

function c84130842.fusionFilter2(c)
    return c:IsAttribute(ATTRIBUTE_FIRE)
end

function c84130842.summonLimit(e, se, sp, st)
    return bit.band(st, SUMMON_TYPE_FUSION) == SUMMON_TYPE_FUSION
end

function c84130842.indestructableValue(e, re, tp)
    return tp ~= e:GetHandlerPlayer()
end

function c84130842.atkUpCondition(e, tp, eg, ep, ev, re, r, rp)
    local btc = e:GetHandler():GetBattleTarget()
    return btc and btc:GetPreviousLocation() == LOCATION_EXTRA
end

function c84130842.atkUpOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(500)
    e1:SetReset(RESET_PHASE + PHASE_BATTLE)
    c:RegisterEffect(e1)
end