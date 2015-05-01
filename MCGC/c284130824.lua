-- MC群的先驱 TF
-- e1, e2参考[11502550]元素英雄 天空新宇侠, [17412721]旧神 诺登
-- e4参考[58481572]假面英雄 暗爪

function c284130824.initial_effect(c)
    -- 苏生限制
    c:EnableReviveLimit()

    -- 融合素材
    aux.AddFusionProcFun2(c, c284130824.spsummonFilter, c284130824.spsummonFilter, true)

    -- 特招限制
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(c284130824.spsummonLimit)
    c:RegisterEffect(e1)

    -- 特招方法
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c284130824.spsummonCondition)
    e2:SetOperation(c284130824.spsummonOperation)
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
    e4:SetCategory(CATEGORY_SEARCH + CATEGORY_TOHAND)
    e4:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e4:SetProperty(EFFECT_FLAG_DELAY)
    e4:SetCode(EVENT_TO_HAND)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCondition(c284130824.overDrawCondition)
    e4:SetTarget(c284130824.overDrawTarget)
    e4:SetOperation(c284130824.overDrawOperation)
    c:RegisterEffect(e4)
end

function c284130824.spsummonLimit(e, se, sp, st)
    return not e:GetHandler():IsLocation(LOCATION_EXTRA)
end

function c284130824.spsummonFilter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end

function c284130824.spsummonCondition(e, c)
    if c == nil then
        return ture
    end
    local tp = c:GetControler()
    return Duel.GetLocationCount(tp, LOCATION_MZONE) > -2 and Duel.IsExistingMatchingCard(c284130824.spsummonFilter, tp, LOCATION_ONFIELD, 0, 2, nil)
end

function c284130824.spsummonOperation(e, tp, eg, ep, ev, re, r, rp, c)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g = Duel.SelectMatchingCard(tp, c284130824.spsummonFilter, tp, LOCATION_MZONE, 0, 2, 2, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_COST)
    Duel.ShuffleDeck(tp)
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
        Duel.SendtoHand(g, nil, REASON_EFFECT)
    end
end

function c284130824.overDrawCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetCurrentPhase() ~= PHASE_DRAW and eg:IsExists(c284130824.overDrawFilter, 1, nil, 1 - tp)
end

function c284130824.overDrawFilter(c, tp)
    return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end

function c284130824.overDrawTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return e:GetHandler():IsRelateToEffect(e) and e:GetHandler():IsFaceup() and Duel.IsExistingMatchingCard(Card.IsSetCard, tp, LOCATION_DECK, 0, 1, nil, 0x2222)
    end

    local g = Duel.SelectMatchingCard(tp, Card.IsSetCard, tp, LOCATION_DECK, 0, 1, 1, nil, 0x2222)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SEARCH + CATEGORY_TOHAND, g, 1, nil, 0)
end

function c284130824.overDrawOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    Duel.SendtoHand(g, nil, REASON_EFFECT)
end