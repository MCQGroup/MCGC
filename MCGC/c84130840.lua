-- MC群服务器炮灰 DZ

function c84130840.initial_effect(c)
    -- 同调召唤
    c:EnableReviveLimit()
    aux.AddSynchroProcedure2(c, nil, aux.NonTuner(c84130840.filter))

    -- 同调召唤成功选发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c84130840.syncSummonSuccessCondition)
    e1:SetOperation(c84130840.syncSummonSuccessOperation)
    c:RegisterEffect(e1)

    -- 自身特招
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(84130840, 0))
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_IGNORE_IMMUNE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c84130840.spsummonCondition)
    e2:SetTarget(c84130840.spsummonTarget)
    e2:SetOperation(c84130840.spsummonOperation)
    c:RegisterEffect(e2)

    -- 墓地特招
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCost(c84130840.spsummon2Cost)
    e3:SetTarget(c84130840.spsummon2Target)
    e3:SetOperation(c84130840.spsummon2Operation)
    c:RegisterEffect(e3)

    -- 送墓必发
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e4:SetCode(EVENT_TO_GRAVE)
    e4:SetOperation(c84130840.toGraveOperation)
    c:RegisterEffect(e4)
end

function c84130840.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130840.syncSummonSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c84130840.syncSummonSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
    -- 参考[19808608]DD 巴风特
    levels = { }
    for i = 1, 12 do
        levels[i] = i
    end

    Duel.Hint(HINT_SELECTMSG, tp, 567)
    local lv = Duel.AnnounceNumber(tp, table.unpack(levels))
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CHANGE_LEVEL)
    e1:SetValue(lv)
    e1:SetReset(RESET_PHASE + PHASE_END + RESET_SELF_TURN)
    c:RegisterEffect(e1)
end

function c84130840.spsummonFilter(c)
    return c84130840.filter(c) and c:IsType(TYPE_MONSTER)
end

function c84130840.spsummonCondition(e, c, smat, mg)
    if c == nil then
        return true
    end
    local g = Duel.GetMatchingGroup(c84130840.spsummonFilter, tp, LOCATION_GRAVE, 0, nil)
    return g:CheckWithSumEqual(Card.GetLevel, 5, 1, g:GetCount())
end

function c84130840.spsummonTarget(e, tp, eg, ep, ev, re, r, rp, chk, c, smat, mg)
    local g = Duel.GetMatchingGroup(c84130840.spsummonFilter, tp, LOCATION_GRAVE, 0, nil)
    if g:CheckWithSumEqual(Card.GetLevel, 5, 1, g:GetCount()) then
        local sg = g:SelectWithSumEqual(tp, Card.GetLevel, 5, 1, g:GetCount())
        Duel.Remove(sg, POS_FACEUP, REASON_COST)
        return true
    else
        return false
    end
end

function c84130840.spsummonOperation(e, tp, eg, ep, ev, re, r, rp, c, smat, mg)
    local c = e:GetHandler()

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_DISABLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TURN_SET)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_PHASE + PHASE_END)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetReset(RESET_EVENT + RESET_LEAVE)
    e2:SetOperation(c84130840.destroyOperation)
    c:RegisterEffect(e2)
end

function c84130840.destroyOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Destroy(e:GetHandler(), REASON_EFFECT, LOCATION_REMOVED)
end

function c84130840.spsummon2Cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.CheckLPCost(tp, 1000)
    end
    Duel.PayLPCost(tp, 1000)
end

function c84130840.spsummon2Filter(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    return c84130840.filter(c) and c:IsCanBeSpecialSummoned(e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
end

function c84130840.spsummon2Target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(c84130840.spsummon2Filter, tp, LOCATION_GRAVE, 0, 1, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEDOWN_DEFENSE, tp)
    end
    local g = Duel.SelectMatchingCard(tp, c84130840.spsummon2Filter, tp, LOCATION_GRAVE, 0, 1, 1, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEDOWN_DEFENSE, tp)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), nil, nil)
end

function c84130840.spsummon2Operation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if Duel.SpecialSummon(g, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEDOWN_DEFENSE) then
        Duel.SendtoGrave(e:GetHandler(), REASON_EFFECT)
    end
end

function c84130840.toGraveOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Draw(tp, 1, REASON_EFFECT)
end
