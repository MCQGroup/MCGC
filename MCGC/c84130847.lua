-- region *.lua
-- 2015-11-02
-- 此文件由[BabeLua]插件自动生成

-- MC群服务器失踪者 TF
function c84130847.initial_effect(c)
    -- 融合
    c:EnableReviveLimit()
    aux.AddFusionProcFun2(c, c84130847.fusionFilter1, c84130847.fusionFilter2, false)

    -- 对象触发
    local e1 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(84130847, 0))
    e1:SetType(EFFECT_TYPE_QUICK_O)
    e1:SetCode(EVENT_BECOME_TARGET)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1, EFFECT_COUNT_CODE_SINGLE)
    e1:SetCondition(c84130847.targetCondition)
    e1:SetCost(c84130847.targetCost)
    e1:SetOperation(c84130847.targetOperation)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(84130847, 1))
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_BE_BATTLE_TARGET)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1, EFFECT_COUNT_CODE_SINGLE)
    e2:SetCondition(c84130847.targetCondition)
    e2:SetCost(c84130847.targetCost)
    e2:SetOperation(c84130847.targetOperation)
    c:RegisterEffect(e2)
end 

function c84130847.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130847.fusionFilter1(c)
    return c84130847.filter(c) and c:IsType(TYPE_MONSTER)
end

function c84130847.fusionFilter2(c)
    return c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_MONSTER)
end

function c84130847.targetCondition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler():IsFaceup() and Duel.IsExistingMatchingCard(c84130847.targetFilter, tp, LOCATION_HAND, 0, 1, nil) and (eg and eg:IsContains(e:GetHandler()))
end

function c84130847.targetCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():IsAbleToRemoveAsCost()
    end
    local c = e:GetHandler()
    Duel.Remove(c, POS_FACEUP, REASON_COST + REASON_TEMPORARY)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetRange(LOCATION_REMOVED)
    e1:SetLabel(0)
    e1:SetCountLimit(1)
    e1:SetCondition(c84130847.costCondition)
    e1:SetOperation(c84130847.costOperation)
    c:RegisterEffect(e1)
end

function c84130847.costCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c84130847.costOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    if count < 1 then
        e:SetLabel(count + 1)
    else
        Duel.SpecialSummon(e:GetHandler(), SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP_DEFENSE)
        e:Reset()
    end
end

function c84130847.targetFilter(c)
    return c84130847.filter(c) and c:IsType(TYPE_MONSTER) and c:GetLevel() <= 4
end

function c84130847.targetOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
    local g = Duel.SelectMatchingCard(tp, c84130847.targetFilter, tp, LOCATION_HAND, 0, 1, 1, nil)
    local c = g:GetFirst()
    local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
    Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos)
end

-- endregion
