-- MC群的妹子 玲音

function c284130818.initial_effect(c)
    aux.EnableDualAttribute(c)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EFFECT_CHANGE_CODE)
    e1:SetCondition(aux.IsDualState)
    e1:SetValue(284130817)
    c:RegisterEffect(e1)
end