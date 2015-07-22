-- MC群的幻影 节操

function c284130832.initial_effect(c)
    -- 当作魔法陷阱
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_MONSTER_SSET)
    e1:SetValue(TYPE_SPELL)
    c:RegisterEffect(e1)

    -- 破坏触发特招
    -- 反转触发
end