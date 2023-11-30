class_name IsGamePlaying extends ConditionLeaf

func tick(actor:Node, blackboard:Blackboard)->int:
    if blackboard.get_value("is_game_playing").call():
        return SUCCESS
    else:
        return FAILURE
