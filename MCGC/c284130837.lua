-- MC群的毛茸茸 二僵

function c284130837.initial_effect(c)
    -- 手卡墓地特招（一场决斗一次）
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e1:SetCountLimit(1, 284130837)
    e1:SetCost()
    e1:SetOperation()
    c:RegisterEffect(e1)
    -- 特招成功触发
end