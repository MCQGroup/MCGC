--region *.lua
--Date 2016-03-20
--此文件由[BabeLua]插件自动生成

-- MC群暴动
function c84130862.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 墓地除外
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition()
    e2:SetCost()
    e2:SetTarget()
    e2:SetOperation()
    c:RegisterEffect(e2)
end

--endregion
