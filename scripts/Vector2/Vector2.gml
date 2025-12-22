function Vector2(_x = 0, _y = 0) constructor 
{
	// I dont want to use arrays for storing coordinates so I am going to use a struct since coordinate.x looks better than coordinate[0]
	x = _x;
	y = _y;
}