-- MC群的先驱 TF
-- e1, e2参考[11502550]元素英雄 天空新宇侠
-- e4参考[58481572]假面英雄 暗爪

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

function c284130824.summonFilter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER) and c:IsFaceup()
end

function c284130824.summonLimit(e, se, sp, st)
    Debug.Message("####调试信息####")
    Debug.Message("summonLimit")
    Debug.Message(e:GetHandler():IsLocation(LOCATION_EXTRA))
    Debug.Message("################")
    -- return not e:GetHandler():IsLocation(LOCATION_EXTRA)
    -- 限制“从额外卡组以外的地方”召唤
    return false
end

function c284130824.summonCondition(e, c)
    if c == nil then
        return ture
    end
    local tp = c:GetControler()
    Debug.Message("####调试信息####")
    Debug.Message("GetLocationCount")
    Debug.Message(Duel.GetLocationCount(tp, LOCATION_MZONE))
    Debug.Message("IsExistingMatchingCard")
    Debug.Message(Duel.IsExistingMatchingCard(c284130824.summonFilter, tp, LOCATION_ONFIELD, 0, 2, nil))
    Debug.Message("################")
    --[[ return Duel.GetLocationCount(tp, LOCATION_MZONE) > -2
    -- 我能说这个场地剩余空格大于一个负数是什么意思我没看懂吗

    and Duel.IsExistingMatchingCard(c284130824.summonFilter, tp, LOCATION_ONFIELD, 0, 2, nil)]]
    return true
end

function c284130824.summonOperation(e, tp, eg, ep, ev, re, r, rp, c)
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_TODECK)
    local g = Duel.SelectMatchingCard(tp, c284130824.summonFilter, tp, LOCATION_MZONE, 0, 2, 2, nil)
    Duel.SendtoDeck(g, nil, 2, REASON_COST)
    Duel.SpecialSummon(e:GetHandler(), SUMMON_TYPE_SPECIAL, tp, tp, true, true, POS_FACEUP_ATTACK)
end

function c284130824.toHandTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsSetCard, tp, LOCATION_GRAVE, 0, 1, nil, 0x2222)
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsSetCard, tp, LOCATION_GRAVE, 0, 1, 1, nil, 0x2222)
    -- 因为该效果要求不能被连锁，所以取对象不入连锁

    Duel.SetOperationInfo(0, CATEGORY_TOHAND, g, 1, nil, 0)
end

function c284130824.toHandOperation(e, tp, eg, ep, ev, re, r, rp)
    local test, g = Duel.GetOperationInfo(0, CATEGORY_TOHAND)
    -- 因为不入连锁所以使用GetOperationInfo而非GetChainInfo

    if test then
        Duel.SendtoHand(g, nil, REASON_EFFECT)
    end
end

function c284130824.overDrawCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetCurrentPhase() ~= PHASE_DRAW
    -- 要求当前不是抽卡阶段

    and eg:IsExists(c284130824.overDrawFilter, 1, nil, 1 - tp)
    -- 用下一个函数检查卡片
end

function c284130824.overDrawFilter(c, tp)
    return c:IsControler(tp)
    -- 该条件意义不明

    and c:IsPreviousLocation(LOCATION_DECK)
    -- 从卡组抽出来的
end

function c284130824.overDrawTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return e:GetHandler():IsRelateToEffect(e)
        -- 这个条件没看懂

        and e:GetHandler():IsFaceup()
        -- 要求本卡正面表示

        and Duel.IsExistingMatchingCard(Card.IsSetCard, tp, LOCATION_DECK, 0, 1, nil, 0x2222)
        -- 检查卡组中是否有【MC群】
    end
    local g = Duel.SelectTarget(tp, Card.IsSetCard, tp, LOCATION_DECK, 0, 1, 1, nil, 0x2222)
    -- 这里用SelectTarget直接入连锁

    Duel.SetOperationInfo(0, CATEGORY_SEARCH + CATEGORY_TOHAND, g, 1, nil, 0)
end

function c284130824.overDrawOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    Duel.SendtoHand(g, nil, REASON_EFFECT)
end