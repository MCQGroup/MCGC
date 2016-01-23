-- region *.lua
-- 2015-11-26
-- 此文件由[BabeLua]插件自动生成

-- MC群融合
function c84130850.initial_effect(c)
    -- 发动
    -- 参考[65331686]毛绒动物·猫头鹰
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetTarget(c84130850.activateTarget)
    e1:SetOperation(c84130850.activateOperation)
    c:RegisterEffect(e1)

    -- 墓地起动
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition(c84130850.graveCondition)
    e2:SetCost(c84130850.graveCost)
    e2:SetOperation(c84130850.graveOperation)
    c:RegisterEffect(e2)
end

function c84130850.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130850.filter2(c, e)
    -- 融合素材
    return c84130850.filter(c) and c:IsCanBeFusionMaterial() and not c:IsImmuneToEffect(e)
end

function c84130850.filter3(c, e, tp, m, f, chkf)
    -- 融合对象
    return c:IsType(TYPE_FUSION) and c84130850.filter(c) and(not f or f(c))
    and c:IsCanBeSpecialSummoned(e, SUMMON_TYPE_FUSION, tp, false, false) and c:CheckFusionMaterial(m, nil, chkf)
end

function c84130850.activateTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        -- local chkf = Duel.GetLocationCount(tp, LOCATION_MZONE) > 0 and PLAYER_NONE or tp
        local chkf = Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
        local mg1 = Duel.GetMatchingGroup(c84130850.filter2, tp, LOCATION_MZONE, 0, nil, e)
        -- 场上可以用作融合素材的卡片
        local res = Duel.IsExistingMatchingCard(c84130850.filter3, tp, LOCATION_EXTRA, 0, 1, nil, e, tp, mg1, nil, chkf)
        -- 额外卡组是否中符合要求的卡片
        if not res then
            -- 如果没有则处理连锁素材效果
            local ce = Duel.GetChainMaterial(tp)
            if ce ~= nil then
                local fgroup = ce:GetTarget()
                local mg2 = fgroup(ce, e, tp)
                local mf = ce:GetValue()
                res = Duel.IsExistingMatchingCard(c84130850.filter3, tp, LOCATION_EXTRA, 0, 1, nil, e, tp, mg2, mf, chkf)
            end
        end
        return res
    end
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, nil, 1, tp, LOCATION_EXTRA)
end

function c84130850.activateOperation(e, tp, eg, ep, ev, re, r, rp)
    local chkf = Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
    local mg1 = Duel.GetMatchingGroup(c84130850.filter2, tp, LOCATION_MZONE, 0, nil, e)
    local sg1 = Duel.GetMatchingGroup(c84130850.filter3, tp, LOCATION_EXTRA, 0, nil, e, tp, mg1, nil, chkf)
    local mg2 = nil
    local sg2 = nil
    local ce = Duel.GetChainMaterial(tp)
    if ce ~= nil then
        -- 处理连锁素材效果
        local fgroup = ce:GetTarget()
        mg2 = fgroup(ce, e, tp)
        local mf = ce:GetValue()
        sg2 = Duel.GetMatchingGroup(c84130850.filter3, tp, LOCATION_EXTRA, 0, nil, e, tp, mg2, mf, chkf)
    end
    if sg1:GetCount() > 0 or(sg2 ~= nil and sg2:GetCount() > 0) then
        local sg = sg1:Clone()
        if sg2 then
            sg:Merge(sg2)
        end
        Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SPSUMMON)
        local tg = sg:Select(tp, 1, 1, nil)
        local tc = tg:GetFirst()
        if sg1:IsContains(tc) and(sg2 == nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp, ce:GetDescription())) then
            local mat1 = Duel.SelectFusionMaterial(tp, tc, mg1, nil, chkf)
            tc:SetMaterial(mat1)
            Duel.SendtoGrave(mat1, REASON_EFFECT + REASON_MATERIAL + REASON_FUSION)
            Duel.BreakEffect()
            Duel.SpecialSummon(tc, SUMMON_TYPE_FUSION, tp, tp, false, false, POS_FACEUP)
        else
            local mat2 = Duel.SelectFusionMaterial(tp, tc, mg2, nil, chkf)
            local fop = ce:GetOperation()
            fop(ce, e, tp, tc, mat2)
        end
        tc:CompleteProcedure()
    else
        local cg1 = Duel.GetFieldGroup(tp, LOCATION_HAND + LOCATION_MZONE, 0)
        local cg2 = Duel.GetFieldGroup(tp, LOCATION_EXTRA, 0)
        if cg1:GetCount() > 1 and cg2:IsExists(Card.IsFacedown, 1, nil)
            and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp, 27581098) then
            -- 检查[27581098]融合禁止地区
            Duel.ConfirmCards(1 - tp, cg1)
            Duel.ConfirmCards(1 - tp, cg2)
            Duel.ShuffleHand(tp)
        end
    end
end

function c84130850.MCQFilter(c)
    return c:IsCode(84130814) and c:IsFaceup()
end

function c84130850.graveCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsExistingMatchingCard(c84130850.MCQFilter, tp, LOCATION_SZONE, 0, nil)
end

function c84130850.graveCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return bit.band(Duel.GetCurrentPhase(), PHASE_MAIN1 + PHASE_MAIN2) ~= 0
    end
    Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_COST)
end

function c84130850.graveFusionFilter(c)
    return c84130850.filter(c) and c:IsType(TYPE_FUSION)
end

function c84130850.graveOperation(e, tp, eg, ep, ev, re, r, rp)
    local sel = Duel.SelectOption(tp, aux.Stringid(84130850, 0), aux.Stringid(84130850, 1))
    Debug.Message(sel)
    if sel == 0 then
        local g = Duel.SelectMatchingCard(tp, c84130850.graveFusionFilter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
        local c = g:GetFirst()
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        Duel.SpecialSummon(c, SUMMON_TYPE_SPECIAL, tp, tp, true, true, pos)
    else
        local g1 = Duel.GetMatchingGroup(c84130850.MCQFilter, tp, LOCATION_SZONE, 0, nil)
        local g2 = Duel.SelectMatchingCard(tp, Card.IsType, tp, LOCATION_MZONE, LOCATION_MZONE, 1, 1, nil, TYPE_MONSTER)
        Duel.SendtoGrave(g1, REASON_EFFECT)
        Duel.SendtoGrave(g2, REASON_EFFECT)
        local g3 = Duel.SelectMatchingCard(tp, Card.IsType, tp, LOCATION_EXTRA, 0, 1, 1, nil, TYPE_FUSION)
        local c = g3:GetFirst()
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        if Duel.SpecialSummonStep(c, SUMMON_TYPE_SPECIAL, tp, tp, true, true, pos) then
            local e1 = Effect.CreateEffect(c)
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_CANNOT_ATTACK)
            e1:SetReset(RESET_EVENT + RESET_DISABLE + RESET_TURN_SET + RESET_TOGRAVE + RESET_REMOVE + RESET_TEMP_REMOVE + RESET_TOHAND + RESET_TODECK + RESET_LEAVE)
            c:RegisterEffect(e1)

            local e2 = e1:Clone()
            e2:SetType(EFFECT_TYPE_CONTINUOUS)
            e2:SetCode(EVENT_PHASE + PHASE_END)
            e2:SetOperation(c84130850.backExtraOperation)
            c:RegisterEffect(e2)
        end
    end

    function c84130850.backExtraOperation(e, tp, eg, ep, ev, re, r, rp)
        -- 卧槽应该怎么把卡放进额外卡组？
        Duel.SendtoDeck(e:GetHandler(), nil, nil, REASON_EFFECT)
    end
end

-- endregion
