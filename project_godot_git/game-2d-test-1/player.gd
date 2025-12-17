extends Area2D
#extends Sprite2D

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	

func _process(delta):
	var direction := Vector2(
		Input.get_axis("ui_left","ui_right"),
		Input.get_axis("ui_up","ui_down"),
	)
	
	if direction.length() > 0:
		#归一化向量，保证斜向移动速度一致
		direction = direction.normalized()
	
		##尝试使用八方锁定
		## 1. 计算原始的移动方向角度（弧度）
		#var angle = direction.angle()+ deg_to_rad(90)
		##默认初始方向向右为0度，旋转90度修正初始方向
		#
		## 2. 定义“锁定的档位”大小：45度（PI/4 弧度）
		#var snap_step =	PI / 4
		#
		## 3. 核心锁定计算：
	##    a) angle / snap_step: 将原始角度转换为“档位”的倍数（可能是小数）
	##    b) round(...): 四舍五入到最接近的整数倍
	##    c) ... * snap_step: 将整数倍的“档位”重新转换回弧度值
		#var snapped_angle = round(angle / snap_step) * snap_step
		#
		## 4. 应用锁定后的角度
		#rotation = snapped_angle
		
		# 继续移动逻辑
		position += direction * speed * delta
		
		#限制移动范围（屏幕内）
		#clamp(value,min,max)
		var margin_x = 28
		var margin_y = 34
		position.x = clamp(position.x,margin_x,screen_size.x - margin_x)
		position.y = clamp(position.y,margin_y,screen_size.y - margin_y)	
		
		if direction.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = direction.x < 0
		elif direction.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_h = direction.y > 0
		
