class_name HasManaForSpell extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("has_mana_for_spell").call():
        return SUCCESS
    else:
        return FAILURE
