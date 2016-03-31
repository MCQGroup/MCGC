-- region *.lua
-- Date 2016-03-29
-- 此文件由[BabeLua]插件自动生成

function c84130863.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE);
    e1:SetCode(EVENT_FREE_CHAIN);
    e1:SetTarget()
    e1:SetOperation()
    c:RegisterEffect(e1)
end

function c84130863.spFilter(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    return c:IsSetCard(0x2222) and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
end

function c84130863.target(e, tp, eg, ep, ev, re, r, rp)
    if chk == 0 then
        return Duel.IsExistingMatchingCard( function(c)
            return c84130863.spFilter(c, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
        end , tp, LOCATION_GRAVE, 0, 1, nil)
    end
end

-- endregion
