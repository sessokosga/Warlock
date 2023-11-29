class_name TargetMinion extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("target_minion").call():
        return SUCCESS
    else:
        return FAILURE
