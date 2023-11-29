class_name Waait extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
	if blackboard.get_value("wait").call():
		return SUCCESS
	else:
		return FAILURE
