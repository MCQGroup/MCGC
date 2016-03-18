-- region *.lua
-- Date 2016-03-14
-- 此文件由[BabeLua]插件自动生成

-- 熊孩子的狂欢节！
function c84130861.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 破坏触发
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_DESTROYED)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCondition(c84130861.triggerCondition)
    e2:SetOperation(c84130861.triggerOperation)
    c:RegisterEffect(e2)

    -- 破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_DESTROY)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCountLimit(1)
    e2:SetCondition(c84130861.qijiCondition)
    e2:SetTarget(c84130861.qijiTarget)
    e2:SetOperation(c84130861.qijiOperation)
    c:RegisterEffect(e2)
end

function c84130861.triggerCondition(e, tp, eg, ep, ev, re, r, rp)
    return eg:IsExists( function(c)
        return c:GetControler() == tp and c:IsType(TYPE_SPELL + TYPE_TRAP)
    end , 1, nil)
end

function c84130861.triggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    local e1 = e:GetLabelObject()
    if e1 then
        local original_g = e1:GetLabelObject()
        local g = original_g:Clone()
        g:Merge(eg)
        e1:SetLabelObject(g)

        g:KeepAlive()
        original_g:DeleteGroup()
    else
        e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
        e1:SetCode(EVENT_PHASE + PHASE_END)
        e1:SetRange(LOCATION_SZONE)
        local g = eg:Clone()
        e1:SetLabelObject(g)
        e1:SetCondition(c84130861.activateCondition)
        e1:SetCost(c84130861.activateCost)
        e1:SetOperation(c84130861.activateOperation)
        e1:SetCountLimit(1)
        e1:SetReset(RESET_PHASE + PHASE_END)
        c:RegisterEffect(e1)

        g:KeepAlive()
        e:SetLabelObject(e1)
    end
end

function c84130861.activateCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetLocationCount(tp, LOCATION_SZONE, tp, LOCATION_REASON_TOFIELD) >= e:GetLabelObject():FilterCount( function(c)
        return c:GetControler() == tp
    end , nil)
end

function c84130861.activateCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.CheckLPCost(tp, 1000)
    end
    Duel.PayLPCost(tp, 1000)
end

function c84130861.activateOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = e:GetLabelObject():Filter( function(c)
        return c:GetControler() == tp
    end , nil)
    Duel.SSet(tp, g, tp)
end

function c84130861.qijiFilter(c)
    return c:IsCode(84130829)
end

function c84130861.qijiCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(c84130861.qijiFilter, tp, LOCATION_MZONE, 0, 1, nil)
end

function c84130861.destroyFilter(c, e)
    return c:IsType(TYPE_CONTINUOUS) and c:IsCanBeEffectTarget(e) and c:IsDestructable()
end

function c84130861.qijiTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard( function(c)
            return c84130861.destroyFilter(c, e)
        end , tp, 0, LOCATION_SZONE, 1, nil)
    end
    local g = Duel.SelectMatchingCard(tp, function(c)
        return c84130861.destroyFilter(c, e)
    end , tp, 0, LOCATION_SZONE, 1, 1, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, g, g:GetCount(), nil, nil)
end

function c84130861.qijiOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if g then
        Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
    end
end
-- endregion
