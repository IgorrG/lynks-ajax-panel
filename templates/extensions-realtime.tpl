<script type="text/javascript" src="lib/jquery.js"></script>
<script type="text/javascript" src="lib/jquery.md5.js"></script>
<link rel="stylesheet" type="text/css" href="lib/jquery.twittyDropDownMenu.css" />
<script type="text/javascript" src="lib/jquery.twittyDropDownMenu.js"></script>
<script type="text/javascript" src="lib/jquery-ui.js"></script> 
<link type="text/css" href="lib/smoothness/jquery-ui-1.8.custom.css" rel="stylesheet" />
<script type="text/javascript" src="lib/jquery.cookie.js"></script> 	
<script type="text/javascript" src="lib/jquery.jframe.js"></script> 	
<title>AJAX Operator Panel for TrixBox</title> 
<style type="text/css">
body {
  font-family:Arial;
  font-size: 12px;
  padding: 0px; 
  margin:0px;
}
ui-draggable
{
  cursor: move;
}
div.reg0,
div.reg0:hover,
div.reg4,
div.sel,
div.sel:hover{ 
  background: url(images/bg.png) bottom right no-repeat; 
  font-family:Verdana,Arial;
  color: black;
  font-weight:bold;
  font-size: 8px;
  display: inline-block; 
  width: 188px;
  height: 26;
  line-height: 1.2;
  border: 0px;
  padding: 1px; 
  margin:1px;
  white-space: nowrap;
}
div.reg0:hover{  background: url(images/bg_sel.png) bottom right no-repeat; }
div.reg4{   background: url(images/bg_dis.png) bottom right no-repeat; }
div.sel{   background: url(images/bg_bor.png) bottom right no-repeat; }
div.sel:hover{   background: url(images/bg_bor_sel.png) bottom right no-repeat; }
div.caller
{
  background: url(images/bg_c.png) top left no-repeat; 
  font-family:Arial;
  color: black;
  font-weight:bold;
  font-size: 10px;
  display: inline-block; 
  width: 184;
  height: 20;
  border: 0px;
  padding: 0px; 
  margin: 2px 1px 1px;
  padding: 3px 3px;
  white-space: nowrap;
}
/*-1 = Extension not found 
0 = Idle 
1 = In Use 
2 = Busy 
4 = Unavailable 
8 = Ringing 
16 = On Hold */
.stat-1{  background: url(images/lamp_green.png) no-repeat; }
.stat0 {  background: url(images/lamp_lblue.png) no-repeat; }
.stat1 {  background: url(images/lamp_green.png) no-repeat; }
.stat2 {  background: url(images/lamp_red.png) no-repeat;   }
.stat4 {  background: url(images/lamp_grey.png) no-repeat; }
.stat8 {  background: url(images/lamp_red.png) no-repeat;   }
.stat16{  background: url(images/lamp_violet.png) no-repeat; }
.stat32{  background: url(images/lamp_orange.png) no-repeat; }
.stat64{  background: url(images/lamp_blue.png) no-repeat; }

.stat-1,
.stat0,
.stat1, 
.stat2,
.stat4, 
.stat8,
.stat16,
.stat32,
.stat64{
  height: 25;  
  width: 25; 
  background-position: 50% 50%; 
  display: block; 
  float: left;
  padding: 0px;   
  }
span.callerid,
span.callerpos,
span.callerwtime{ 
  font-family:Arial;
  color: black;
  font-size: 11px;
  font-weight:bold;
  overflow: hidden;
  position:relative;
  float: left;
  max-width: 130px;
  margin: 0px 2px;  
}
span.callerpos{ 
  font-size: 11px;
  font-weight:bold;
  float: left;
  text-align:right;
  padding: 0px 2px; 
  margin: 0px 2px;  
    border-radius: 4px;
    -moz-border-radius: 4px;
  background-color: white; 
}
span.callerwtime{ 
  color: red;
  font-size: 11px;
  float: right;
  text-align:right;
  float: right;
}
div.usernum,
div.username,
div.stats,
div.time{ 
  font-family:Arial;
  color: black;
  font-size: 11px;
  font-weight:bold;
  float: left;
  overflow: hidden;
  position:relative;
}
div.username{ float: none; }
div.stats{ 
  font-size: 10px;
  font-weight:normal;
  float: left;
}
div.time{ 
  color: red;
  font-size: 10px;
  display: inline;
  float: right;
  text-align:right;
}


div.exten_content,
div.trunk_content,
div.app_content,
div.park_content,
div.user_set,
div.queues_content { 

  background-color: #F5F5F5;  
    	border-radius: 6px;
	-moz-border-radius: 6px;

  padding: 4px;
  margin-top: 2px;  

}
div.user_set { 
  background-color: #FFCCCC; 
}
div.exten_content { 
  background-color: #CCCCFF; 
}
div.trunk_content { 
  background-color: #CCFFCC; 
}
div.app_content   { 
  background-color: #CCEECC;
}
div.app_content   { 
  background-color: #FCFCCC;
}
div.queues_content   { 
  background-color: #FFE9B9;
}
.white_el
{
}
div.elems{ 
  display: inline-block;
  background-color: #F5F5F5;  
  border: 1px solid white;
  padding: 2px; 
  margin-top: 2px;  
    	border-radius: 4px;
	-moz-border-radius: 4px;

}

div.elems2,
div.elems2R,
div.elems2B,
div.elems2I,
div.elems2IR,
div.elems2IC,
div.elems2IJ,
div.elems2IL,
.white_el { 
  background-color: #F5F5F5;  
  margin:2px;
  padding: 2px; 
  vertical-align:middle;
  min-height: 24px
  line-height: 1.5;
  border-radius: 4px;
  -moz-border-radius: 4px;
  width: auto;
  font-family:Arial;
}
div.elems2IR{ 
  display: inline-block;
  text-align: right;
}
div.elems2IC{ 
  display: inline-block;
  text-align: center;
}
div.elems2IJ{ 
  display: inline-block;
  text-align: justify;
}
div.elems2IL{ 
  display: inline-block;
  text-align: left;
}
div.elems2B{ 
  display: block;
}
div.elems2I{ 
  display: inline-block;
}
.white_el{ 
  display: inline-block;
  text-align: left;
  background-color: #white; 
  padding: 1px; 
  margin:1px ; 
  vertical-align: 5%;
  color: #999999;
}
.white_el b
{
    color: #000000;
    font-weight:bold;
}
#search-input {
    font-size: 3em;
    width: 15em;
}
.nodisplay {
    display: none;
}
.inactive {
    color: #AAA;
}
input#CallControlsExtenFilter
{
    width: 100px;
    outline: none;
    border: solid 1px Silver;
    height: 21px;
    line-height: 16px;
    padding: 1px;
    margin: 0;
    padding-right: 20px;
}
.dragon
{
    -MOZ-OUTLINE-RADIUS: 4px;
    OUTLINE-RADIUS: 4px;
    border: solid 2px red;
    outline: 2px solid orange;
}
.draging
{
    -MOZ-OUTLINE-RADIUS: 4px;
    OUTLINE-RADIUS: 4px;
    outline: 1px solid orange;
}
.ui-fix
{
    display: inline-block; 
    vertical-align: -20%;
}
.tooltip{
    position:absolute;
    width:200px;
    color:#333333;
    padding:2px;
    font-size:12px;
    font-family:Arial;
    background-color: #FFFFCC;
    border-style: solid;
    border-width: 1;
    border-color: #CCCCCC;
}
.tooltip-image{
    float:left;
    margin-right:5px;
    margin-bottom:5px;
    margin-top:3px;
}
.tooltip span{
   font-weight:700;
   color:#0066FF;
}
.pause_button
{
    background: url(images/sym_pause.png) center center no-repeat; 
}
.play_button
{
    background: url(images/sym_play.png) center center no-repeat; 
}
.cancel_button
{
    background: url(images/sym_cancel.png) center center no-repeat; 
}
.phone_red_button
{
    background: url(images/sym_phone_red.png) center center no-repeat; 
}
.phone_green_button
{
    background: url(images/sym_phone_green.png) center center no-repeat; 
}
.ext_butt_controls
{
    position: absolute; 
    margin-top:-10px; 
    width:184px; 
    text-align:right; 
}
.LrButton.hint
{
    padding:2px;
}

</style>
<BODY onload='init_timers()' >

    <script type="text/javascript"> 
    function init_timers()
    {
        alreadylogged=0;
        k=0;
        agentnum='xxx';
        last_state = {};
        //закешируем класс .stat8 чтоб выборка была быстрее
        stat8=$('.stat8');
        $('.twittyMenu').twittymenu();
        alreadycookierestore=0;
        $('#CallControlsExtenFilter').inputDefualts({ cl: 'inactive', text: 'Search...'});
        $('#CallControlsUserNumber').inputDefualts({ cl: 'inactive', text: $.cookie("UserNumber")});//Enter Pincode
        if($.cookie("UserNumber"))
        {
            $("#CallControlsUserNumberSave").attr("checked","checked");
            LogExtenNum=$("#CallControlsUserNumber").attr("value");
        }else{
            $("#CallControlsUserNumberSave").removeAttr("checked");
            $('#CallControlsUserNumber').inputDefualts({ cl: 'inactive', text: 'You number'});
        }
        listExten('','num');
        Blink_timer = setInterval('LampOn()',400);
        Exten_Status_timer = setInterval("StatusQuery()",30000);
        Sys_Status_timer = setInterval("SysStatusQuery()",3000);
        StatusQuery();             
        
        //вставим задержку в одну секунду, иначе listExten еще не успеет отработать и клонировать будет нечего
        setTimeout(function()
        { 
            // при загрузке восстановим из кукисов пользовательские кнопки
            if($.cookie("user_buttons"+LogExtenNum)) {
                var buttons = 'none'+$.cookie("user_buttons"+LogExtenNum);
                var s_buttons = buttons.split(":");
                $("#status5").html(buttons);  
                jQuery.each(s_buttons, function(i, val) 
                {
                    $('#rep_buttons #exten_'+val).clone().insertBefore("#user_set_h");
                });
            }

            SetExtButtControls(".ext_buttons");

        }, 1000);
       
    }
        //функция для подписи неактивных полей ввода
        (function($) {
	$.fn.inputDefualts = function(options) {
		var defaults = { cl: 'inactive', text: this.val() }, opts = $.extend(defaults, options);	
  		this.addClass(opts['cl']); 	
  		this.val(opts['text']);			
  		this.focus(function() {
  			if($(this).val() == opts['text']) $(this).val(''); 
  			$(this).removeClass(opts['cl']); 
  		});
  		this.blur(function() {
  			if($(this).val() == '') {
  				$(this).val(opts['text']); 			
  				$(this).addClass(opts['cl']); 
  			}
  		});
	};
        })(jQuery);
        
        $.fn.removeWithoutLeaking = function() {
            this.each(function(i,e){
                if( e.parentNode )
                    e.parentNode.removeChild(e);
            });
        };
  
        
        function LampOn()
        {
            stat8.css('backgroundImage', 'url(images/lamp_red.png)');
            on = setTimeout("LampOff()", 200);
        }
        function LampOff()
        {
            stat8.css('backgroundImage', 'url(images/lamp_lblue.png)');
            delete on;
        }
        
        var j=0;
        //периодический запрос состояния зарегестрированного оператора а также всех экстеншенов
        function SysStatusQuery()
        {
        
            $.getJSON("extensions-realtime.php?query=currentstate&LogExtenNum="+LogExtenNum,
                function(obj)
                { 
                    //пропарсим состояние агента
                    obj_agent=obj['agentstate'];
                    //пропарсим и поменяем состояние экстеншенов
                    obj_conn=obj['connections'];
                    //периодически удаляем сообщение статуса, чтоб не мозолило глаза оператору
                    $('#Messages').html('&nbsp;');
                    
                    

                    j=j+1;//каждая итерация добавляет класс к используемому элементу с уникальным номером
                    if(obj_conn==null)
                        obj_conn="";
                    jQuery.each(obj_conn, function(i, val) 
                    {
      
                        $("div#exten_"+i+" div#Status").replaceWith("<div id='Status' class=\"svalue"+j+' stat'+val["Status"]+"\">&nbsp;</div>");
                        $("div#exten_"+i+" div#Connected div").replaceWith("<div class=\"value"+j+"\">"+val["Connected"]+"</div>");
                        $("div#exten_"+i+" div#CallerID div").replaceWith("<div class=\"value"+j+"\">"+val["CallerID"]+"</div>");
                        $("div#exten_"+i+" div#Duration div").replaceWith("<div class=\"value"+j+"\">"+val["Duration"]+"</div>");
                    });
                    
                    //все дивы с номерами предыдущей итерации возвращаем на прежнее место
                    //$(".value" + (j-1) ).remove();
                    $(".svalue" + (j-1) ).replaceWith('<div id="Status" class="stat0">&nbsp;</div>');
                    $(".value" + (j-1) ).replaceWith('<div class="value'+j+'">&nbsp;</div>');
                    //закешируем класс .stat8 чтоб выборка была быстрее
                    stat8=$('.stat8');
                        
                    //В правом углу отобразим имя и номер с кем соединен, запомним номер канала
                    if(obj_conn[LogExtenNum] !== undefined)
                    {
                        curr_chan=obj_conn[LogExtenNum]['Channel'];
                        curr_num=obj_conn[LogExtenNum]['Connected'];
                        curr_name=obj_conn[LogExtenNum]['CallerID'];
                    }else{
                        curr_chan=undefined;
                        curr_num=undefined;
                        curr_name=undefined;
                    }
                    //alert("call from:"+curr_num+":"+curr_name);
                    //alert(agentnum);
                    $('#status3').html("call from:"+curr_num+":"+curr_name);
                   
                    $('#status2').html(LogExtenNum);
                    
                    if(curr_num !== undefined && curr_name !== undefined )
                    {
                        $('#AgentControlsCallerID').html(curr_num+":");
                        $('#AgentControlsCustomer').html(curr_name);
                        $('#status4').html(curr_chan);
                        //чтобы канал был установлен и был реальным
                        var re = /(SIP)|(IAX2)|(LOCAL)|(ZAP)|(DAHDI)/;
                        var chantest = re.test(curr_chan);
                        if($('#CallControlsTransfer').hasClass("disabled") && chantest)
                        {
                            //включим кнопки, если нет номера абонента
                            $('#CallControlsTransfer').removeClass('disabled'); 
                            $('#CallControlsHangup').removeClass('disabled'); 
                            //Восстановим обработчики
                            $("#CallControlsTransfer").live("click",CallControlsTransfer);
                            $("#CallControlsHangup").live("click",CallControlsHangup);
                        }
                    }else{
                        $('#AgentControlsCallerID').html("n");
                        $('#AgentControlsCustomer').html("/a");
                        $('#status4').html(curr_chan);
                        if( !$('#CallControlsTransfer').hasClass("disabled"))
                        {
                            //отключим кнопки, если нет номера абонента
                            $('#CallControlsTransfer').addClass('disabled'); 
                            $('#CallControlsHangup').addClass('disabled'); 
                            //уберем обработчики
                          //  $("div.ext_buttons").live("click", )
                            $("#CallControlsTransfer").die("click");
                            $("#CallControlsHangup").die("click");
                        }
                    }


                    
                    //удалим все объекты
                    delete obj_agent;
                    //delete obj_conn;
                    delete obj;
                    
                });
        }; 
        //Проверка отметки чекбокса сохранения номера в кукисах
        function CallControlsUserNumberSave()
        {
            if($("#CallControlsUserNumberSave").is(':checked')==true)
            {
                $.cookie("UserNumber", $("#CallControlsUserNumber").attr("value"), { expires: 365 });
                $('#status4').html("checked!!!");
                LogExtenNum=$("#CallControlsUserNumber").attr("value");
            }else{
                $.cookie("UserNumber",null);    
                $('#status4').html("unchecked!!!");                
            }
        };
        //периодический запрос текущего состояния экстеншенов
        function StatusQuery()
        {
            $.getJSON("extensions-realtime.php?query=extstate",
                function(obj)
                { 
                    jQuery.each(obj, function(i, val) 
                    {
                        if(val["Status"]==4)
                        {
                            $("div#exten_"+i+" div#Status")
                                .removeClass("stat0")
                                .addClass("stat4");
                            $("div#exten_"+i+".reg0")
                                .addClass('reg4')
                                .removeClass('reg0');
                        }
                        else if(val["Status"]==0)
                        {
                            $("div#exten_"+i+" div#Status")
                                .removeClass("stat4")
                                .addClass("stat0");
                            $("div#exten_"+i+".reg4")
                                .addClass('reg0')
                                .removeClass('reg4');
                        }
                    delete obj;
                    });
                });
        };
        // Для сортировки по номеру в очереди (возрастание)
        //sorted=$(people).sort(sortLastNameDesc);
        jQuery.fn.sort = function() 
        {  
            return this.pushStack( [].sort.apply( this, arguments ), []);  
        };  
            function sortPosition(a,b)
            {  
                if (a['Position'] == b['Position'])
                {
                    return 0;
                }
                return a['Position']> b['Position'] ? 1 : -1;  
            };  
            function sortPositionDesc(a,b)
            {  
                return sortPosition(a,b) * -1;  
            };
        //var SortedHash = ASort(Hash, 'someProp');
        function ASort(aInput, name)
        {
            var aTemp = []; 
            for (var sKey in aInput)
                aTemp.push([sKey, aInput[sKey]]);
            aTemp = aTemp.sort(function ()
                {
                    return arguments[0][1][name] - arguments[1][1][name]
                }); 
            var aOutput = []; 
            for (var nIndex = 0; nIndex < aTemp.length; nIndex++) 
                aOutput[aTemp[nIndex][0]] = aTemp[nIndex][1];
            delete aTemp; 
            delete aInput; 
            return aOutput; 
        };


            
        function listExten(needle1,sorting1)
        {
            sorting=sorting1;
            needle=needle1;

            if(sorting=='num')
            {
                $("#CallControlsExtenSortNum").addClass('clicked');
                $("#CallControlsExtenSortName").removeClass('clicked');
            }
            if(sorting=='name')
            {
                $("#CallControlsExtenSortNum").removeClass('clicked');
                $("#CallControlsExtenSortName").addClass('clicked');
            }
            $.getJSON("extensions-realtime.php?query=extensions&needle="+needle+"&sorting="+sorting+"",
                function(obj)
                { 
                    content='';
                    exten_content='<div id="ext_sh_tg"><b>Extensions</b><span class="ui-icon ui-icon-triangle-1-n ui-fix "></span></div>';
                    trunk_content='<div id="trunk_sh_tg"><b>Trunks</b><span class="ui-icon ui-icon-triangle-1-n ui-fix "></span></div>';
                    app_content='<div id="app_sh_tg"><b>Applications</b><span class="ui-icon ui-icon-triangle-1-n ui-fix "></span></div>';
                    park_content='<div id="park_sh_tg"><b>Parking lots</b<span class="ui-icon ui-icon-triangle-1-n ui-fix "></span>></div>';
                    queue_content='<div id="park_sh_tg"><b>Queues</b><span class="ui-icon ui-icon-triangle-1-n ui-fix "></span></div>';
                    jQuery.each(obj['extensions'], function(i, val) 
                    {
                        
                        content='' 

                                +'<div class="ext_buttons reg0 ui-state-default ui-draggable type_'+val["type"]+'" id="exten_'+val["name"]+'">'
                                    +'<div class="stat0" id="Status"><div></div></div>'
                                    +'<div class="time" id="CallsTaken"><div></div></div>'
                                    +'<div class="usernum">'+val["cidnum"]+'</div>'
                                    +'<div class="usernum">:</div>'
                                    +'<div class="username">'+val["cidname"]+'</div>'
                                    +'<div class="stats" id="Connected"><div>&nbsp;</div></div>'
                                    +'<div class="stats">:</div>'
                                    +'<div class="stats" id="CallerID"><div>&nbsp;</div></div>'
                                    +'<div class="time" id="Duration"><div style="color:green;"></div></div>'
                                    +'<div class="ext_butt_controls" id="ext_butt_controls"></div>\n'
                                    +'<div class="nodisplay" id="qnum"></div>\n'
                                +'</div>';
                        if(val["type"]=='exten')
                            exten_content=exten_content+content;
                        if(val["type"]=='trunk')
                            trunk_content=trunk_content+content;
                        if(val["type"]=='app')
                            app_content=app_content+content;
                        if(val["type"]=='park')
                            park_content=park_content+content;
                        if(val["type"]=='queue')
                            queue_content=queue_content+content;
                    }); 

                    $("div.exten_content")
                        .empty()
                        .html(exten_content);
                    $("div.trunk_content")
                        .empty()
                        .html(trunk_content);
                    $("div.app_content")
                        .empty()
                        .html(app_content);
                    $("div.park_content")
                        .empty()
                        .html(park_content);
                    $("div.queue_content")
                        .empty()
                        .html(queue_content);
                    //и сортируемыми
                    $(".ext_buttons").draggable({
                                    scroll : false,
                                    revert : true,
                                    helper : 'clone',
                                    //handle: '#Status',
                                    //connectWith: '.user_set',
                                    opacity : 0.4,
                                    connectToSortable: '#user_set_butt' 
                            })
                            .css('cursor','move')
                            .disableSelection();
                    
                    /*$('div.ext_buttons').draggable({
                                    scroll : false,
                                    revert : true,
                                    helper : 'clone',
                                    opacity : 0.6
                            }); */
                    //добавим функции сворачивания для подразделов панели
                    $("#user_set_a").click(function () {
                      $("#user_set_a .ui-icon").toggleClass('ui-icon-triangle-1-s');
                      $("#user_set .ext_buttons").toggle();
                    });
                    $("#ext_sh_tg").click(function () {
                      $("#ext_sh_tg .ui-icon").toggleClass('ui-icon-triangle-1-s');
                      $(".exten_content .ext_buttons").toggle();
                    });
                    $("#app_sh_tg").click(function () {
                      $("#app_sh_tg .ui-icon").toggleClass('ui-icon-triangle-1-s');
                      $(".app_content .ext_buttons").toggle();
                    });
                    $("#trunk_sh_tg").click(function () {
                      $("#trunk_sh_tg .ui-icon").toggleClass('ui-icon-triangle-1-s');
                      $(".trunk_content .ext_buttons").toggle();
                    });
                    //добавим функции сворачивания для подразделов панелей очередей
 
                    //вернем текущее состояние
                    //obj_conn=
                    //SysStatusQuery();
                    StatusQuery();
                    content='';
                    obj=null;
                    //навесим обработчик подсветки соединенных
                    SetExtButtControls(".ext_buttons");
                    SetHints();
                    delete obj;
                    delete content;
                    delete exten_content;
                    delete trunk_content;
                    delete app_content;
                });
        };
        //обработчик подсветки соединенных абонентов
        function SetExtButtControls(selector)
        {
            selected_obj=$(selector);
            selected_obj.unbind()
            selected_obj.hover(
                function () {
                    //вычисляем кто с кем соединен, текущие каналы и тп.
                    callnum='';
                    queuenum='';
                    exthovernum='';
                    
                    callnum=this.children[2].innerHTML;
                    if(obj_conn[callnum]!==undefined)
                        if(obj_conn[callnum]['Channel']!==undefined)
                            Channel=obj_conn[callnum]['Channel'];
                    
                    queuenum=this.children[10].innerHTML;
                    exthovernum=this.children[5].children[0].innerHTML;
                    $("#exten_"+exthovernum).addClass('sel');
                    $(this).addClass('sel');

                },
                function () {
                    exthovernum=this.children[5].children[0].innerHTML;
                    $("#exten_"+exthovernum).removeClass('sel');
                    $(this).removeClass('sel');
                    $(this).children('.ext_butt_controls').empty();
                }
            );  
        }
        //назначает высплывающие подсказки
        function SetHints()
        {
            $('.hint').bind('mouseover', function()
            {
                var theMessage = $(this).attr('hint');
                $('<div class="tooltip">' + theMessage + '</div>').appendTo('body').fadeIn('fast');
                $(this).bind('mousemove', function(e)
                {
                    $('div.tooltip').css(
                    {
                        'top': e.pageY - ($('div.tooltip').height())+30,
                        'left': e.pageX + 20
                    });
                });
            }).bind('mouseout', function()
            {
                $('div.tooltip').fadeOut('fast', function()
                {
                    $(this).remove();
                });
            });
        }
        //очистим пользовательские кнопки при нажатии
        function CallControlsUserSetClear()
        {
            $('#user_set .ext_buttons').replaceWith('');
            $.cookie("user_buttons"+LogExtenNum, null);
            $("#status6").html('null');   
            return false;
        }
        //AJAX фильтрация кнопок на панели
        function CallControlsLookup(needle)
        {
            if(needle.length >=1)
            {
                $("#CallControlsExtenFilterClear").live("click",CallControlsExtenFilterClear);
                $('#CallControlsExtenFilterClear').removeClass('disabled');
                //навешиваем обработчик события на все кнопки экстенов
                $("div.ext_buttons").live("click", function(e){
                    extselnum=this.children[2].innerHTML;
                    extselname=this.children[3].innerHTML;
                    $("#CallControlsExtenFilter").val(extselnum);
                    $("div.ext_buttons").die("click");                                 
                });              
                listExten(needle,sorting);
            }
            if(needle.length ==0)
            {
                $('#CallControlsExtenFilterClear').addClass('disabled'); 
                $("#CallControlsExtenFilterClear").die("click");
                listExten('',sorting);
            }
                
        };
        //функция очищает поле ввода номера при клике на кнопку
        function CallControlsExtenFilterClear(logintype)
        {
            $("#CallControlsExtenFilter").val('');
            $('#CallControlsExtenFilterClear').addClass('disabled'); 
            $("#CallControlsExtenFilterClear").die("click");
            listExten('',sorting);
        }
        
        function CallControlsCall(callnum)
        {  //action=login&agentnum=302&agentpin=81dc9bdb52d04dc20036dbd8313ed055
            
            if(!callnum)
                var callnum=$("#CallControlsExtenFilter").val();
            if(callnum=="Search...")
                callnum="";
            if(callnum)
            {
                $("#CallControlsExtenFilter").val('');
                $("#status5").html(callnum);
                $.getJSON("extensions-realtime.php?action=originatecall&extennum="+callnum+"&LogExtenNum="+LogExtenNum,
                    function(obj)
                    { 
                        $('#Messages').html(obj[LogExtenNum]['Message']);
                        $('#status7').html(obj[LogExtenNum]['Message']);   
                        delete obj;
                    });
                
                listExten('',sorting);
            }else{
                //скрываем все, что к экстенам не относится
                $("#trunk_content").addClass('nodisplay');
                //навешиваем обработчик события на все кнопки экстенов
                $("div.ext_buttons").live("click", function(e){
                    extselnum=this.children[2].innerHTML;
                    extselname=this.children[3].innerHTML;
                    
                    $("#status5").html(extselnum);
                    $.getJSON("extensions-realtime.php?action=originatecall&extennum="+extselnum+"&LogExtenNum="+LogExtenNum,
                        function(obj)
                        { 
                            $('#Messages').html(obj[LogExtenNum]['Message']);
                            $('#status7').html(obj[LogExtenNum]['Message']);              
                            delete obj;
                        });
                    $("div.ext_buttons").die("click");
                    //показываем скрытое
                    $("#trunk_content").removeClass('nodisplay');    
                                 
                });
            }
            ;
        };
        function CallControlsTransfer()
        {  //extensions-realtime.php?action=transfer&extennum=102&redirchan=SIP/363-b5ec0000
            
            var callnum=$("#CallControlsExtenFilter").val();
            if(callnum=="Search...")
                callnum="";
            if(callnum)
            {
                $("#CallControlsExtenFilter").val('');
                $.getJSON("extensions-realtime.php?action=transfer&extennum="+callnum+"&redirchan="+curr_chan+"&LogExtenNum="+LogExtenNum,
                    function(obj)
                    { 
                        $('#Messages').html(obj[LogExtenNum]['Message']);
                        $('#status4').html(extennum+":"+curr_chan);
                        delete obj;
                    });
                    
                listExten('',sorting);
            }else{
                //скрываем все, что к экстенам не относится
                $("#trunk_content").addClass('nodisplay');
                //навешиваем обработчик события на все кнопки экстенов
                $("div.ext_buttons").live("click", function(e){
                    extselnum=this.children[2].innerHTML;
                    extselname=this.children[3].innerHTML;
                    $.getJSON("extensions-realtime.php?action=transfer&extennum="+extselnum+"&redirchan="+curr_chan+"&LogExtenNum="+LogExtenNum,
                        function(obj)
                        { 
                            $('#Messages').html(obj[LogExtenNum]['Message']);
                            delete obj;
                        });
                    $("div.ext_buttons").die("click");
                    //���������� �������
                    $("#trunk_content").removeClass('nodisplay');    
                                 
                });
            }
            ;
        };
        //обработка нажатия интера
        function CallControlsKeys(event)
        {
            if(event.keyCode==13)
            {
                CallControlsCall();
            }
        }
        function CallControlsHangup(Interface)
        {  // extensions-realtime.php?action=hangup&hangupchan=SIP/363-08f2a400
            if(Interface===undefined)
            {
                $.getJSON("extensions-realtime.php?action=hangup&hangupchan="+curr_chan,
                    function(obj)
                    { 
                        $('#Messages').html(obj[LogExtenNum]['Message']);
                        delete obj;
                    });
            }else{
                $.getJSON("extensions-realtime.php?action=hangup&hangupchan="+Interface,
                    function(obj)
                    { 
                        $('#Messages').html(obj[LogExtenNum]['Message']);
                        delete obj;
                    });                
            }
        };
        
      
      
</script> 


<div class="elems2   ExtensionsControls extlistfull" id="ExtensionsControls">

        <div class="elems" style="width: 99.4%; vertical-align:center; background-color:white;"  >
            <span class="LrButton" onclick="listExten('','num')" id="CallControlsExtenSortNum">by num</span>
            <span class="LrButton" onclick="listExten('','name')" id="CallControlsExtenSortName">by name</span>
            <input size="10" id="CallControlsExtenFilter" type="text" onkeyup="CallControlsLookup(this.value);" onkeypress="CallControlsKeys(event)"   />
            <input type="image" id="CallControlsExtenFilterClear" src="images/x.gif" style=" cursor: pointer; margin-left: -18px; margin-right: 10px "/>            
            <span class="LrButton" onclick="CallControlsCall()" id="CallControlsCall">Call</span>
            <span class="LrButton disabled"  id="CallControlsTransfer" >Transfer</span>
            <input size="10" id="CallControlsUserNumber" type="text"    />
            <span> <input size="10"  class="ui-fix" type="checkbox" value="" name="Save" id="CallControlsUserNumberSave" onclick="CallControlsUserNumberSave()" />Save</span>
            <div class="elems2IR" style="float: right; color:white;background-color: #00cc00; ">
                <nobr>
                    <b>
                        <span id="AgentControlsCallerID">n/</span>
                        <span id="AgentControlsCustomer">a</span>
                    </b>
                </nobr>
            </div>  
            <div class="elems2IR" id="Messages" style="float: right; background-color: yellow; "></div>
            
        </div>


            <div id="rep_buttons">
                <div class="exten_content " id="exten_content"></div>
                <div class="app_content " id="app_content"></div>
                <div class="trunk_content " id="trunk_content"></div>
            <div>
        </div>

</div>

<div id="StatusBar">
    <div class="elems2IL" style="width: auto; margin-top: 2px;"  >
        <div class="elems2IL" id="status1" style="background-color: #dddddd; padding: 0px 2px; ">status1</div>
        <div class="elems2IL" id="status2" style="background-color: #dddddd; padding: 0px 2px;">status2</div>
        <div class="elems2IL" id="status3" style="background-color: #dddddd; padding: 0px 2px;">status3</div>
        <div class="elems2IL" id="status4" style="background-color: #dddddd; padding: 0px 2px;">status4</div>
        <div class="elems2IL" id="status5" style="background-color: #dddddd; padding: 0px 2px;">status5</div>
        <div class="elems2IL" id="status6" style="background-color: #dddddd; padding: 0px 2px;">status6</div>
        <div class="elems2IL" id="status7" style="background-color: #dddddd; padding: 0px 2px;">status7</div>
    </div>
            <div class="elems2IR" id="Messages" style="float: right; background-color: White; color: grey; ">
            Developed by <a href="http://lynks.ru" style="text-decoration: none;font-weight: bold; font-family:Verdana,Arial; color: #2E487F;">Lynks.ru</a> 2010
    </div>
</div>

</BODY>
