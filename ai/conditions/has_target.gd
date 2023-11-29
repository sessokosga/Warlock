class_name HasTarget extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
	if blackboard.get_value("has_target").call():
		return SUCCESS
	else:
		return FAILURE
