--region *.lua
--Date
--此文件由[BabeLua]插件自动生成

-- MC群的大小姐 木头
function c284130848.initial_effect(c)
    -- 超量
    c:EnableReviveLimit()
    aux.AddXyzProcedure(c, aux.FilterBoolFunction(Card.IsSetCard, 0x2222), 6, 4, c284130848.ovfilter, aux.Stringid(284130848, 0))

    -- 超量成功触发

    -- 一回合一次

end

function c284130848.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130848.ovfilter(c)
    return c:IsCode(284130831)
end
--endregion
