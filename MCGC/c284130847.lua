-- region *.lua
-- 2015-11-02
-- 此文件由[BabeLua]插件自动生成

-- MC群服务器失踪者 TF
function c284130847.initial_effect(c)
    -- 融合
    c:EnableReviveLimit()
    aux.AddFusionProcFun2(c, c284130847.fusionFilter1, c284130847.fusionFilter2, false)

    -- 对象触发

end 

function c284130847.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130847.fusionFilter1(c)
    return c284130847.filter(c) and c:IsType(TYPE_MONSTER)
end

function c284130847.fusionFilter2(c)
    return c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_MONSTER)
end

-- endregion
