-- MC群服务器OP 无情

function c84130839.initial_effect(c)
    -- 同调召唤
    c:EnableReviveLimit()
    aux.AddSynchroProcedure(c, c84130839.filter, aux.NonTuner(nil), 1)

    -- 同调召唤成功触发
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c84130839.syncSummonSuccessCondition)
    e1:SetOperation(c84130839.syncSummonSuccessOperation)
    c:RegisterEffect(e1)

    -- 战破触发
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_BATTLE_DESTROYING)
    -- 参考[72989439]混沌战士 -开辟的使者-
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetCondition(c84130839.battleDestroyCondition)
    e2:SetTarget(c84130839.battleDestroyTarget)
    e2:SetOperation(c84130839.battleDestroyOperation)
    c:RegisterEffect(e2)

    -- 结束阶段必定发动
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e3:SetCode(EVENT_PHASE + PHASE_END)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCountLimit(1)
    e3:SetCondition(c84130839.turnEndCondition)
    e3:SetOperation(c84130839.turnEndOperation)
    c:RegisterEffect(e3)

    -- 因效果破坏必定发动
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e4:SetCode(EVENT_TO_GRAVE)
    e4:SetCondition(c84130839.destroyCondition)
    e4:SetOperation(c84130839.destroyOperation)
    -- 参考[70054514]暗海救生圈
    c:RegisterEffect(e4)
end 

function c84130839.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130839.syncSummonSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c84130839.syncSummonSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
    -- 这个效果是对场地生效，还是对当前场上所有的怪物生效？
    -- 参考[86396750]精灵兽 火狮
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e1:SetTarget(c84130839.syncSS_Target)
    e1:SetTargetRange(LOCATION_MZONE, 0)
    e1:SetReset(RESET_SELF_TURN + RESET_PHASE + PHASE_END, 2)
    Duel.RegisterEffect(e1, tp)

    local e2 = e1:Clone()
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(300)
    Duel.RegisterEffect(e2, tp)
end

function c84130839.syncSS_Target(e, c)
    return c84130839.filter(c)
end

function c84130839.battleDestroyCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local bc = c:GetBattleTarget()

    return bc and bc:IsStatus(STATUS_BATTLE_DESTROYED)
end

function c84130839.battleDestroyTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsDestructable, tp, 0, LOCATION_ONFIELD, 1, nil)
    end
    local g = Duel.SelectMatchingCard(tp, Card.IsDestructable, tp, 0, LOCATION_ONFIELD, 1, 1, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, g, g:GetCount(), nil, nil)
end

function c84130839.battleDestroyOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
end

function c84130839.turnEndCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(Card.IsDestructable, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, nil)
end

function c84130839.turnEndOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, Card.IsDestructable, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, 1, nil)
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
    Duel.Draw(g:GetFirst():GetControler(), 1, REASON_EFFECT)
end

function c84130839.destroyCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return bit.band(r, REASON_DESTROY + REASON_EFFECT) == REASON_DESTROY + REASON_EFFECT and c:IsPreviousLocation(LOCATION_MZONE)
end

function c84130839.destroyOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup(Card.IsDestructable, tp, 0, LOCATION_ONFIELD, nil)
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
    Duel.Damage(tp, g:GetCount() * 300, REASON_EFFECT)
    Duel.Damage(1 - tp, g:GetCount() * 300, REASON_EFFECT)
end
