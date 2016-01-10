-- MC群的最终领袖 纸睡前辈

function c284130843.initial_effect(c)
    -- 同调召唤
    c:EnableReviveLimit()
    -- 因为要使用超量怪兽的阶级进行同调召唤，而ygopro将超量怪兽的同调用等级视为0；
    -- 因此这不是真正的同调召唤，而是个扩展的版本。
    -- 暂定名为[好热闹啊]同调

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_SPSUMMON_PROC)
    e1:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_IGNORE_IMMUNE)
    e1:SetRange(LOCATION_EXTRA)
    e1:SetCondition(c284130843.synCondition)
    e1:SetTarget(c284130843.synTarget)
    e1:SetOperation(c284130843.synOperation)
    e1:SetValue(SUMMON_TYPE_SYNCHRO)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e2:SetCode(EFFECT_SPSUMMON_CONDITION)
    e2:SetRange(LOCATION_EXTRA)
    c:RegisterEffect(e2)

    -- 展示
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_EXTRA)
    e3:SetCountLimit(1, 84130843)
    e3:SetCondition(c284130843.showCondition)
    e3:SetCost(c284130843.showCost)
    e3:SetOperation(c284130843.showOperation)
    c:RegisterEffect(e3)

    -- 魔免
    -- 参考[94784213]威风妖怪·狐
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e4:SetRange(LOCATION_MZONE)
    e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    e4:SetValue(aux.tgval)
    c:RegisterEffect(e4)

    local e5 = e4:Clone()
    e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    e5:SetValue(1)
    c:RegisterEffect(e5)

    -- 控制权
    -- 参考[75830094]荷鲁斯之黑炎龙 LV4
    local e6 = Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_SINGLE)
    e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e6:SetRange(LOCATION_MZONE)
    e6:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
    c:RegisterEffect(e6)

    -- 无效效果
    -- 参考[35952884]流天类星龙
    local e7 = Effect.CreateEffect(c)
    e7:SetCategory(CATEGORY_NEGATE)
    e7:SetType(EFFECT_TYPE_QUICK_O)
    e7:SetCode(EVENT_CHAINING)
    e7:SetLabel(0)
    -- 因为SetCountLimit不能传函数所以用Label来实现
    e7:SetProperty(EFFECT_FLAG_DAMAGE_STEP + EFFECT_FLAG_DAMAGE_CAL)
    e7:SetRange(LOCATION_MZONE)
    e7:SetCondition(c284130843.negateCondition)
    e7:SetTarget(c284130843.negateTarget)
    e7:SetOperation(c284130843.negateOperation)
    c:RegisterEffect(e7)

    -- 每回合重置e7
    local e8 = Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_CONTINUOUS)
    e8:SetCode(EVENT_TURN_END)
    e8:SetRange(LOCATION_MZONE)
    e8:SetLabelObject(e6)
    e8:SetOperation(c284130843.resetOperation)
    c:RegisterEffect(e8)

    -- 亡语
    local e9 = Effect.CreateEffect(c)
    e9:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e9:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e9:SetCode(EVENT_TO_GRAVE)
    e9:SetCondition(c284130843.tograveCondition)
    e9:SetOperation(c284130843.tograveOperation)
    c:RegisterEffect(e9)
end	

function c284130843.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130843.synchroFilter1(c)
    return c:IsType(TYPE_SYNCHRO)
end

function c284130843.synchroFilter2(c)
    if Duel.GetFlagEffect(c:GetControler(), 284130843) > 0 then
        return(c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ) or c:IsType(TYPE_PENDULUM))
    else
        return(c:IsType(TYPE_FUSION) or c:IsType(TYPE_PENDULUM))
    end
end

function c284130843.synchroLevel(c, sc)
    if c:IsType(TYPE_XYZ) then
        return c:GetRank()
    else
        return c:GetSynchroLevel(sc)
    end
end

function c284130843.checkTunerMaterial(c, tuner, minc, maxc, mg)
    -- 检查以tuner作为调整，[在mg中]是否存在一组满足条件的min-max张卡作为同调召唤c的素材
    if c284130843.synchroFilter1(tuner) then
        local g = nil
        if mg then
            g = mg:Filter(c284130843.synchroFilter2, nil)
            g:RemoveCard(tuner)
        else
            g = Duel.GetMatchingGroup(c284130843.synchroFilter2, c:GetControler(), LOCATION_MZONE, 0, tuner)
        end
        return g:CheckWithSumEqual(c284130843.synchroLevel, c:GetLevel() - tuner:GetSynchroLevel(c), minc, maxc, c)
    else
        return false
    end
end

function c284130843.checkSynchroMaterial(c, minc, maxc, smat, mg)
    -- 检查[mg中]是否存在一组[必须包括smat在内的]满足条件的min-max张卡作为同调召唤c的素材
    if not mg then
        smat = nil
        mg = Duel.GetMatchingGroup(aux.OR(c284130843.synchroFilter1, c284130843.synchroFilter2), tp, LOCATION_MZONE, 0, nil)
    end

    if smat then
        if smat:IsType(TYPE_TUNER) and c284130843.synchroFilter1(smat) then
            return c284130843.checkTunerMaterial(c, smat, minc - 1, maxc - 1, mg)
        elseif c284130843.synchroFilter2(smat) then
            -- 如果smat不是tuner，那么需要先从mg中找出tuner，然后对每个tuner测试等级和
            local tuner_g = mg:Filter(c284130843.synchroFilter1, nil)
            if tuner_g:GetCount() > 0 then
                local tuner = tuner_g:GetFirst()
                while tuner do
                    local tuner_lv = c284130843.synchroLevel(tuner, c)
                    local smat_lv = c284130843.synchroLevel(smat, c)
                    local tuner_smat = Group.FromCards(tuner, smat)
                    if mg:Clone():Sub(tuner_smat):checkWithSumEqual(c284130843.synchroLevel, c:GetLevel() - tuner_lv - smat_lv, minc - 2, maxc - 2, c) then
                        return true
                    end
                    tuner = g:GetNext()
                end
            else
                return false
            end
        else
            return false
        end
    else
        local tuner_g = mg:Filter(c284130843.synchroFilter1, nil)
        if tuner_g:GetCount() > 0 then
            local tuner = tuner_g:GetFirst()
            while tuner do
                local tuner_lv = c284130843.synchroLevel(tuner, c)
                if c284130843.checkTunerMaterial(c, tuner, minc - 1, maxc - 1, mg) then
                    return true
                end
                tuner = tuner_g:GetNext()
            end
        else
            return false
        end
    end
    return false
end

function c284130843.selectTunerMaterial(player, c, tuner, min, max, mg)
    -- 让玩家[从mg中]选择用于同调c需要的满足条件的以tuner作为调整的min-max张卡的一组素材

    --    if Duel.IsPlayerAffectedByEffect(player, EFFECT_MUST_BE_SMATERIAL) then
    -- 额外处理，暂时不写
    --    end

    local g = Group.FromCards(tuner)

    if mg then
        mg:RemoveCard(tuner)
    else
        mg = Duel.GetMatchingGroup(c284130843.synchroFilter2, player, LOCATION_MZONE, 0, tuner)
    end

    Duel.Hint(HINT_SELECTMSG, player, HINTMSG_SMATERIAL)
    local material_g = mg:SelectWithSumEqual(player, c284130843.synchroLevel, c:GetLevel() - c284130843.synchroLevel(tuner, c), min, max, c)

    g:Merge(material_g)
    return g
end

function c284130843.selectSynchroMaterial(player, c, min, max, smat, mg)
    -- 让玩家player[从mg中]选择用于同调c需要的[必须包含smat在内（如果有mg~=nil则忽略此参数）]满足条件的数量为min-max的一组素材。
    if not mg then
        smat = nil
        mg = Duel.GetMatchingGroup(aux.OR(c284130843.synchroFilter1, c284130843.synchroFilter2), tp, LOCATION_MZONE, 0, nil)
    end

    local g = Group.CreateGroup()
    if smat then
        if smat:IsType(TYPE_TUNER) and c284130843.synchroFilter1(smat) then
            return c284130843.selectTunerMaterial(player, c, smat, minc - 1, maxc - 1, mg)
        elseif c284130843.synchroFilter2(smat) then
            g:AddCard(smat)
            local tuner_g_temp = mg:Filter(c284130843.synchroFilter1, nil)
            local tuner_g = Group.CreateGroup()
            if tuner_g_temp:GetCount() > 0 then
                local tuner = tuner_g_temp:GetFirst()
                while tuner do
                    local tuner_lv = c284130843.synchroLevel(tuner, c)
                    local smat_lv = c284130843.synchroLevel(smat, c)
                    local tuner_smat = Group.FromCards(tuner, smat)
                    if mg:Clone():Sub(tuner_smat):checkWithSumEqual(c284130843.synchroLevel, c:GetLevel() - tuner_lv - smat_lv, minc - 2, maxc - 2, c) then
                        tuner_g:AddCard(tuner)
                    end
                    tuner = tuner_g_temp:GetNext()
                end
                Duel.Hint(HINT_SELECTMSG, player, HINTMSG_SMATERIAL)
                tuner = tuner_g:Select(player, 1, 1, nil)
            end
            g:AddCard(tuner)
            local tuner_lv = c284130843.synchroLevel(tuner, c)
            local smat_lv = c284130843.synchroLevel(smat, c)
            local tuner_smat = Group.FromCards(tuner, smat)
            Duel.Hint(HINT_SELECTMSG, player, HINTMSG_SMATERIAL)
            return g:Merge(mg:Clone():Sub(tuner_smat):SelectWithSumEqual(player, c284130843.synchroLevel, c:GetLevel() - tuner_lv - smat_lv, min - 2, min - 2, c))
        end
    else
        local tuner_g_temp = mg:Filter(c284130843.synchroFilter1, nil)
        local tuner_g = Group.CreateGroup()
        if tuner_g_temp:GetCount() > 0 then
            local tuner = tuner_g_temp:GetFirst()
            while tuner do
                local tuner_lv = c284130843.synchroLevel(tuner, c)
                if c284130843.checkTunerMaterial(c, tuner, min - 1, max - 1, mg) then
                    tuner_g:AddCard(tuner)
                end
                tuner = tuner_g_temp:GetNext()
            end
            Duel.Hint(HINT_SELECTMSG, player, HINTMSG_SMATERIAL)
            tuner = tuner_g:Select(player, 1, 1, nil):GetFirst()
            return c284130843.selectTunerMaterial(player, c, tuner, min - 1, max - 1, mg)
        end
    end
    Debug.Message("impossible!")
end

function c284130843.synCondition(e, c, smat, mg)
    if c == nil then
        return true
    end
    if c:IsType(TYPE_PENDULUM) and c:IsFaceup() then
        return false
    end
    local ft = Duel.GetLocationCount(c:GetControler(), LOCATION_MZONE)
    local ct = - ft
    local minc = 2
    local maxc = 99
    if minc < ct then
        minc = ct
    end
    if maxc < minc then
        return false
    end
    if smat and smat:IsType(TYPE_TUNER) and c284130843.synchroFilter1(smat) then
        return c284130843.checkTunerMaterial(c, smat, minc, maxc, mg)
    else
        return c284130843.checkSynchroMaterial(c, minc, maxc, smat, mg)
    end
end

function c284130843.synTarget(e, tp, eg, ep, ev, re, r, rp, chk, c, smat, mg)
    local g = nil
    local ft = Duel.GetLocationCount(c:GetControler(), LOCATION_MZONE)
    local ct = - ft
    local minc = 2
    local maxc = 99
    if minc < ct then
        minc = ct
    end
    if smat and smat:IsType(TYPE_TUNER) and c284130843.synchroFilter1(smat) then
        g = c284130843.selectTunerMaterial(c:GetControler(), c, smat, minc, maxc, mg)
    else
        g = c284130843.selectSynchroMaterial(c:GetControler(), c, minc, maxc, smat, mg)
    end
    if g then
        g:KeepAlive()
        e:SetLabelObject(g)
        return true
    else
        return false
    end
end

function c284130843.synOperation(e, tp, eg, ep, ev, re, r, rp, c, smat, mg)
    local g = e:GetLabelObject()
    c:SetMaterial(g)
    Duel.SendtoGrave(g, REASON_MATERIAL + REASON_SYNCHRO)
    g:DeleteGroup()
end

function c284130843.showCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp and bit.band(Duel.GetCurrentPhase(), PHASE_MAIN1 + PHASE_MAIN2) > 0
end

function c284130843.showCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    Duel.ConfirmCards(1 - tp, e:GetHandler())
end

function c284130843.showOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.RegisterFlagEffect(tp, 284130843, RESET_PHASE + PHASE_END, nil, 1)
end

function c284130843.negateFilter(c)
    return c284130843.filter(c) and c284130843.synchroFilter2(c)
end

function c284130843.negateCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.IsChainNegatable(ev) and Duel.GetMatchingGroupCount(c284130843.negateFilter, tp, LOCATION_MZONE, 0, nil) > e:GetLabel()
end

function c284130843.negateTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return true
    end
    Duel.SetOperationInfo(0, CATEGORY_NEGATE, eg, 1, nil, nil)
end

function c284130843.negateOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.NegateActivation(ev)
    e:SetLabel(e:GetLabel() + 1)
end

function c284130843.tograveCondition(e, tp, eg, ep, ev, re, r, rp)
    local test1 = bit.band(e:GetHandler():GetPreviousLocation(), LOCATION_MZONE)
    local test2 = Duel.GetLocationCount(tp, LOCATION_MZONE) > 0
    local test3 = Duel.IsExistingMatchingCard(c284130843.tograveFilter, tp, LOCATION_HAND + LOCATION_GRAVE, 0, nil)
    return test1 and test2 and test3
end

function c284130843.tograveFilter(c)
    return c284130843.filter(c) and c:IsSpecialSummonable()
end

function c284130843.tograveOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.SelectMatchingCard(tp, c284130843.tograveFilter, tp, LOCATION_HAND + LOCATION_GRAVE, 0, 1, Duel.GetLocationCount(tp, LOCATION_MZONE), nil)
    local c = g:GetFirst()
    while c do
        local pos = Duel.SelectPosition(tp, c, POS_FACEUP)
        Duel.SpecialSummonStep(c, SUMMON_TYPE_SPECIAL, tp, tp, false, false, pos)

        c = g:GetNext()
    end
    Duel.SpecialSummonComplete()

    local e1 = Effect.CreateEffect(e:GetHandler())
    -- 参考[37576645}无谋的贪欲
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EFFECT_SKIP_DP)
    e1:SetTargetRange(1, 0)
    e1:SetReset(RESET_PHASE + PHASE_END, 5)
    Duel.RegisterEffect(e1, tp)

    local e2 = e1:Clone()
    -- 参考[54447022]灵魂补充
    e2:SetCode(EFFECT_CANNOT_BP)
    Duel.RegisterEffect(e2, tp)
end

function c284130843.resetOperation(e, tp, eg, ep, ev, re, r, rp)
    e:GetLabelObject():SetLabel(0)
end