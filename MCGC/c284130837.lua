-- MC群的毛茸茸 二僵

function c284130837.initial_effect(c)
    -- 手卡墓地特招（一场决斗一次）
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e1:SetCountLimit(1, 84130837 + EFFECT_COUNT_CODE_DUEL)
    e1:SetCost(c284130837.spsummonCost)
    e1:SetOperation(c284130837.spsummonOperation)
    c:RegisterEffect(e1)

    -- 特招成功触发
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCategory(CATEGORY_TOHAND + CATEGORY_SEARCH)
    -- 这个效果到底取不取对象？
    e2:SetCondition(c284130837.spsummon_successCondition)
    e2:SetOperation(c284130837.spsummon_successOperation)
    c:RegisterEffect(e2)
end

function c284130837.spsummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0) > 0
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToDeckAsCost, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.SendtoDeck(g, tp, 0, REASON_COST)
end

function c284130837.spsummonOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
    Duel.SpecialSummon(e:GetHandler(), SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos)
end

function c284130837.spsummon_successFilter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER) and c:GetLevel() == 2
end

function c284130837.spsummon_successCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(c284130837.spsummon_successFilter, tp, LOCATION_DECK, 0, 1, nil)
end

function c284130837.spsummon_successOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, c284130837.spsummon_successFilter, tp, LOCATION_DECK, 0, 1, 1, nil)
    Duel.SendtoHand(g, tp, REASON_EFFECT)
end