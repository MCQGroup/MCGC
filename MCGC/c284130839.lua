-- MC群服务器OP 无情

function c284130839.initial_effect(c)
    -- 同调召唤
    c:EnableReviveLimit()
    aux.AddSynchroProcedure(c, c284130839.filter, c284130839.filter, 1)

    -- 同调召唤成功触发
    -- 战破触发
    -- 结束阶段必定发动
    -- 因效果破坏必定发动
end	

function c284130839.filter(c)
    return c:IsSetCard(0x2222)
end