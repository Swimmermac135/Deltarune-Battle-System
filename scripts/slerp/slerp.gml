function slerp(_val1, _val2, _smoothness, _tolerance, _inclusive = true){
	
	// It means "Snap Lerp"
	if(WithinBounds(_val1, _val2 - _tolerance, _val2 + _tolerance, _inclusive))
		return _val2;
	else return lerp(_val1, _val2, _smoothness);
	
}