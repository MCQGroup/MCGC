-- region *.lua
-- 2016-04-15
-- 此文件由[BabeLua]插件自动生成

-- MC群的军势
function c84130867.initial_effect(c)
    -- 攻击响应
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 无效破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_CHAINING)
    e2:SetOperation()
    c:RegisterEffect(e2)
end


-- endregion
