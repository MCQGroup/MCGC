-- region *.lua
-- 2016-04-15
-- 此文件由[BabeLua]插件自动生成

-- MC群的军势
function c84130867.initial_effect(c)
    -- 攻击响应
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
    e1:SetCondition(c84130867.attackTriggerCondition)
    e1:SetOperation(c84130867.attackTriggerOperation)
    c:RegisterEffect(e1)

    -- 无效破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_ACTIVATE)
    e2:SetCode(EVENT_CHAINING)
    e2:SetCondition()
    e2:SetOperation()
    c:RegisterEffect(e2)
end

function c84130867.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130867.attackTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
    -- 参考[10759529]小子防御
    return tp ~= Duel.GetTurnPlayer()
end

function c84130867.attackTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    -- 参考[126218]恶魔的骰子
    local g = Duel.GetFieldGroup(tp, 0, LOCATION_MZONE)
    if g and g:GetCount() > 0 then
        local c = g:GetFirst()
        while c do
            local e1 = Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_UPDATE_ATTACK)
            e1:SetTargetRange(0, LOCATION_MZONE)
            e1:SetValue(-500 * Duel.GetMatchingGroupCount( function(c)
                return c84130867.filter(c) and c:IsType(TYPE_MONSTER)
            end , tp, LOCATION_MZONE, 0, nil))
            c:RegisterEffect(e1)

            c = g:GetNext()
        end
    end
end
-- endregion
