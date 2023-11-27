class_name PickMinion extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("pick_minion").call():
        return SUCCESS
    else:
        return FAILURE


