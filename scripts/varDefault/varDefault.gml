function varWithDefault(_input) constructor {
	
	_var     = _input;
	_default = _input;
	
	static get = function()
	{
		return _var;	
	}
	
	static set = function(_i)
	{
		_var = _i;	
	}
	
	static reset = function()
	{
		_var = _default;	
	}
	
	static newDefault = function(_newDefault)
	{
		//Kind of defeats the point
		_default = _newDefault;	
	}
}