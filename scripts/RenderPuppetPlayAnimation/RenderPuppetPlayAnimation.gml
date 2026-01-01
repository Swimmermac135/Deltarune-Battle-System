function RenderPuppetPlayAnimation(_renderPuppet, _animation, _imageSpeed = 1, _playOnce = false, _interrupt = true){
	
	if(_interrupt || (!_interrupt && _renderPuppet.animation_ongoing == false))
	{
		_renderPuppet.animation_ongoing = true;
		_renderPuppet.image_speed	    = _imageSpeed;
		_renderPuppet.play_once		    = _playOnce;
		_renderPuppet.sprite_index	    = _animation;
		_renderPuppet.image_index	    = 0; // This line of code here took way too much debugging. I dont know why not having this causes animations to start fully complete randomly
		_renderPuppet.currently_playing = _animation;
	}
	
}