class_name PickSpell extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("pick_spell").call():
        return SUCCESS
    else:
        return FAILURE

