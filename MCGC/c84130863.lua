-- region *.lua
-- Date 2016-03-29
-- 此文件由[BabeLua]插件自动生成

function c84130863.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCondition(c84130863.condition)
    e1:SetTarget(c84130863.target)
    e1:SetOperation(c84130863.operation)
    c:RegisterEffect(e1)
end

function c84130863.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130863.spFilter(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    return c:IsCanBeSpecialSummoned(e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
end

function c84130863.xyzLimit(e, c)
    if not c then
        return false
    end
    return true
end

function c84130863.otherFilter(oc, c)
    return(oc:GetLevel() == c:GetLevel() or oc:GetAttack() == c:GetAttack()) and not oc:IsCode(c:GetCode())
end

function c84130863.condition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetLocationCount(tp, LOCATION_MZONE, tp, LOCATION_REASON_TOFIELD) > 0
end

function c84130863.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard( function(c)
            return c84130863.filter(c) and c:IsCanBeEffectTarget(e) and c84130863.spFilter(c, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
        end , tp, LOCATION_GRAVE, 0, 1, nil)
    end
    Duel.Hint(HINT_MESSAGE, tp, HINTMSG_SPSUMMON)
    local g = Duel.SelectMatchingCard(tp, function(c)
        return c84130863.filter(c) and c:IsCanBeEffectTarget(e) and c84130863.spFilter(c, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
    end , tp, LOCATION_GRAVE, 0, 1, 1, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, 1, nil, nil);
end

function c84130863.operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS);
    local c = g:GetFirst()
    local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
    if Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos) then
        local e1 = Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
        e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
        e1:SetValue(c84130863.xyzLimit)
        e1:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TOGRAVE + RESET_TOHAND + RESET_REMOVE + RESET_TODECK)
        c:RegisterEffect(e1)
    end
    if Duel.IsExistingMatchingCard( function(oc)
            return c84130863.spFilter(oc, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp) and c84130863.otherFilter(oc, c)
        end , tp, LOCATION_HAND + LOCATION_DECK, 0, 1, nil) and Duel.GetLocationCount(tp, LOCATION_MZONE, tp, LOCATION_REASON_TOFIELD) > 0 then
        Duel.Hint(HINT_MESSAGE, tp, HINTMSG_SPSUMMON)
        local other_g = Duel.SelectMatchingCard(tp, function(oc)
            return c84130863.spFilter(oc, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp) and c84130863.otherFilter(oc, c)
        end , tp, LOCATION_HAND + LOCATION_DECK, 0, 0, 1, nil)
        local c2 = other_g:GetFirst()
        local pos2 = Duel.SelectPosition(tp, c2, POS_FACEUP)
        if Duel.SpecialSummon(c2, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos2) then
            local e2 = Effect.CreateEffect(e:GetHandler())
            e2:SetType(EFFECT_TYPE_SINGLE)
            e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
            e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
            e2:SetValue(c84130863.xyzLimit)
            e2:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TOGRAVE + RESET_TOHAND + RESET_REMOVE + RESET_TODECK)
            c2:RegisterEffect(e2)
        end
    end
end

-- endregion
