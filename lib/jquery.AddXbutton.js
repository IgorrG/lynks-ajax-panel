(function($) {
    $.fn.AddXbutton = function(options) {
        var defaults = {
            img: 'x.gif'//расположение картинки крестика по-умолчанию (относительно страницы, на которой находится инпут)
        };
        var opts = $.extend(defaults, options);
        $(this)
        .after($('<input type="image" id="xButton" src="' + opts['img'] + '" />') //после текстового инпута вставляем image-input
                    .css({ 'display': 'none', 'cursor': 'pointer', 'marginLeft': '-15px' })// делаем его стильным
                    .click(function() { //вешаем обработчик на клик
                        $('#searchInput').val('').focus(); 
                        $('#xButton').hide();
                    }))
        .keyup(function() { //на кейап мы проверяем, показывать нам крестик или нет
            if ($(this).val().length > 0) {
                $('#xButton').show(); //если текст какой-нибудь есть, но показываем
            } else {
                $('#xButton').hide(); 
            }
        });
        if ($(this).val() != '') $('#xButton').show(); //если при загрузке страницы в текстовом поле что-то есть, крестик надо сразу показать (например, при обновлении страницы)
    };
})(jQuery);