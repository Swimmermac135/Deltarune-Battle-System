if(image_index >= image_number - 1)
{
	if(play_once)
	{
		image_speed = 0;
		
		if(animation_ongoing)
			animation_ongoing = false;
	}
}