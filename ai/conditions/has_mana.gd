class_name HasMana extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("has_mana").call():
        return SUCCESS
    else:
        return FAILURE

