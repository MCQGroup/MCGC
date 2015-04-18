-- MC群的苦逼 DZ
function c284130813.initial_effect(c)
    -- 反转召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DESTROY)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    e1:SetOperation(c284130813.destroyOperation)
    c:RegisterEffect(e1)

    -- 不会被战斗破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e2:SetValue(1)
    c:RegisterEffect(e2)

    -- 卡组检索、特招、送墓
    local e3 = Effect.CreateEffect(c)
    e3:SetDescription(aux.Stringid(74131780, 0))
    e3:SetCategory(CATEGORY_SEARCH + CATEGORY_RELEASE + CATEGORY_SPECIAL_SUMMON + CATEGORY_TOGRAVE)
    e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e3:SetType(EFFECT_TYPE_IGNITION)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCost(c284130813.cost)
    e3:SetTarget(c284130813.target)
    e3:SetOperation(c284130813.operation)
    c:RegisterEffect(e3)
end

function c284130813.filter(c)
    return c:IsSetCard(0x2222) and c:IsType(TYPE_MONSTER)
end

function c284130813.destroyOperation(e, tp, eg, ep, ev, re, r, rp)
    c = e:GetHandler()
    Duel.Destroy(c, REASON_EFFECT)
end

function c284130813.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return e:GetHandler():IsReleasable()
    end
    Duel.Release(e:GetHandler(), REASON_COST)
end

function c284130813.target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(c284130813.filter, tp, LOCATION_DECK, 0, nil) >= 2
    end
    local g = Duel.SelectMatchingCard(tp, c284130813.filter, tp, LOCATION_DECK, 0, 2, 2, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), nil, 0)
end

function c284130813.operation(e, tp, eg, ep, ev, re, r, rp)
    local g1 = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    if g1:GetCount() > 0 then
        Duel.Hint(HINT_SELECTMSG, 1 - tp, HINTMSG_SPSUMMON)
        local g2 = g1:Select(1 - tp, 1, 1, nil)
        if g2:GetCount() > 0 then
            Duel.SpecialSummon(g2, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP_ATTACK)
            g1:Sub(g2)
            Duel.SendtoGrave(g1, REASON_EFFECT)
        end
    end
end