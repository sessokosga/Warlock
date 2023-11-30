class_name HasManaForMinion extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("has_mana_for_minion").call():
        return SUCCESS
    else:
        return FAILURE

