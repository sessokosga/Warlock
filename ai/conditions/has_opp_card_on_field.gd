class_name HasOppCardOnField extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("has_opp_card_on_field").call():
        return SUCCESS
    else:
        return FAILURE
