function ShowDebugMessageExt(_orgin, _message, _log = false){
	
	if(global.DebugMode)
	{
		var _messageStringCleaned = string(_message);
		var _orginStringCleaned   = $"[{string(_orgin)}]";
		
		// Write logging to file function here later
		show_debug_message($"[{current_time}] | {_orginStringCleaned} : {_messageStringCleaned}");
	}

}