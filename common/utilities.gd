extends Node
func card_type_string(id:int)->String:
	match id:
		CardData.Warlock.Type.Minion:
			return tr("Minion")
		CardData.Warlock.Type.Spell:
			return tr("Spell")
		CardData.Warlock.Type.Hero:
			return tr("Hero")
		_:
			return ""
			
			
		
	
