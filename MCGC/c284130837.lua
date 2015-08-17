-- MC群的毛茸茸 二僵

function c284130837.initial_effect(c)
    -- 手卡墓地特招（一场决斗一次）
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e1:SetCountLimit(1, 84130837 + EFFECT_COUNT_CODE_DUEL)
    e1:SetCost(c284130837.spsummonCost)
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 特招成功触发
end

function c284130837.spsummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0) > 0
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToDeckAsCost, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.SendtoDeck(g, tp, 0, REASON_COST)
end