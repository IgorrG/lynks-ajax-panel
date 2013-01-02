/**
 * Twitty Drop Down Menu
 * v0.1 requires jQuery v1.2 or later
 * Copyright 2010 xandeadx [http://xandeadx.ru]
 */
 
jQuery.fn.twittymenu = function(){

	return this.each(function(i){
	
		var $ul = jQuery(this);
		var $button = jQuery('<button id="twittyButton-' + i + '" class="twittyButton"><b></b>' + this.title + '<i></i></button>').insertBefore($ul);
	
		$ul.attr('title', '').attr('id', 'twittyMenu-' + i);
		
		if (!$ul.hasClass('twittyMenu'))
		{
			$ul.addClass('twittyMenu');
		}
		
		$button.click(function(){
                        var buttonPosition = $button.position();
                        var buttonRealHeight = $button.height() + parseInt($button.css('padding-top')) + parseInt($button.css('padding-bottom')) + parseInt($button.css('border-top-width'))*2;
                        jQuery('.twittyMenu').css('z-index','100');
			// закрываем открытые меню
			jQuery('.twittyButton:not(#twittyButton-' + i + ')').removeClass('clicked');
			jQuery('.twittyMenu:not(#twittyMenu-' + i + ')').removeClass('open');
			
			$ul.css({
				'top': (buttonPosition.top + (buttonRealHeight + 3)) + 'px',
				'left': buttonPosition.left + 'px'
			});
			
			$button.addClass('clicked');
			$ul.addClass('open');
			return false;

		});
		
	});

};

// закрываем открытые меню
jQuery(document).click(function(e){

	if (jQuery(e.target).parents('.twittyMenu').size() == 0)
	{
		jQuery('.twittyButton').removeClass('clicked');
		jQuery('.twittyMenu').removeClass('open');
	}

});

