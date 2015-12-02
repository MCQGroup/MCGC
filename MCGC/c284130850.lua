--region *.lua
--2015-11-26
--此文件由[BabeLua]插件自动生成

-- MC群融合
function c284130850.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    c:RegisterEffect(e1)

    -- 墓地起动
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_GRAVE)
    c:RegisterEffect(e2)
end

--endregion
