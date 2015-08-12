-- MC群的挂比 要触

function c284130835.initial_effect(c)
    -- 不能特殊召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    -- 蜘蛛
    -- 攻击力上升场上的卡的数量
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetValue(c284130835.updateAtk)
    c:RegisterEffect(e2)

    -- 破坏送墓触发
    local e3 = Effect.CreateEffect(c)
    c:RegisterEffect(e3)
end

function c284130835.updateAtk(e, c)
    return Duel.GetFieldGroupCount(PLAYER_ALL, LOCATION_ONFIELD, LOCATION_ONFIELD)
end