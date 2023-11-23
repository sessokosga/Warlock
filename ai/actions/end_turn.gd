class_name EndTurn extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    blackboard.get_value("end_turn").call()
    return SUCCESS

