class_name TargetHero extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("target_hero").call():
        return SUCCESS
    else:
        return FAILURE
