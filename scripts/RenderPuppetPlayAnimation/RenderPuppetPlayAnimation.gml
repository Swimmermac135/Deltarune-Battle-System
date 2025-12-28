function RenderPuppetPlayAnimation(_renderPuppet, _animation, _imageSpeed = 1, _playOnce = false){
	
	_renderPuppet.animation_ongoing = true;
	_renderPuppet.image_speed	    = _imageSpeed;
	_renderPuppet.play_once		    = _playOnce;
	_renderPuppet.sprite_index	    = _animation;
	_renderPuppet.currently_playing = _animation;
	
}