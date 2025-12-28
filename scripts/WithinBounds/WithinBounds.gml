function WithinBounds(_val, _lowerLimit, _upperLimit, _inclusive = true){
	
	if(_inclusive)
	{
		if(_val >= _lowerLimit && _val <= _upperLimit)
			return true;
	}
	
	if(!_inclusive)
	{
		if(_val > _lowerLimit && _val < _upperLimit)
			return true;
	}
	
	return false;
}