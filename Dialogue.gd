extends Control

export (bool) var show_on_ready

var person1
var person2

var person1_dialogue
var person2_dialogue

var dialogue_index = 0
var max_person1_index
var max_person2_index

func _ready():
	self.show()
	set_dialogue()
	max_person1_index = len(person1_dialogue) - 1
	max_person2_index = len(person2_dialogue) - 1
	person1 = person1 + ": "
	person2 = person2 + ": "
	$Person1Text.text = person1 + person1_dialogue[dialogue_index]



func _process(delta):
	if self.is_visible():
		Global.dialogue_playing = true
	else:
		Global.dialogue_playing = false
	if self.is_visible() and Input.is_action_just_pressed("interact"):
		if $Person2Text.text == "":
			if dialogue_index <= max_person2_index:
				$Person2Text.text = person2 + person2_dialogue[dialogue_index]
			else:
				return_to_scene()
		
		else:
			dialogue_index += 1
			if dialogue_index <= max_person1_index:
				$Person2Text.text = ""
				$Person1Text.text = person1 + person1_dialogue[dialogue_index]
			else:
				return_to_scene()

func set_dialogue():
	match Global.dialogue_to_play:
		"Raskolnikov":
			person1 = "Raskolnikov"
			person2 = "Raskolnikov"
			person1_dialogue = ["The heat in the street is terrible: and the airlessness, the bustle and the plaster, scaffolding, bricks and dust all flying about. And that stench, how it tears at my every nerve", "Hate it? Why no! Petersburg is the home of my beloved, my Sonia.", "A miserable place? How can it be miserable? Sonia and Mama and Dounia, they're all here, how can it be miserable if they're all here?", "Why, honoured sir, must I worry for roubles? The ceiling is high enough for my head and my trousers fit my waist, is that not enough to be content? What more could I need?", "What will I do? Why, I am soon to become a lawyer. Do you believe I haven't the ability to complete my studies?", "Why Razumihin, he runs a publishing company. I work with him. It does not take an extraordinary man to complete my duties", "Why must I take on such weight of suffering? That is the duty of god. God will guide men and men will follow. All is as it should be"]
			person2_dialogue = ["So you must hate it here?", "You simplistic fool! This is a miserable place, how can you be so mad as to say it is not!", "Why because THEY are miserable! Look at the ceiling of this pathetic chamber you call a home! I could reach up and grab hold of it! You haven't the roubles for a pair of trousers, how can it not be miserable here!", "How long are you to live in such a manner? Soon the ceiling will fall and your trousers will tear, what will you do then?", "Studies? But how? How does an ordinary man like you fund his studies?", "But does it not weigh on you? The gloom of it all. The suffering of the people. The filthy Svidrigailovs who hunt the weak, and the cowards who beat their horses to death, all because they can, because they have the power to."]
		"Sonia":
			person1 = "Sonia"
			person2 = "Raskolnikov"
			person1_dialogue = ["He will pity us Who has had pity on all men, Who has understood all men and all things, He is the One, He too is the judge. He will come in that day and He will ask: 'Where is the mother who gave all she had for the good of her children, and the father who-", "raised his sons to have pity on the poor' And He will say, 'Come to me! I have already forgiven thee once. . . . I have forgiven thee once. . . . Thy sins which are many are forgiven thee for thou hast loved much. . . .' And He will forgive them all, I know it!", "How can you say that?", "But I have told you! He will forgive them! Those who have suffered will be forgiven!"]
			person2_dialogue = ["Stop it! I cannot bear to hear mor- ", "There is no God!", "If there was such a God you would not have a yellow ticket, your father would not have fallen under the feet of horses, your mother would be alive, not dead of consumption!"]
		"Razumihin":
			person1 = "Razumikhin"
			person2 = "Raskolnikov"
			person1_dialogue = ["If one looks at men in all ways- are there many good ones left? Why, I am sure I shouldn't be worth a baked onion myself!", "Who is to judge those actions, to say one is good and the other bad?"]
			person2_dialogue = ["But is it not the actions that make the man?"]
		"Dounia":
			person1 = "Dounia"
			person2 = "Raskolnikov"
			person1_dialogue = ["Pyotr Petrovich was a mean and spiteful man. A true contemptible slanderer and a base fool.", "And was I wrong to? Rodya's happiness was our happiness. Was I wrong to seek happiness?", "Do you mean to accuse me of carelessness? Is it not the act of the extraordinary to give themselves up for the good of their brethren?", "But why must it be that way? If the extraordinary cannot go without murder then they are not extraordinary at all!"]
			person2_dialogue = ["And yet you meant to marry him, simply for the good of your brother.", "You lie to yourself. You meant to sacrifice all you have, not gain happiness. Have you no respect for your own self?", "The extraordinary do not sacrifice!"]
		"Porfiry":
			person1 = "Porfiry"
			person2 = "Raskolnikov"
			person1_dialogue = ["If society is normally organised, all crime will cease at once, since there will be nothing to protest against and all men will become righteous in one instant. All crime may be ascribed to the influence of environment.", "There will be men who change our society with new thought and philosophy.", "Murder for what? If a man need murder to change society than he is not a man at all! The men I speak of need not murder, no!"]
			person2_dialogue = ["How can society become normally organised?", "Have they the right to murder if it is for the cause of furthering their thought and philosophy on society?"]
		"Zametov":
			person1 = "Zametov"
			person2 = "Raskolnikov"
			person1_dialogue = ["A man will commit a clever murder at the risk of his life and then at once he goes drinking in a tavern. They are caught spending money, they are not all cunning!", "A fool indeed."]
			person2_dialogue = ["Surely if a man did do such an act he would be nothing more than a fool!"]

func return_to_scene():
	Global.dialogue_playing = false
	Global.return_from_dialogue = true
	match Global.return_scene:
		"RaskolnikovHouse":
			Global.camera_clamps = Vector3(0,224,75)
			Global.camera_zoom_position = [0.7, 0.8, 2, -33]
			get_tree().change_scene("res://RaskolnikovHouse.tscn")
		"PalaisDeCristal":
			Global.camera_clamps = Vector3(0, 624, -25)
			Global.camera_zoom_position = [1.3, 1.4, 2, -82]
			get_tree().change_scene("res://PalaisDeCristal.tscn")
		"RazumihinHouse":
			Global.camera_clamps = Vector3(0,416,-25)
			Global.camera_zoom_position = [1.3, 1.4, 2, -82]
			get_tree().change_scene("res://RazumihinHouse.tscn")
		"PoliceStation":
			Global.camera_clamps = Vector3(0, 480, -25)
			Global.camera_zoom_position = [1.3, 1.4, 2, -82]
			get_tree().change_scene("res://PoliceStation.tscn")
		"Pawnshop":
			Global.camera_clamps = Vector3(0, 416, -25)
			Global.camera_zoom_position = [1.3, 1.4, 2, -82]
			get_tree().change_scene("res://AlyonaHouse.tscn")
		"MarmeladovHouse":
			Global.camera_clamps = Vector3(0, 448, 55)
			Global.camera_zoom_position = [0.9, 1, 2, -71]
			get_tree().change_scene("res://MarmeladovHouse.tscn")
