function DrawActionIcons(_CharaToDrawIconsFor, _IsCharaCurrentlyTheOneSelecting, _charaPanelAnchorX){
	
	var _currentEntry      = _CharaToDrawIconsFor.CharaData;
	var _ActionIconOffset  = (sprite_get_width(spr_BattleRoom_ActionButtonIcon_Item) + action_button_padding.x);
	//var _charaPanelAnchorY = _currentEntry.characterPanelCurrentDrawY;
	
	for (var _currentlyDrawnActionIcon = 0; _currentlyDrawnActionIcon < array_length(_CharaToDrawIconsFor.myActionOptions); _currentlyDrawnActionIcon++) 
	{
		var _currentDrawOffset = _currentlyDrawnActionIcon - 2;
		var _currentlyHoveredInList = _CharaToDrawIconsFor.myActionOptions[currently_hovered_action];
				
		switch(_CharaToDrawIconsFor.myActionOptions[_currentlyDrawnActionIcon])
		{
			case ACTION.ATTACK:
				if(_IsCharaCurrentlyTheOneSelecting && _currentlyHoveredInList == ACTION.ATTACK)
					draw_sprite(_currentEntry.characterActionIconAttack[1], 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconAttack[0], 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			break;
			
			case ACTION.MAGIC: // Change this later to seperate magic and act
				if(_IsCharaCurrentlyTheOneSelecting && _currentlyHoveredInList == ACTION.MAGIC)
					draw_sprite(_currentEntry.characterActionIconMagic[1],   0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconMagic[0],   0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			break;
			
			case ACTION.ACT: // Change this later to seperate magic and act
				if(_IsCharaCurrentlyTheOneSelecting && _currentlyHoveredInList == ACTION.ACT)
					draw_sprite(_currentEntry.characterActionIconAct[1], 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconAct[0], 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			break;
			
			case ACTION.ITEM:
				if(_IsCharaCurrentlyTheOneSelecting && _currentlyHoveredInList == ACTION.ITEM)
					draw_sprite(_currentEntry.characterActionIconItem[1]  , 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconItem[0]  , 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
					
			break;
			
			case ACTION.SPARE:
				if(_IsCharaCurrentlyTheOneSelecting && _currentlyHoveredInList == ACTION.SPARE)
					draw_sprite(_currentEntry.characterActionIconSpare[1] , 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconSpare[0] , 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			break;
			
			case ACTION.DEFEND:
				if(_IsCharaCurrentlyTheOneSelecting && _currentlyHoveredInList == ACTION.DEFEND)
					draw_sprite(_currentEntry.characterActionIconDefend[1], 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
				else
					draw_sprite(_currentEntry.characterActionIconDefend[0] , 0, _charaPanelAnchorX + _ActionIconOffset * _currentDrawOffset, mainmenu_charapanel_closed_y + action_button_padding.y);
			break;
		}
		
	}
	
}