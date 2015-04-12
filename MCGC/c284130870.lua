-- 与镰刀尺的契约
function c284130870.initial_effect(c)
    aux.AddRitualProcGreater(c, aux.FilterBoolFunction(Card.IsCode, 284130820))

    -- 墓地除外触发特招和卡组检索和装备
    local e1 = Effect.CreateEffect(c)
    e1:SetRange(LOCATION_GRAVE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCost()
    e1:SetTarget()
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 手卡丢弃触发卡组检索
    local e2 = Effect.CreateEffect(c)
    e2:SetRange(LOCATION_HAND)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCost()
    e2:SetTarget()
    e2:SetOperation()
    c:RegisterEffect(e2)
end