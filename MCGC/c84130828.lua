-- MC群的吉祥物 罐罐子

function c84130828.initial_effect(c)
    -- 无解放普招
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetRange(LOCATION_HAND)
    e1:SetValue(SUMMON_TYPE_ADVANCE)
    e1:SetCondition(c84130828.noTributeCondition)
    c:RegisterEffect(e1)

    -- 手卡特招
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_HAND)
    e2:SetCondition(c84130828.spSummonCondition)
    c:RegisterEffect(e2)

    -- 触发团结之力
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_DAMAGE_CALCULATING)
    e3:SetRange(LOCATION_MZONE)
    e3:SetOperation(c84130828.atkUp)
    c:RegisterEffect(e3)
end

function c84130828.noTributeCondition(e)
    local c = e:GetHandler()
    local tp = c:GetControler()
    return Duel.GetFieldGroupCount(tp, LOCATION_MZONE, 0) == 0 and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
end

function c84130828.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130828.spSummonCondition(e, c)
    return Duel.GetMatchingGroupCount(c84130828.filter, tp, LOCATION_ONFIELD, 0, nil) > 2
end

function c84130828.atkUp(e, tp, eg, ep, ev, re, r, rp)
    local a = Duel.GetAttacker()
    local d = Duel.GetAttackTarget()
    local test1 = a:IsSetCard(0x2222) and a:IsControler(tp)
    local test2 = false
    if d then
        test2 = d:IsSetCard(0x2222) and d:IsControler(tp)
    end
    if test1 or test2 then
        local atk = Duel.GetMatchingGroupCount(c84130828.filter, tp, LOCATION_ONFIELD, 0, nil) * 100
        if test1 then
            local e1 = Effect.CreateEffect(a)
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetReset(RESET_PHASE + PHASE_DAMAGE_CAL)
            e1:SetValue(atk)
            a:RegisterEffect(e1)
        end
        if test2 then
            local e2 = Effect.CreateEffect(d)
            e2:SetType(EFFECT_TYPE_SINGLE)
            e2:SetCode(EFFECT_UPDATE_ATTACK)
            e2:SetReset(RESET_PHASE + PHASE_DAMAGE_CAL)
            e2:SetValue(atk)
            d:RegisterEffect(e2)
        end
    end
end
