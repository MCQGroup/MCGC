-- MC群的战士 节操

function c284130833.initial_effect(c)
    -- 一回合只使用一次
    -- 召唤触发抉择
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DRAW)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetCost(c284130833.cost)
    e1:SetOperation(c284130833.operation)
    e1:SetCountLimit(1, 284130833)
    c:RegisterEffect(e1)
end

function c284130833.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsAbleToDeck, tp, LOCATION_HAND, 0, 1, nil)
    end
    local max_val = Duel.GetLocationCount(tp, LOCATION_HAND)
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToDeck, tp, LOCATION_HAND, 0, 1, max_val, nil)
    local sel = Duel.SelectOption(tp, aux.Stringid(284130833, 0), aux.Stringid(284130833, 1))
    Duel.SetOperationInfo(0x2222, 284130833, nil, g:GetCount(), nil, sel)
    Dual.SendtoDeck(g, nil, 2, REASON_COST)
end

function c284130833.operation(e, tp, eg, ep, ev, re, r, rp)
    local test, g, count, p, sel = Duel.GetOperationInfo(0x2222, 284130833)
    if test then
        if sel == 0 then
            if e:GetHandler():IsLocation(LOCATION_MZONE) then
                Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, count + 1)
                Duel.Draw(tp, count + 1, REASON_EFFECT)
                Duel.SetOperationInfo(0, CATEGORY_TOGRAVE, e:GetHandler(), 1, nil, 0)
                Duel.SendtoGrave(e:GetHandler(), REASON_EFFECT)
            end
        elseif sel == 1 then
            Duel.SetOperationInfo(0, CATEGORY_DRAW, nil, 0, tp, count - 1)
            Duel.Draw(tp, count - 1, REASON_EFFECT)
            g = Duel.SelectMatchingCard(tp, Card.IsDestructable, tp, 0, LOCATION_ONFIELD, 1, 1, nil)
            Duel.SetOperationInfo(0, CATEGORY_DESTROY, g, g:GetCount(), nil, 0)
            Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
        end
    end
end