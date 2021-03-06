-- region *.lua
-- 20151225
-- 此文件由[BabeLua]插件自动生成

-- MC群服务器商讨
function c84130852.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation(c84130852.operation)
    c:RegisterEffect(e1)
end

function c84130852.destroyFilter(c)
    return c:IsType(TYPE_SPELL + TYPE_TRAP) and c:IsDestructable()
end

function c84130852.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c84130852.destroyFilter, tp, LOCATION_SZONE, 0, e:GetHandler())
    local count = Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)

    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_CONTINUOUS)
    e1:SetLabel(count)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetOperation(c84130852.delayOperation)
    Duel.RegisterEffect(e1, tp)
end

function c84130852.delayOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    local g = Duel.SelectMatchingCard(tp, Card.IsType, tp, LOCATION_GRAVE, 0, count, count, nil, TYPE_SPELL + TYPE_TRAP)
    local c = g:GetFirst()
    while c do
        Duel.MoveToField(c, tp, tp, LOCATION_SZONE, POS_FACEDOWN, true)
        c = g:GetNext()
    end
    g:KeepAlive()

    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_CANNOT_ACTIVATE)
    e1:SetTargetRange(1, 1)
    e1:SetLabelObject(g)
    e1:SetValue( function(e, re, tp)
        return e:GetLabelObject():IsContains(re:GetHandler()) and not re:GetHandler():IsImmuneToEffect(e)
    end )
    e1:SetReset(RESET_PHASE + PHASE_END + RESET_OPPO_TURN)
    Duel.RegisterEffect(e1, tp)

    e:Reset()
end
-- endregion
