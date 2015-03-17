-- MC群的软妹 玲音

function c284130816.initial_effect(c)
    -- 灵摆召唤
    aux.AddPendulumProcedure(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)
    -- 特招限制
end

function c284130816.filter(c)
    return c:IsSetCard(0x2222)
end