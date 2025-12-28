function slerp(_val1, _val2, _smoothness, _lowerLimit, _upperLimit, _inclusive = true){
	
	// It means "Snap Lerp"
	if(WithinBounds(_val1, _val2 - _lowerLimit, _val2 + _upperLimit, _inclusive))
		return _val2;
	else return lerp(_val1, _val2, _smoothness);
	
}