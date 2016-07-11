-- MC群的妹子 玲音

function c84130818.initial_effect(c)
    -- 二重召唤
    aux.EnableDualAttribute(c)

    -- 卡名
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_CHANGE_CODE)
    e1:SetCondition(aux.IsDualState)
    e1:SetValue(84130817)
    c:RegisterEffect(e1)
end