class_name AttackHero extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("attack_hero").call():
        return SUCCESS
    else:
        return FAILURE
