-- MC群的最终领袖 纸睡前辈

function c284130843.initial_effect(c)
    -- 同调召唤
    c:EnableReviveLimit()
    aux.AddSynchroProcedure(c, c284130843.synchroFilter1, aux.NonTuner(c284130843.synchroFilter2), 2)
    -- 因为要使用超量怪兽的阶级进行同调召唤，而ygopro将超量怪兽的同调用等级视为0；
    -- 因此这不是真正的同调召唤，而是个扩展的版本。
    -- 暂定名为[好热闹啊]同调

    local e0 = Effect.CreateEffect(c)
    e0:SetType(EFFECT_TYPE_FIELD)
    e0:SetCode(EFFECT_SPSUMMON_PROC)
    e0:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_IGNORE_IMMUNE)
    e0:SetRange(LOCATION_EXTRA)
    e0:SetCondition(c284130843.synCondition)
    e0:SetTarget(c284130843.synTarget)
    e0:SetOperation(c284130843.synOperation)
    e0:SetValue(SUMMON_TYPE_SYNCHRO)
    c:RegisterEffect(e0)

    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetRange(LOCATION_EXTRA)
    c:RegisterEffect(e1)

    -- 展示
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetCondition(c284130843.showCondition)
    e2:SetCost(c284130843.showCost)
    e2:SetOperation(c284130843.showOperation)
    c:RegisterEffect(e2)

    -- 魔免
    -- 参考[94784213]威风妖怪·狐
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
    c:RegisterEffect(e3)

    local e4 = e3:Clone()
    e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
    c:RegisterEffect(e4)

    -- 控制权
    -- 参考[75830094]荷鲁斯之黑炎龙 LV4
    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
    c:RegisterEffect(e5)

    -- 无效效果
    -- 参考[35952884]流天类星龙
    local e6 = Effect.CreateEffect(c)
    e6:SetCategory(CATEGORY_NEGATE)
    e6:SetType(EFFECT_TYPE_QUICK_O)
    e6:SetCode(EVENT_CHAINING)
    e6:SetLabel(0)
    -- 因为SetCountLimit不能传函数所以用Label来实现
    e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP + EFFECT_FLAG_DAMAGE_CAL)
    e6:SetRange(LOCATION_MZONE)
    e6:SetCondition(c284130843.negateCondition)
    e6:SetTarget(c284130843.negateTarget)
    e6:SetOperation(c284130843.negateOperation)
    c:RegisterEffect(e6)

    -- 亡语
    local e7 = Effect.CreateEffect(c)
    e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e6:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e6:SetCode(EVENT_TO_GRAVE)
    e6:SetCondition(c284130843.tograveCondition)
    e6:SetOperation(c284130843.tograveOperation)
    c:RegisterEffect(e7)

    -- 每回合重置e6
    local e8 = Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_CONTINUOUS)
    e8:SetCode(EVENT_TURN_END)
    e8:SetRange(LOCATION_MZONE)
    e8:SetLabelObject(e6)
    e8:SetOperation(c284130843.resetOperation)
    c:RegisterEffect(e8)
end	

function c284130843.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130843.synchroFilter1(c)
    return c:IsType(TYPE_SYNCHRO)
end

function c284130843.synchroFilter2(c)
    return(c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ) or c:IsType(TYPE_PENDULUM))
end

function c284130843.synchroLevel(c)
    if c:IsType(TYPE_XYZ) then
        return c:GetRank()
    else
        return c:GetSynchroLevel()
    end
end

function c284130843.checkTunerMaterial(c, tuner, minc, maxc, mg)
    -- 检查以tuner作为调整[在mg中]是否存在一组满足条件的min-max张卡作为同调召唤c的素材
    -- f1是调整需要满足的过滤条件，f2是调整以外的部分需要满足的过滤条件
    local g = nil
    local c_lv = c:GetLevel()
    local tuner_lv = tuner:GetSynchroLevel()

    if c284130843.synchroFilter1(tuner) then
        if mg then
            g = mg:Filter(c284130843.synchroFilter2, nil)
        else
            g = Duel.GetMatchingGroup(c284130843.synchroFilter2, c:GetControler(), LOCATION_MZONE, 0, nil)
        end
        return g:CheckWithSumEqual(c284130843.synchroLevel, c_lv - tuner_lv, minc, maxc)
    else
        return false
    end
end

function c284130843.checkSynchroMaterial(c, minc, maxc, smat, mg)
    -- 检查[mg中]是否存在一组[必须包括smat在内的]满足条件的min-max张卡作为同调召唤c的素材
    -- f1是调整需要满足的过滤条件，f2是调整以外的部分需要满足的过滤条件
    local g = nil
    local lv = nil
    local c_lv = c:GetLevel()

    if smat and mg then
        if smat:IsType(TYPE_TUNER) and c284130843.synchroFilter1(smat) then
            g = mg:Filter(c284130843.synchroFilter2, nil)
            lv = c_lv - c284130843.synchroLevel(smat)
        elseif smat:IsType(TYPE_SYNCHRO) and c284130843.synchroFilter2(smat) then
            -- 需要从mg中找到一个合适的tuner
            lv = c_lv - c284130843.synchroLevel(smat)
        else
            return false
        end
    elseif smat and not mg then
        local temp_g = Duel.GetMatchingGroup(aux.OR(c284130843.synchroFilter1, c284130843.synchroFilter2), c:GetControler(), LOCATION_MZONE, 0, smat)

    elseif not smat and mg then
    else
    end
    return g:CheckWithSumEqual(c284130843.synchroLevel, lv, minc, maxc)
end

function c284130843.selectTunerMaterial(player, c, tuner, min, max, mg)
    -- 让玩家[从mg中]选择用于同调c需要的满足条件的以tuner作为调整的min-max张卡的一组素材
    -- f1是调整需要满足的过滤条件，f2是调整以外的部分需要满足的过滤条件
end

function c284130843.selectSynchroMaterial(player, c, min, max, smat, mg)
    -- 让玩家player[从mg中]选择用于同调c需要的[必须包含smat在内（如果有mg~=nil则忽略此参数）]满足条件的数量为min-max的一组素材。
    -- f1是调整需要满足的过滤条件。f2是调整以外的部分需要满足的过滤条件。
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
    local minc = minct
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
    local minc = minct
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

function c284130843.showSynchroFilter(c, syncard, tuner, f)
    return c:IsFaceup() and c:IsNotTuner() and c:IsCanBeSynchroMaterial(syncard, tuner) and(f == nil or f(c))
end

function c284130843.showSynchroCheck(c)
    if Duel.GetFlagEffect(tp, 284130843) and c:IsType(TYPE_XYZ) then
        return c:GetRank()
    else
        return c:GetSynchroLevel()
    end
end

function c284130843.showOperation(e, tp, eg, ep, ev, re, r, rp)
    -- 参考EFFECT_SYNCHRO_MATERIAL_CUSTOM
    Duel.RegisterFlagEffect(tp, 284130843, RESET_PHASE + RESET_END, nil, 1)

    local tg = Duel.GetMatchingGroup(Card.IsType, tp, LOCATION_MZONE, 0, nil, TYPE_XYZ)
    local tc = tg:GetFirst()
    while tc do
        local te = Effect.CreateEffect(tc)
        te:SetType(EFFECT_TYPE_FIELD)
        te:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
        te:SetCondition( function(ein, tpin, egin, epin, evin, rein, rin, rpin)
            return Duel.GetFlagEffect(tp, 284130843)
        end )
        te:SetTarget( function(ein, syncard, f, minc, maxc)
            local c = ein:GetHandler()
            local lv = syncard:GetLevel() - c:GetRank()
            if lv <= 0 then
                return false
            end
            local g = Duel.GetMatchingGroup(c284130843.showSynchroFilter, tp, LOCATION_MZONE, 0, c, syncard, c, f)
            return g:CheckWithSumEqual(c284130843.showSynchroCheck, lv, minc, maxc, syncard)
        end )
        te:SetValue(1)
        te:SetOperation( function(ein, tpin, egin, epin, evin, rein, rin, rpin, syncard, f, minc, maxc)
            local c = ein:GetHandler()
            local lv = syncard:GetLevel() - c:GetRank()
            local g = Duel.GetMatchingGroup(c284130843.showSynchroFilter, tp, LOCATION_MZONE, 0, c, syncard, c, f)
            Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_SMATERIAL)
            local sg = g:SelectWithSumEqual(tp, c284130843.showSynchroCheck, lv, minc, maxc, syncard)
            Duel.SetSynchroMaterial(sg)
        end )
        tc:RegisterEffect(te)

        tc = tg:GetNext()
    end
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
    return bit.band(e:GetHandler():GetPreviousLocation(), LOCATION_MZONE) and Duel.GetLocationCount(tp, LOCATION_MZONE) > 0 and Duel.IsExistingMatchingCard(c284130843.tograveFilter, tp, LOCATION_HAND + LOCATION_GRAVE, 0, nil)
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