-- MC群服务器服主 纸睡

function c284130838.initial_effect(c)
    -- 同调召唤
    aux.AddSynchroProcedure(c, c284130838.filter, c284130838.filter, 1)

    -- 苏生限制、召唤限制
    c:EnableReviveLimit()
    local e1 = Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetCondition()
    -- 这里是用condition还是target来着
    c:RegisterEffect(e1)

    -- 同调召唤成功触发
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetCondition(c284130838.synchroSuccessTriggerCondition)
    e2:SetTarget(c284130838.synchroSuccessTriggerTarget)
    e2:SetOperation(c284130838.synchroSuccessTriggerOperation)
    c:RegisterEffect(e2)

    -- 一回合一次从手卡特招
    local e3 = Effect.CreateEffect(c)
    c:RegisterEffect(e3)

    -- 除外并卡组检索

    -- 破坏支付特招

end

function c284130838.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130838.summonLimit(e, tp, eg, ep, ev, re, r, rp)
    -- 检查是不是同调召唤是这么写的么，检查是不是由自己的效果召唤是这么写的么
    return bit.band(ev, SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO or e:GetHandler():IsHasEffect(re)
end

function c284130838.synchroSuccessTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c284130838.synchroSuccessTriggerTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    local g = Duel.GetMatchingGroup(c284130838.filter, tp, LOCATION_EXTRA, 0, nil)
    if g:GetCount() > 0 then
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