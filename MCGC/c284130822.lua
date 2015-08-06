-- MC群的摆渡者 玲音

function c284130822.initial_effect(c)
    -- 不能特招
    local e1 = Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(aux.FALSE)
    c:RegisterEffect(e1)

    -- 弹回手卡
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetOperation(c284130822.backHandOperation1)
    c:RegisterEffect(e2)

    local e3 = e2:Clone()
    e3:SetCode(EVENT_FLIP)
    c:RegisterEffect(e3)

    -- 无解放召唤
    local e4 = Effect.CreateEffect(c)
    e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_SUMMON_PROC)
    e4:SetCondition(c284130822.noTributeCondition)
    e4:SetOperation(c284130822.noTributeOperation)
    c:RegisterEffect(e4)

    local e5 = e4:Clone()
    e5:SetCode(EFFECT_SET_PROC)
    c:RegisterEffect(e5)

    -- 三怪兽解放召唤
    local e6 = Effect.CreateEffect(c)
    e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e6:SetType(EFFECT_TYPE_SINGLE)
    e6:SetCode(EFFECT_SUMMON_PROC)
    e6:SetCondition(c284130822.threeTributeCondition)
    e6:SetOperation(c284130822.threeTributeOperation)
    e6:SetValue(SUMMON_TYPE_ADVANCE + 1)
    c:RegisterEffect(e6)

    local e7 = Effect.CreateEffect(c)
    e7:SetCategory(CATEGORY_DESTROY)
    e7:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e7:SetCode(EVENT_SUMMON_SUCCESS)
    e7:SetCondition(c284130822.desdroyCondition)
    e7:SetTarget(c284130822.desdroyTarget)
    e7:SetOperation(c284130822.desdroyOperation)
    c:RegisterEffect(e7)
end

function c284130822.backHandOperation1(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e1:SetCategory(CATEGORY_TOHAND)
    e1:SetCode(EVENT_PHASE + PHASE_END)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetReset(RESET_EVENT + 0x1ee0000 + RESET_PHASE + PHASE_END)
    e1:SetCondition(c284130822.backHandCondition)
    e1:SetTarget(c284130822.backHandTarget)
    e1:SetOperation(c284130822.backHandOperation2)
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    c:RegisterEffect(e2)
end

function c284130822.backHandCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if c:IsHasEffect(EFFECT_SPIRIT_DONOT_RETURN) then
        return false
    end
    if e:IsHasType(EFFECT_TYPE_TRIGGER_F) then
        return not c:IsHasEffect(EFFECT_SPIRIT_MAYNOT_RETURN)
    else
        return c:IsHasEffect(EFFECT_SPIRIT_MAYNOT_RETURN)
    end
end

function c284130822.backHandTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return true
    end
    Duel.SetTargetCard(e:GetHandler())
    Duel.SetOperationInfo(0, CATEGORY_TOHAND, e:GetHandler(), 1, 0, 0)
end

function c284130822.backHandOperation2(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    if c:IsRelateToEffect(e) and c:IsFaceup() then
        Duel.SendtoHand(c, nil, REASON_EFFECT)
    end
end

function c284130822.noTributeCondition(e, c, minc)
    if c == nil then
        return true
    end
    return minc == 0 and c:GetLevel() > 4 and Duel.GetLocationCount(c:GetControler(), LOCATION_MZONE) > 0
end

function c284130822.noTributeOperation(e, tp, eg, ep, ev, re, r, rp, c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetReset(RESET_EVENT + 0xff0000)
    e1:SetCode(EFFECT_SET_BASE_ATTACK)
    e1:SetValue(1900)
    c:RegisterEffect(e1)
end

function c284130822.threeTributeCondition(e, c, minc)
    if c == nil then
        return true
    end
    return Duel.GetTributeCount(c) >= 3
end

function c284130822.threeTributeOperation(e, tp, eg, ep, ev, re, r, rp, c)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_RELEASE)
    local g = Duel.SelectTribute(tp, c, 3, 3)
    c:SetMaterial(g)
    Duel.Release(g, REASON_SUMMON + REASON_MATERIAL)
end

function c284130822.desdroyCondition(e, tp, eg, ep, ev, re, r, rp)
    return e:GetHandler():GetSummonType() == SUMMON_TYPE_ADVANCE + 1
end

function c284130822.desdroyTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return true
    end
    local sg = Duel.GetMatchingGroup(Card.IsDestructable, tp, 0, LOCATION_ONFIELD, nil)
    Duel.SetTargetCard(sg)
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, sg, sg:GetCount(), 0, 0)
end

function c284130822.desdroyOperation(e, tp, eg, ep, ev, re, r, rp)
    local sg = Duel.GetMatchingGroup(Card.IsDestructable, tp, 0, LOCATION_ONFIELD, nil)
    Duel.Destroy(sg, REASON_EFFECT)
end