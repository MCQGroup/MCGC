-- MC群的先驱 TF
function c284130824.initial_effect(c)
    -- 苏生限制
    c:EnableReviveLimit()

    -- 融合素材
    aux.AddFusionProcFunRep(c, c284130824.summonFilter, 2, true)

    -- 特招限制
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(c284130824.summonLimit)
    c:RegisterEffect(e1)

    -- 特招方法
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c284130824.summonCondition)
    e2:SetOperation(c284130824.summonOperation)
    c:RegisterEffect(e2)

    -- 特招触发（无法连锁）
    local e3 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TOHAND)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetTarget(c284130824.toHandTarget)
    e3:SetOperation(c284130824.toHandOperation)
    c:RegisterEffect(e3)

    -- 对方额外抽卡触发
    local e4 = Effect.CreateEffect(c)

    c:RegisterEffect(e4)
end

function c284130824.summonFilter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER) and c:IsFaceUp()
end

function c284130824.summonLimit(e, se, sp, st)
    return e:GetHandler():GetLocation() ~= LOCATION_EXTRA
end

function c284130824.summonCondition(e, c)
    if c == nil then
        return ture
    end
    local tp = c:GetController()
    return Duel.GetLocationCount(tp, LOCATION_MZONE) > -2 and Duel.IsExistingMatchingCard(c284130824.summonFilter, tp, LOCATION_MZONE, 0, 2, nil)
end

function c284130824.summonOperation(e, tp, eg, ep, ev, re, r, rp, c)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g = Duel.SelectMatchingCard(tp, c284130824.summonFilter, tp, LOCATION_MZONE, 0, 2, 2, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_COST)
end

function c284130824.toHandTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsSetCard, tp, LOCATION_GRAVE, 0, 1, nil, 0x2222)
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsSetCard, tp, LOCATION_GRAVE, 0, 1, 1, nil, 0x2222)
    Duel.SetOperationInfo(0, CATEGORY_TOHAND, g, 1, nil, 0)
end

function c284130824.toHandOperation(e, tp, eg, ep, ev, re, r, rp)
    local test, g = Duel.GetOperationInfo(0, CATEGORY_TOHAND)
    if test then
        Duel.SendtoHand(c, nil, REASON_EFFECT)
    end
end