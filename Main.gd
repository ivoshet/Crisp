extends Node
export (PackedScene) var mob_scene
var score

func _ready():
	randomize()
	new_game()

func new_game():
	score = 0 
	get_node("Player").start(get_node("StartPosition").position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

func game_over():
	$ScoreTimer.stop()
	$ModTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathMusic.play()
	
func _on_ModTimer_timeout():
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	var mob = mob_scene.instance()
	add_child(mob)
	
	var direction = mob_spawn_location.rotation + PI/2
	mob.position = mob_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(rand_range(150, 250),0)
	mob.linear_velocity = velocity.rotated(direction)
	
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	
func _on_StartTimer_timeout():
	$ModTimer.start()
	$ScoreTimer.start()
	
