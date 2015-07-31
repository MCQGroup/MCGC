-- MC群的战士 节操

function c284130833.initial_effect(c)
    -- 一回合只使用一次
    -- 召唤触发抉择
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_TODECK)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetTarget(c284130833.target)
    e1:SetOperation(c284130833.operation)
    e1:SetCountLimit(1, 284130833)
    c:RegisterEffect(e1)
end

function c284130833.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
end

function c284130833.operation(e, tp, eg, ep, ev, re, r, rp)
end