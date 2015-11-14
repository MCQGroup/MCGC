-- region *.lua
-- 2015-11-02
-- 此文件由[BabeLua]插件自动生成

-- MC群服务器失踪者 TF
function c284130847.initial_effect(c)
    -- 融合
    c:EnableReviveLimit()
    aux.AddFusionProcFun2(c, c284130847.fusionFilter1, c284130847.fusionFilter2, false)

    -- 对象触发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_BECOME_TARGET)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1, EFFECT_COUNT_CODE_SINGLE)
    e1:SetCost(c284130847.targetCost)
    e1:SetOperation(c284130847.targetOperation)
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetCode(EVENT_BE_BATTLE_TARGET)
    c:RegisterEffect(e2)
end 

function c284130847.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130847.fusionFilter1(c)
    return c284130847.filter(c) and c:IsType(TYPE_MONSTER)
end

function c284130847.fusionFilter2(c)
    return c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_MONSTER)
end

function c284130847.targetCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    local c = e:GetHandler()
    Duel.Remove(c, POS_FACEUP, REASON_COST)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetRange(LOCATION_REMOVED)
    e1:SetLabel(0)
    e1:SetLabelObject(e)
    e1:SetCondition(c284130847.costCondtion)
    e1:SetOperation(c284130847.costOperation)
    c:RegisterEffect(e1)
end

function c284130847.costCondtion(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp and e:GetHandler():IsRelateToEffect(e:GetLabelObject())
end

function c284130847.costOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    if count < 1 then
        count = count + 1
    else
        Duel.SpecialSummon(e:Gethandler(), SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP_DEFENCE)
        e:Reset()
    end
end

function c284130847.targetFilter(c)
    return c284130847.filter(c) and c:IsType(TYPE_MONSTER) and c:GetLevel() <= 4
end

function c284130847.targetOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, c284130847.targetFilter, tp, LOCATION_HAND, 0, 1, 1, nil)
    local c = g:GetFirst()
    local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
    Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos)
end

-- endregion
