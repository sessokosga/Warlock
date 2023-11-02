extends Node

# this file is auto generated by GDCastledb @arlez80
# DO NOT EDIT BY MANUAL

class Warlock extends CastleDB:
	enum Type {Hero,Minion,Spell,}
	enum EffectOnActor {Help_Me,Harm_Opponent,}

	class Row:
		var id := ""
		var _unique_id_name := ""
		var title := ""
		var type := 0
		var health := 0
		var decoration := ""
		var mana := 0
		var effect_on_actor := 0
		var attack := 0
		var description := ""
		var emblem := ""
		var back := ""
		var profile := ""
		var sample := 0
		func _init(_id:String,_title:String,_type:int,_health:int,_decoration:String,_mana:int,_effect_on_actor:int,_attack:int,_description:String,_emblem:String,_back:String,_profile:String,_sample:int):
			self._unique_id_name = _id
			self.id = _id
			self.title = _title
			self.type = _type
			self.health = _health
			self.decoration = _decoration
			self.mana = _mana
			self.effect_on_actor = _effect_on_actor
			self.attack = _attack
			self.description = _description
			self.emblem = _emblem
			self.back = _back
			self.profile = _profile
			self.sample = _sample
		func _delay_set_reference( import_src ):
			pass

	func _init( ):
		self.all = [Warlock.Row.new("DeadlyStrike","Deadly Strike",2,0,"assets/images/cards/decoration_spell.png",4,1,0,tr("Kills a random ennemy card"),"assets/images/cards/emblem/emblem_2.png","assets/images/cards/backs/Alternate_2.png","assets/images/cards/profiles/Neutral_4.png",4),Warlock.Row.new("ShadowBolt","Shadow Bolt",2,0,"assets/images/cards/decoration_spell.png",1,0,0,tr("Add +1 attack to all my cards"),"assets/images/cards/emblem/emblem_2.png","assets/images/cards/backs/Alternate_3.png","assets/images/cards/profiles/Warlock_2.png",4),Warlock.Row.new("GoblinJunk","Goblin Junk",2,0,"assets/images/cards/decoration_spell.png",1,1,0,tr("Remove -1 attack to a random ennemy card"),"assets/images/cards/emblem/emblem_2.png","assets/images/cards/backs/Alternate_2.png","assets/images/cards/profiles/Neutral_2.png",4),Warlock.Row.new("Redemption","Redemption",2,0,"assets/images/cards/decoration_spell.png",5,0,0,tr("Add +2 health to a random card of mine"),"assets/images/cards/emblem/emblem_2.png","assets/images/cards/backs/minion_1.png","assets/images/cards/profiles/Paladin_2.png",4),Warlock.Row.new("DenofShadow","Den of Shadow",2,0,"assets/images/cards/decoration_spell.png",1,0,0,tr("Add +2 health to a random card of mine"),"assets/images/cards/emblem/emblem_2.png","assets/images/cards/backs/Alternate_1.png","assets/images/cards/profiles/Rogue_4.png",4),Warlock.Row.new("AbysalNexus","Abysal Nexus",2,0,"assets/images/cards/decoration_spell.png",1,1,0,tr("Remove -1 health to all ennemy cards"),"assets/images/cards/emblem/emblem_2.png","assets/images/cards/backs/Alternate_3.png","assets/images/cards/profiles/Warlock_3.png",4),Warlock.Row.new("Gladiator","Gladiator",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/Alternate_2.png","assets/images/cards/profiles/Neutral_1.png",4),Warlock.Row.new("Ambush","Ambush",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/Alternate_1.png","assets/images/cards/profiles/Rogue_3.png",4),Warlock.Row.new("Gigant","Gigant",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/Alternate_2.png","assets/images/cards/profiles/Neutral_3.png",4),Warlock.Row.new("Hammer","Hammer",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/minion_1.png","assets/images/cards/profiles/Paladin_3.png",4),Warlock.Row.new("Retributor","Retributor",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/minion_1.png","assets/images/cards/profiles/Paladin_4.png",4),Warlock.Row.new("Nimble","Nimble",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/Alternate_1.png","assets/images/cards/profiles/Rogue_1.png",4),Warlock.Row.new("Sneak","Sneaker",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/Alternate_1.png","assets/images/cards/profiles/Rogue_2.png",4),Warlock.Row.new("Summoner","Summoner",1,4,"assets/images/cards/decoration_minion.png",1,0,1,"","assets/images/cards/emblem/emblem_4.png","assets/images/cards/backs/Alternate_3.png","assets/images/cards/profiles/Warlock_1.png",4),Warlock.Row.new("DemonicBargain","Demonic Bargain",0,0,"assets/images/cards/decoration_hero.png",0,0,1,"","assets/images/cards/emblem/emblem_1.png","assets/images/cards/backs/Alternate_3.png","assets/images/cards/profiles/hero_2.png",4),Warlock.Row.new("RadiantCrusader","Radiant Crusader",0,0,"assets/images/cards/decoration_hero.png",0,0,1,"","assets/images/cards/emblem/emblem_1.png","assets/images/cards/backs/minion_1.png","assets/images/cards/profiles/hero_1.png",4)]
		self._generate_keys( )

	func get_value( id:String ) -> Warlock.Row:
		if self.keys.has( id ):
			return self.all[self.keys[id]]
		return null

	func get_index( id:String ) -> int:
		if self.keys.has( id ):
			return self.keys[id]
		return -1

var table_warlock: = Warlock.new( )

func _init( ):
	self.table_warlock._delay_set_reference( self )
