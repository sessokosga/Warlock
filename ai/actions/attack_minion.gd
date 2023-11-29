class_name AttackMinion extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("attack_minion").call():
        return SUCCESS
    else:
        return FAILURE