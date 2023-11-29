class_name IsWaiting extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
	if blackboard.get_value("is_waiting").call():
		return SUCCESS
	else:
		return FAILURE
