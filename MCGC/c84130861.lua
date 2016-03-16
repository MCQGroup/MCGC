--region *.lua
--Date 2016-03-14
--此文件由[BabeLua]插件自动生成

-- 熊孩子的狂欢节！
function c84130861.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_DESTROYED)
    e1:SetCost()
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetCountLimit(1)
    e2:SetCondition()
    e2:SetTarget()
    e2:SetOperation()
    c:RegisterEffect(e2)
end

--endregion
