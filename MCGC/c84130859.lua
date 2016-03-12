-- region *.lua
-- Date 2016-03-09
-- 此文件由[BabeLua]插件自动生成

-- DZ的表情本体
function c84130859.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_SEARCH)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation(c84130859.operation)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCondition()
    c:RegisterEffect(e2)
end

function c84130859.DZFilter(c)
    return c:IsCode(84130813) or c:IsCode(84130840)
end

function c84130859.spsummonFilter(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    return c84130859.DZFilter(c) and c:IsCanBeSpecialSummoned(e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
end

function c84130859.operation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_MESSAGE, tp, HINTMSG_SPSUMMON)
    local g = Duel.SelectMatchingCard(tp, c84130859.spsummonFilter, tp, LOCATION_DECK, 0, 1, 1, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
    if g:GetCount() > 0 then
        local c = g:GetFirst()
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos)
    end
end
-- endregion
