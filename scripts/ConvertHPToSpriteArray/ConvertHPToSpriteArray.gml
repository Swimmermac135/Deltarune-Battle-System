function ConvertHPToSpriteArray(_input){
	
	var _spriteArray = [];
		
	for (var i = abs(_input); i > 0; i = floor(i / 10)) {
	    array_push(_spriteArray, ReturnSpriteForNumber((i mod 10)));
	}
	
	// Add negative sign to the array 
	if(sign(_input) == -1)
		array_push(_spriteArray, spr_HPNumber_NegativeSign);
	
	// When making this, I did not expect it to read the sprites out backwards, though in hindsight
	// the for loop doing that makes a lot of sense. Thankfully all it took was array_reverse and
	// adding the negative sign after the numbers are read out to fix it. This could have definitely been done better, but it works.
	
	// Reversing it is also silly since the rendering code reads it backwards anyways
	return array_reverse(_spriteArray);
}

// I had a much more elegant solution for drawing these but I changed my mind mid development. 
function ReturnSpriteForNumber(_num) {
	
	switch (_num)
	{
		case 0:
			return spr_HPNumbers_0;
		break;
		case 1:
			return spr_HPNumbers_1;
		break;
		case 2:
			return spr_HPNumbers_2;
		break;
		case 3:
			return spr_HPNumbers_3;
		break;
		case 4:
			return spr_HPNumbers_4;
		break;
		case 5:
			return spr_HPNumbers_5;
		break;
		case 6:
			return spr_HPNumbers_6;
		break;
		case 7:
			return spr_HPNumbers_7;
		break;
		case 8:
			return spr_HPNumbers_8;
		break;
		case 9:
			return spr_HPNumbers_9;
		break;
	}
	
}