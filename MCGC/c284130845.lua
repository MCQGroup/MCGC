-- MC群的笨蛋 ⑨

function c284130845.initial_effect(c)
    -- 超量
    aux.AddXyzProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, 0x2222), 3, 2, c284130845.ovfilter, aux.Stringid(284130845, 0))
    c:EnableReviveLimit()

    -- 无效并获得效果
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCategory(CATEGORY_DISABLE)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetCost(c284130845.negateCost)
    e1:SetTarget(c284130845.negateTarget)
    e1:SetOperation(c284130845.negateOperation)
    c:RegisterEffect(e1)

    -- 转防御
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_NEGATE)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_BECOME_TARGET)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCountLimit(1, EFFECT_COUNT_CODE_SINGLE)
    e2:SetCondition(c284130845.defCondition)
    e2:SetOperation(c284130845.defOperation1)
    c:RegisterEffect(e2)

    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_NEGATE)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_BE_BATTLE_TARGET)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1, EFFECT_COUNT_CODE_SINGLE)
    e3:SetCondition(c284130845.defCondition)
    e3:SetOperation(c284130845.defOperation2)
    c:RegisterEffect(e3)
end

function c284130845.ovfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x2222) and c:GetLevel() == 3
end

function c284130845.negateCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():GetOverlayCount()
    end
    local g = e:GetHandler():GetOverlayGroup()
    local sg = g:Select(tp, 1, 1, nil)
    Duel.SendtoGrave(sg, REASON_COST)
end

function c284130845.negateFilter(c, e)
    return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
end

function c284130845.negateTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:IsCanBeEffectTarget(e)
    end
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c284130845.negateFilter, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, e:GetHandler(), e)
    end
    local g = Duel.SelectTarget(tp, c284130845.negateFilter, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, 1, e:GetHandler(), e)
    Duel.SetOperationInfo(0, CATEGORY_DISABLE, g, 1, nil, nil)
end

function c284130845.negateOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = Duel.GetFirstTarget()
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DISABLE)
    e1:SetReset(RESET_EVENT + 0x1fe0000)
    c:RegisterEffect(e1)
    local e2 = Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_DISABLE_EFFECT)
    e2:SetReset(RESET_EVENT + 0x1fe0000)
    c:RegisterEffect(e2)
    Duel.MajesticCopy(e:GetHandler(), c)
end

function c284130845.defCondition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler():IsAttackPos()
end

function c284130845.defOperation1(e, tp, eg, ep, ev, re, r, rp)
    -- 效果对象
    Duel.ChangePosition(e:GetHandler(), POS_FACEUP_DEFENCE)
    Duel.NegateActivation(ev)
end

function c284130845.defOperation2(e, tp, eg, ep, ev, re, r, rp)
    -- 攻击对象
    Duel.ChangePosition(e:GetHandler(), POS_FACEUP_DEFENCE)
    Duel.NegateAttack()
end