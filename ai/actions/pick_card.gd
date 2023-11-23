class_name PickCard extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("pick_card").call():
        return SUCCESS
    else:
        return FAILURE
