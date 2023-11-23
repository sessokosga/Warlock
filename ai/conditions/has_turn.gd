class_name HasTurn extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("has_turn").call():
        return SUCCESS
    else:
        return FAILURE
