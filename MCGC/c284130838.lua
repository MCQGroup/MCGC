-- MC群服务器服主 纸睡

function c284130838.initial_effect(c)
    -- 同调召唤
    aux.AddSynchroProcedure(c, c284130838.filter, aux.NonTuner(c284130838.filter), 1)
    c:EnableReviveLimit()

    -- 召唤限制
    local e1 = Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(c284130838.summonLimit)
    -- 参考流天类星龙、毒蛇神
    c:RegisterEffect(e1)

    -- 同调召唤成功触发
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_TODECK + CATEGORY_RECOVER)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCondition(c284130838.synchroSuccessTriggerCondition)
    e2:SetTarget(c284130838.synchroSuccessTriggerTarget)
    e2:SetOperation(c284130838.synchroSuccessTriggerOperation)
    c:RegisterEffect(e2)

    -- 一回合一次从手卡特招 或 除外并从卡组检索
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_MZONE + LOCATION_GRAVE)
    e3:SetCondition(c284130838.ignitionCondition)
    e3:SetCost(c284130838.ignitionCost)
    e3:SetOperation(c284130838.ignitionOperation)

    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_CONTINUOUS)
    e4:SetCode(EVENT_PHASE_START + PHASE_STANDBY)
    e4:SetCondition(c284130838.refreshCondition)
    e4:SetOperation(c284130838.refreshOperation)
    c:RegisterEffect(e4)

    e3:SetLabelObject(e4)
    c:RegisterEffect(e3)

    -- 破坏支付特招
    local e5 = Effect.CreateEffect(c)
    e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e5:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    -- 参考[23015896]炎王神兽 大鹏不死鸟
    e5:SetCode(EVENT_TO_GRAVE)
    e5:SetCondition(c284130838.destroyTriggerCondition)
    e5:SetCost(c284130838.destroyTriggerCost)
    e5:SetOperation(c284130838.destroyTriggerOperation)
    c:RegisterEffect(e5)
end

function c284130838.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130838.summonLimit(e, se, sp, st)
    -- 检查是不是同调召唤是这么写的么，检查是不是由自己的效果召唤是这么写的么
    -- 原来是不管有没有这个效果一律禁止，然后自己效果的特招时不检查第一个条件即可
    return bit.band(st, SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c284130838.synchroSuccessTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c284130838.synchroSuccessTriggerTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(aux.TRUE, tp, LOCATION_REMOVED, 0, 1, nil)
    end
    local g = Duel.GetMatchingGroup(aux.TRUE, tp, LOCATION_REMOVED, 0, nil)
    if g:GetCount() > 0 then
        Duel.SetTargetPlayer(tp)
        Duel.SetTargetParam(g:GetCount() * 500)
        Duel.SetOperationInfo(0, CATEGORY_RECOVER, g, g:GetCount(), tp, g:GetCount() * 500)
    end
end

function c284130838.synchroSuccessTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(aux.TRUE, tp, LOCATION_REMOVED, 0, nil)
    local player, value = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    if g:GetCount() > 0 then
        Duel.SendtoGrave(g, REASON_EFFECT + REASON_RETURN)
    end
    -- 参考[48976825]来自异次元的埋葬
    Duel.Recover(player, value, REASON_EFFECT)
end

function c284130838.spsummonFilter(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    return c284130838.filter(c) and c:IsCanBeSpecialSummoned(e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
end

function c284130838.searchFilter(c)
    return c284130838.filter(c) and c:IsAbleToHand()
end

function c284130838.ignitionCondition(e, tp, eg, ep, ev, re, r, rp)
    local isRightTurn = Duel.GetTurnPlayer() == tp
    local phase = Duel.GetCurrentPhase()
    local isRightPhase = phase == PHASE_MAIN1 or phase == PHASE_MAIN2
    local isAbleToSpSummon = e:GetLabelObject():GetLabel() == 0 and e:GetHandler():IsLocation(LOCATION_MZONE) and Duel.IsExistingMatchingCard(c284130838.spsummonFilter, tp, LOCATION_HAND, 0, 1, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
    local isAbleToSearch = Duel.IsExistingMatchingCard(c284130838.searchFilter, tp, LOCATION_DECK, 0, 1, nil)
    return isRightTurn and isRightPhase and(isAbleToSpSummon or isAbleToSpSummon)
end

function c284130838.ignitionCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    local isAbleToSpSummon = e:GetLabelObject():GetLabel() == 0 and e:GetHandler():IsLocation(LOCATION_MZONE) and Duel.IsExistingMatchingCard(c284130838.spsummonFilter, tp, LOCATION_HAND, 0, 1, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
    local isAbleToSearch = Duel.IsExistingMatchingCard(c284130838.searchFilter, tp, LOCATION_DECK, 0, 1, nil)
    local option = -1
    if isAbleToSpSummon and isAbleToSearch then
        option = Duel.SelectOption(tp, aux.Stringid(284130838, 0), aux.Stringid(284130838, 1))
    elseif isAbleToSpSummon then
        option = 0
    elseif isAbleToSearch then
        option = 1
    end
    if option == 1 then
        Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_COST)
    end
    e:SetLabel(option)
end

function c284130838.ignitionOperation(e, tp, eg, ep, ev, re, r, rp)
    local option = e:GetLabel()

    if option == 0 then
        local g = Duel.SelectMatchingCard(tp, c284130838.spsummonFilter, tp, LOCATION_HAND, 0, 1, 1, nil, e, SUMMON_TYPE_SPECIAL, tp, false, false, POS_FACEUP, tp)
        if g:GetCount() > 0 then
            local pos = Duel.SelectPosition(tp, g:GetFirst(), POS_FACEUP)
            -- 这个效果能不能召唤自己？这个效果特招的怪物要选择表示形式吗？
            -- 不能。要。
            if Duel.SpecialSummon(g, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos) > 0 then
                e:GetLabelObject():SetLabel(1)
            end
            Duel.BreakEffect()
            -- 要求错时点
            Duel.Draw(tp, 1, REASON_EFFECT)
        end
    elseif option == 1 then
        local g = Duel.SelectMatchingCard(tp, c284130838.searchFilter, tp, LOCATION_DECK, 0, 1, 1, nil)
        local c = g:GetFirst()
        if c and Duel.SendtoHand(c, tp, REASON_EFFECT) and c:IsLocation(LOCATION_HAND) then
            Duel.ConfirmCards(1 - tp, c)
            -- 这里要不要给对方展示这张卡？
            local e1 = Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_FIELD)
            e1:SetCode(EFFECT_CANNOT_ACTIVATE)
            e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
            e1:SetTargetRange(1, 0)
            e1:SetValue(c284130838.action_activateLimit)
            e1:SetLabel(c:GetCode())
            e1:SetReset(RESET_PHASE + PHASE_END)
            Duel.RegisterEffect(e1, tp)
        end
    end
end

function c284130838.refreshCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp
end

function c284130838.refreshOperation(e, tp, eg, ep, ev, re, r, rp)
    e:SetLabel(0)
end

function c284130838.action_activateLimit(e, re, rp)
    return re:GetHandler():IsCode(e:GetLabel()) and not re:GetHandler():IsImmuneToEffect(e)
end

function c284130838.destroyTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return bit.band(r, REASON_EFFECT + REASON_DESTROY) == REASON_EFFECT + REASON_DESTROY
end

function c284130838.destroyTriggerCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.CheckLPCost(tp, 1000)
    end
    Duel.PayLPCost(tp, 1000)
end

function c284130838.destroyTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local pos = Duel.SelectPosition(tp, e:GetHandler(), POS_FACEUP)
    Duel.SpecialSummon(e:GetHandler(), SUMMON_TYPE_SPECIAL, tp, tp, true, false, pos)
end