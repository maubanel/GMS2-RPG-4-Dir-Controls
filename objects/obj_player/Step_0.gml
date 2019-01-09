/// @description Player AI

//Variables to hold x & y axis
var x_axis = 0;
var y_axis = 0;

// Keyboard controls
// Moving only up | down | left | right NO DIAGONALS

if ((keyboard_lastkey = vk_left && keyboard_check(vk_left)) 
	|| (keyboard_lastkey=vk_right && keyboard_check(vk_right)))
{
	x_axis = keyboard_check(vk_right) - keyboard_check(vk_left);
}	

else if ((keyboard_lastkey=vk_up && keyboard_check(vk_up))
		|| (keyboard_lastkey=vk_down && keyboard_check(vk_down)))
{
	y_axis = keyboard_check(vk_down) - keyboard_check(vk_up);	
}

//This is to catch a key when you have two pressed and release one

else if (keyboard_check(vk_left) || keyboard_check(vk_right))
{
	x_axis = keyboard_check(vk_right) - keyboard_check(vk_left);
}

else if (keyboard_check(vk_up) || keyboard_check(vk_down))
{
	y_axis = keyboard_check(vk_down) - keyboard_check(vk_up);	
}

//Joystick controls
if (x_axis == 0 && y_axis == 0)
{
	//Get joystick axis values
	x_axis= gamepad_axis_value(global.gamepad[0], gp_axislh);
	y_axis = gamepad_axis_value(global.gamepad[0], gp_axislv);
	
	if (x_axis != 0 && y_axis != 0) //Make sure joystick is not centered
	{
		
		//Get angle
		var joystick_dir = point_direction(0, 0, x_axis, y_axis);

	//Force only 4 angles regardless of where the player has positioned the joystick
		//Player moves right
		if ( (joystick_dir >= 0 && joystick_dir < 45) || 
			joystick_dir <= 360 && joystick_dir >= 315)
		{
			x_axis = 1;
			y_axis = 0;
		}
	
		//Player moves left
		if ((joystick_dir >= 135 && joystick_dir < 225))
		{
			x_axis = -1;
			y_axis = 0;
		}
	
		//Player moves up
		if ((joystick_dir >= 45 && joystick_dir < 135))
		{
			x_axis = 0;
			y_axis = -1;
		}
	
		//Player moves down
		if ((joystick_dir >= 225 && joystick_dir < 315))
		{
			x_axis = 0;
			y_axis = 1;
		}
	}
}


//Move player on x or y axis
if (x_axis != 0 || y_axis != 0) //Check that there is input
{
	//Move player multiplying by fraction of a second gets us frame time
	x += x_axis * player_speed * (delta_time/1000000);
	y += y_axis * player_speed * (delta_time/1000000);
}

//Select correct animation frame
if (x_axis > 0)
{
	image_xscale = 1;
	sprite_index = spr_player_right;	
}
else if (x_axis < 0)
{
	image_xscale = -1;
	sprite_index = spr_player_right;	
}
else if (y_axis > 0)
{
	sprite_index = spr_player_down;	
}
else if (y_axis < 0)
{
	sprite_index = spr_player_up;	
}

//Pick appropriate idle animation if no movement
else
{
	if (sprite_index == spr_player_up)
	{
		sprite_index = spr_player_up_idle;	
	}
	else if (sprite_index == spr_player_right)
	{
		sprite_index = spr_player_right_idle;
	}
	else if (sprite_index == spr_player_down)
	{
		sprite_index = spr_player_down_idle;
	}
}
