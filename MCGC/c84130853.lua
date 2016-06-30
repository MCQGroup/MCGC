-- region *.lua
-- 2016-02-14
-- 此文件由[BabeLua]插件自动生成

-- MC群服务器回档
function c84130853.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation(c84130853.operation)
    c:RegisterEffect(e1)
end

function c84130853.destroyFilter(c)
    return c:IsFaceup() and c:IsDestructable()
end

function c84130853.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(c84130853.destroyFilter, tp, LOCATION_ONFIELD, 0, e:GetHandler())
    local count = Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)

    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_CONTINUOUS)
    e1:SetLabel(count)
    e1:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e1:SetOperation(c84130853.delayOperation)
    Duel.RegisterEffect(e1, tp)
end

function c84130853.delayFilter(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    return c:IsType(TYPE_SPELL + TYPE_TRAP) or(c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player))
end

function c84130853.delayOperation(e, tp, eg, ep, ev, re, r, rp)
    local count = e:GetLabel()
    local g = Duel.SelectMatchingCard(tp, c84130853.delayFilter, tp, LOCATION_DECK, 0, 0, count, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEDOWN_DEFENSE, tp)

    local isSpecialSummoned = false
    local c = g:GetFirst()
    while c do
        if c:IsType(TYPE_SPELL + TYPE_TRAP) then
            Duel.MoveToField(c, tp, tp, LOCATION_SZONE, POS_FACEDOWN, true)

            c:RegisterFlagEffect(84130853, RESET_EVENT + RESET_TOGRAVE + RESET_REMOVE + RESET_TEMP_REMOVE + RESET_TOHAND + RESET_TODECK + RESET_LEAVE, nil, 1)
        elseif c:IsType(TYPE_MONSTER) then
            if Duel.SpecialSummonStep(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEDOWN_DEFENSE) then
                isSpecialSummoned = true

                local e1 = Effect.CreateEffect(e:GetHandler())
                e1:SetType(EFFECT_TYPE_SINGLE)
                e1:SetCode(EFFECT_SET_ATTACK)
                e1:SetValue(0)
                e1:SetReset(RESET_EVENT + RESET_TURN_SET + RESET_TOGRAVE + RESET_REMOVE + RESET_TEMP_REMOVE + RESET_TOHAND + RESET_TODECK + RESET_LEAVE)
                c:RegisterEffect(e1)

                local e2 = e1:Clone()
                e2:SetCode(EFFECT_SET_DEFENSE)
                c:RegisterEffect(e2)
            end
        end
        c = g:GetNext()
    end
    if isSpecialSummoned then
        Duel.SpecialSummonComplete()
    end

    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_ACTIVATE_COST)
    e1:SetTargetRange(1, 1)
    e1:SetTarget( function(e, te, tp)
        return te:GetHandler():GetFlagEffect(84130853) > 0 and not te:GetHandler():IsImmuneToEffect(e)
    end )
    e1:SetCost( function(e, te_or_c, tp)
        return Duel.CheckLPCost(tp, 1000)
    end )
    e1:SetOperation( function(e, tp, eg, ep, ev, re, r, rp)
        Duel.PayLPCost(tp, 1000)
    end )
    Duel.RegisterEffect(e1, tp)

    e:Reset()
end

-- endregion
