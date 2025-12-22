/// @description Set up camera variables and default viewheight and witdth

// Object should be invisible
//visible = false;
//persistent = true;


// Variable setup
//object_following = undefined;

// Camera setup

view_width  = 640; // The dimensions of the viewport should remain constant regardless of screen size
view_height = 480; // This stops bigger monitors from seeing farther

window_width  = 1280;
window_height = 960;

window_set_size(window_width , window_height);
alarm[0] = 1;

surface_resize(application_surface, view_width, view_height); // Sets the camera VIEW SIZE, not the GAME WINDOW SIZE