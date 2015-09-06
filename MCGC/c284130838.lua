-- MC群服务器服主 纸睡

function c284130838.initial_effect(c)
    -- 同调召唤
    aux.AddSynchroProcedure(c, c284130838.filter, c284130838.filter, 1)
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
    -- 怎么样才能不触发送墓效果？这个效果的类型是不是应该是EFFECT_TYPE_QUICK_F或者是EFFECT_TYPE_CONTINUES
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCondition(c284130838.synchroSuccessTriggerCondition)
    e2:SetTarget(c284130838.synchroSuccessTriggerTarget)
    e2:SetOperation(c284130838.synchroSuccessTriggerOperation)
    c:RegisterEffect(e2)

    -- 一回合一次从手卡特招
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON + CATEGORY_DRAW)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_ONFIELD)
    e3:SetCountLimit(1)
    e3:SetCondition(c284130838.ignitionCondition)
    e3:SetOperation(c284130838.ignitionOperation)
    c:RegisterEffect(e3)

    -- 除外并卡组检索
    local e4 = Effect.CreateEffect(c)
    e4:SetCategory(CATEGORY_SEARCH)
    e4:SetType(EFFECT_TYPE_ACTIONS)
    e4:SetRange(LOCATION_ONFIELD + LOCATION_GRAVE)
    e4:SetCost(c284130838.actionCost)
    e4:SetOperation(c284130838.actionOperation)
    c:RegisterEffect(e4)

    -- 破坏支付特招

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
    local g = Duel.GetMatchingGroup(c284130838.filter, tp, LOCATION_EXTRA, 0, nil)
    if g:GetCount() > 0 then
        Duel.SetTargetPlayer(tp)
        Duel.SetTargetParam(g:GetCount() * 500)
        Duel.SetOperationInfo(0, CATEGORY_RECOVER, nil, nil, tp, g:GetCount() * 500)
        e:SetLabelObject(g)
    end
end

function c284130838.synchroSuccessTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local player, value = Duel.GetChainInfo(0, CHAININFO_TARGET_PLAYER, CHAININFO_TARGET_PARAM)
    local g = e:GetLabelObject()
    Duel.SendtoGrave(g, REASON_EFFECT)
    Duel.Recover(player, value, REASON_EFFECT)
end

function c284130838.ignitionCondition(e, tp, eg, ep, ev, re, r, rp)
    local phase = Duel.GetCurrentPhase()
    return Duel.GetTurnPlayer() == tp and(phase == PHASE_MAIN1 or phase == PHASE_MAIN2)
end

function c284130838.ignitionOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, c284130838.filter, tp, LOCATION_HAND, 0, 1, 1, nil)
    local pos = Duel.SelectPosition(tp, g:GetFirst(), POS_FACEUP)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), nil, nil)
    Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, nil, tp, 1)
    -- 这个效果能不能召唤自己？这个效果特招的怪物要选择表示形式吗？
    Duel.SpecialSummon(g, SUMMON_TYPE_SPECIAL, tp, tp, true, false, pos)
end

function c284130838.actionCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return 
    end
end

function c284130838.actionOperation(e, tp, eg, ep, ev, re, r, rp, chk)
end