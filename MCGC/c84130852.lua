-- region *.lua
-- 20151225
-- 此文件由[BabeLua]插件自动生成

-- MC群服务器商讨
function c84130852.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetOperation()
    c:RegisterEffect(e1)
end

function c84130852.destroyFilter(c)
    return c:IsType(TYPE_SPELL + TYPE_TRAP) and c:IsDestructable()
end

function c84130852.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c84130852.destroyFilter, tp, LOCATION_SZONE, 0, e:GetHandler())
    local count = g:GetCount()
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)

    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_CONTINUOUS)
    e1:SetLabel(count)
    e1:SetCondition(EVENT_PHASE + PHASE_STANDBY)
    e1:SetCondition(c84130852.delayCondition)
    e1:SetOperation(c84130852.delayOperation)
    c:RegisterEffect(e1)
end

function c84130852.delayCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c84130852.delayOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    local g = Duel.SelectMatchingCard(tp, Card.IsType, tp, LOCATION_GRAVE, 0, count, count, nil, TYPE_SPELL + TYPE_TRAP)
    g:ForEach( function(c)
        Duel.MoveToField(c, tp, tp, LOCATION_SZONE, POS_FACEDOWN, true)
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_ACTIVATE)
        e1:SetReset(RESET_PHASE + PHASE_END + RESET_OPPO_TURN)
        c:RegisterEffect(e1)
    end )
end
-- endregion
