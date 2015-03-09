-- 植吧MC群
function c284130814.initial_effect(c)
    -- 返回卡组
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_ACTIVATE + EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_CHAINING)
    -- 抽卡
    -- 防止破坏
    -- 维持代价
end