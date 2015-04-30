-- MC群的现充 手滑
function c284130825.initial_effect(c)
    -- 灵摆
    aux.AddPendulumProcedure(c)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 限制特招
    local e2 = Effect.CreateEffect(c)
    e2:SetRange(LOCATION_PZONE)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c284130825.specialSummonLimit)
    c:RegisterEffect(e2)

    -- 回复

    -- 特招规则

    -- 特招触发

end

function c284130825.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130825.specialSummonLimit(e, c)
    return not c284130825.filter(c)
end