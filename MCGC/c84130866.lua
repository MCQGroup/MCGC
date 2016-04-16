-- region *.lua
-- 2016-04-15
-- 此文件由[BabeLua]插件自动生成

-- MC群的团结
function c84130866.initial_effect(c)
    -- 效果发动无效化
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_NEGATE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_CHAINING)
    e1:SetCondition()
    e1:SetOperation()
    c:RegisterEffect(e1)

    -- 本回合效果防御
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(84130866, 0))
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetCondition()
    e2:SetOperation()
    c:RegisterEffect(e2)

    -- 雷击
    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(84130866, 1))
    e3:SetType(EFFECT_TYPE_ACTIVATE)
    e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetCondition()
    e3:SetCost()
    e3:SetOperation()
    c:RegisterEffect(e3)
end


-- endregion
