-- region *.lua
-- 2015-11-26
-- 此文件由[BabeLua]插件自动生成

-- MC群融合
function c284130850.initial_effect(c)
    -- 发动
    -- 参考[65331686]毛绒动物·猫头鹰
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetTarget(c284130850.activateTarget)
    e1:SetOperation(c284130850.activateOperation)
    c:RegisterEffect(e1)

    -- 墓地起动
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition(c284130850.graveCondition)
    e2:SetCost(c284130850.graveCost)
    e2:SetOperation(c284130850.graveOperation)
    c:RegisterEffect(e2)
end

function c284130850.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130850.filter2(c, e)
    return c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end

function c284130850.filter3(c, e, tp, m, f, chkf)
    return c:IsType(TYPE_FUSION) and c:IsSetCard(0xad) and(not f or f(c))
    and c:IsCanBeSpecialSummoned(e, SUMMON_TYPE_FUSION, tp, false, false) and c:CheckFusionMaterial(m, nil, chkf)
end

function c284130850.activateTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return
    end
end

function c284130850.activateOperation(e, tp, eg, ep, ev, re, r, rp)
end

function c284130850.graveCondition(e, tp, eg, ep, ev, re, r, rp)
    return
end

function c284130850.graveCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return
    end
end

function c284130850.graveOperation(e, tp, eg, ep, ev, re, r, rp)
end

-- endregion
