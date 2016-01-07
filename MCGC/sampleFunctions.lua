-- 通用性函数
--[[
    name    type        whole_name      description
    -------------------------------------------------------
    e       Effect      Effect              该效果本身
    tp      PLAYER_     This Player         发动效果的玩家
    eg      Group       Event Group         事件/时点涉及的卡片组
    ep      PLAYER_     Event Player        事件/时点涉及的玩家
    ev      int         Event Value         事件/时点的参数值
    re      Effect      Reason Effect       因……效果
    r       REASON_     Reason              因……原因
    rp      PLAYER_     Reason Player       因……玩家

    gc      Card        Group Card          融合材料所涉及的卡片
    chkf    PLAYER_     Check Player        似乎用于强制检测该怪兽是否属于某个玩家

    c       Card        Card                将要被特殊召唤的卡片

    syncard Card        Synchro Card        将要被同调召唤的卡片
    f       function    Function            卡片过滤函数
    minc    int         Min Count           最小数量
    maxc    int         Max Count           最大数量

    smat    Card        Synchro Material    同调召唤所用的素材
    mg      Group       Material Group      同调召唤的素材卡片组
]]

-- Operation
function common_operation(e, tp, eg, ep, ev, re, r, rp)
    -- 不返回值
end

function common_operation2(e, tp, eg, ep, ev, re, r, rp, gc, chkf)
    -- 已知用于EFFECT_FUSION_MATERIAL
end

function common_operation3(e, tp, eg, ep, ev, re, r, rp, c)
    -- 已知用于EFFECT_SPSUMMON_PROC
end

function common_operation4(e, tp, eg, ep, ev, re, r, rp, syncard, f, minc, maxc)
    -- 已知用于EFFECT_SYNCHRO_MATERIAL_CUSTOM
end


function common_operation5(e, tp, eg, ep, ev, re, r, rp, c, smat, mg)
    -- 已知用于同调召唤的EFFECT_SPSUMMON_PROC
end

-- Value
--[[
    name    type            whole_name      description
    -------------------------------------------------------
    e       Effect          Effect          该效果本身
    re      Effect          Reason Effect   因……效果
    val     int             Value           相关数值
    r       REASON_         Reason          因……原因
    rp      PLAYER_         Reason Player   因……玩家
    rc      Card            Reason Card     因……卡片

    c       Card            Card            效果所属/需要判断的卡片

    se      Effect          Summon Effect   进行召唤的效果（？）
    sp      PLAYER_         Summon Player   进行召唤的玩家
    st      SUMMON_TYPE_    Summon Type     召唤类型

    tp      PLAYER_         Target Player   发动效果的玩家
]]
function common_value1(e, re, val, r, rp, rc)
    -- 已知用于EFFECT_CHANGE_DAMAGE
    -- 返回value值
end

function common_value2(e, c)
    -- 已知用于EFFECT_UPDATE_ATTACK, EFFECT_UPDATE_DEFENSE, EFFECT_SPSUMMON_PROC, EFFECT_CANNOT_SELECT_BATTLE_TARGET
end

function common_value3(e, se, sp, st)
    -- 已知用于EFFECT_SPSUMMON_CONDITION
end

function common_value4(e, re, tp)
    -- 已知用于EFFECT_CANNOT_ACTIVATE, EFFECT_INDESTRUCTABLE_EFFECT
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
    e       Effect      Effect              该效果本身
    c       Card        Card                要检查的卡片
    g       Group       Group               要检查的卡片组，与gc成对出现
    gc      int         Group Count         要检查的卡片组中的数目
    te      Effect      Test Effect         要检查的效果

    syncard Card        Synchro Card        将要被同调召唤的卡片
    f       function    Function            卡片过滤函数
    minc    int         Min Count           最小数量
    maxc    int         Max Count           最大数量

    smat    Card        Synchro Material    同调召唤所用的调整怪兽
    mg      Group       Material Group      同调召唤的素材卡片组
]]

-- Condition
function influence_condition1(e, c)
end

function influence_condition2(e, g, gc)
end

function influence_condition3(e, c, smat, mg)
    -- 已知用于EFFECT_SPSUMMON_PROC
    if c == nil then
        return true
    end
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

function influence_target3(e, syncard, f, minc, maxc)
    -- 已知用于EFFECT_SYNCHRO_MATERIAL_CUSTOM
end

function influence_target4(e, tp, eg, ep, ev, re, r, rp, chk, chkc, smat, mg)
    -- 已知用于EFFECT_SPSUMMON_PROC
end