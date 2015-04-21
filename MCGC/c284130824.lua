-- MC群的先驱 TF
function c284130824.initial_effect(c)
    -- 苏生限制
    c:EnableReviveLimit()

    -- 特招方法
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)

    c:RegisterEffect(e1)

    -- 特招触发（无法连锁）

    -- 对方额外抽卡触发
end

function c284130824.summonFilter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER)
end