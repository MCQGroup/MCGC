-- region *.lua
-- 2016-04-15
-- 此文件由[BabeLua]插件自动生成

-- MC群的团结
function c84130866.initial_effect(c)
    -- 效果发动无效化
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_NEGATE)
    e1:SetDescription(aux.Stringid(84130866, 0))
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_CHAINING)
    e1:SetCondition(c84130866.negateCondition)
    e1:SetOperation(c84130866.negateOperation)
    c:RegisterEffect(e1)

    -- 本回合效果防御
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(84130866, 1))
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetCondition(c84130866.defendCondition)
    e2:SetOperation(c84130866.defendOperation)
    c:RegisterEffect(e2)

    -- 雷击
    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(84130866, 2))
    e3:SetType(EFFECT_TYPE_ACTIVATE)
    e3:SetCode(EVENT_FREE_CHAIN)
    e3:SetCondition(c84130866.thunderCondtiion)
    e3:SetOperation(c84130866.thunderOperation)
    c:RegisterEffect(e3)
end

function c84130866.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130866.commonCondition(e, tp)
    return Duel.GetMatchingGroupCount(c84130866.filter, tp, LOCATION_ONFIELD, 0, nil) >= 3
end

function c84130866.negateCondition(e, tp, eg, ep, ev, re, r, rp)
    return c84130866.commonCondition(e, tp) and re:GetHandlerPlayer() == 1 - tp and Duel.IsChainNegatable(ev)
end

function c84130866.negateOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.NegateActivation(ev)
end

function c84130866.defendCondition(e, tp, eg, ep, ev, re, r, rp)
    return c84130866.commonCondition(e, tp)
end

function c84130866.defendOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup( function(c)
        return c84130866.filter(c) and c:IsType(TYPE_MONSTER)
    end , tp, LOCATION_MZONE, 0, nil)
    if g and g:GetCount() > 0 then
        local c = g:GetFirst()
        while c do
            local e1 = Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
            e1:SetReset(RESET_PHASE + PHASE_END)
            e1:SetValue(1)
            c:RegisterEffect(e1)

            local e2 = e1:Clone()
            e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
            e2:SetValue(aux.tgval)
            c:RegisterEffect(e2)

            c = g:GetNext()
        end
    end
end

function c84130866.thunderCondtiion(e, tp, eg, ep, ev, re, r, rp)
    return c84130866.commonCondition(e, tp)
end

function c84130866.thunderOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.PayLPCost(tp, Duel.GetLP(tp) / 2)
    local g = Duel.GetMatchingGroup( function(c)
        return c:IsImmuneToEffect(e) and c:IsDestructable()
    end , tp, 0, LOCATION_MZONE, nil)
    if g then
        Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
    end
end
-- endregion
