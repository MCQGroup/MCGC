--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

-- MC群的大小姐 木头
function c284130848.initial_effect(c)
    -- 超量
    c:EnableReviveLimit()
    aux.AddXyzProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, 0x2222), 6, 4, c284130848.ovfilter, aux.Stringid(284130848, 0))

    -- 超量成功触发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition()
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 一回合一次
    local e2 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCondition()
    e1:SetCost()
    e1:SetOperation()
    c:RegisterEffect(e2)

end

function c284130848.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130848.ovfilter(c)
    return c:IsCode(284130831)
end
--endregion
