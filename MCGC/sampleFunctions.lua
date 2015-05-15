-- 通用性函数
--[[
    name    type        whole_name      description
    -------------------------------------------------------
    e       Effect      Effect          该效果本身
    tp      PLAYER_     This Player     发动效果的玩家
    eg      Group       Event Group     事件/时点涉及的卡片组
    ep      PLAYER_     Event Player    事件/时点涉及的玩家
    ev      int         Event Value     事件/时点的参数值
    re      Effect      Reason Effect   因……效果
    r       REASON_     Reason          因……原因
    rp      PLAYER_     Reason Player   因……玩家
]]

-- Operation
function common_operation(e, tp, eg, ep, ev, re, r, rp)
    -- 不返回值
end

-- Value
--[[
    name    type        whole_name      description
    -------------------------------------------------------
    e       Effect      Effect          该效果本身
    re      Effect      Reason Effect   因……效果
    val     int         Value           相关数值
    r       REASON_     Reason          因……原因
    rp      PLAYER_     Reason Player   因……玩家
    rc      Card        Reason Card     因……卡片
]]
function common_value(e, re, val, r, rp, rc)
    -- 已知用于EFFECT_CHANGE_DAMAGE
    -- 返回value值
end

-- 触发型效果用函数
--[[
    name    type        whole_name      description
    -------------------------------------------------------
    chk     bool        Check           0为进行检查，1为不检查
    chkc    Card        Check Card      判断是否满足对象要求
]]

-- Condition
function trigger_condition(e, tp, eg, ep, ev, re, r, rp)
    -- 返回布尔值
end

-- Cost
function trigger_cost(e, tp, eg, ep, ev, re, r, rp, chk)
    -- chk == 0时返回布尔值，否则不返回值
end

-- Target
function trigger_target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    -- chk == 0时返回布尔值，否则不返回值
end

-- 永续型效果用函数
--[[
    name    type        whole_name      description
    -------------------------------------------------------
    c       Card        Card            要检查的卡片
    g       Group       Group           要检查的卡片组，与gc成对出现
    gc      int         Group Count     要检查的卡片组中的数目
    te      Effect      Test Effect     要检查的效果
]]

-- Condition
function influence_condition1(e, c)
end

function influence_condition2(e, g, gc)
end

-- Cost
function influence_cost1(e, te, tp)
end

function influence_cost2(e, c, tp)
end

-- Target
function influence_target1(e, te, tp)
end

function influence_target2(e, c, tp)
end