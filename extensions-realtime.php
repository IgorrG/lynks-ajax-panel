<?php
require_once 'lib/Smarty.class.php';
require_once 'lib/smarty-gettext.php';
require_once "lib/php-asmanager.php";
require_once "lib/functions.inc.php";

require_once "config.php";

unset($AgentAccount);
session_start();
$smarty = new Smarty();
$smarty->register->block('t', 'smarty_translate');
$ami = new AGI_AsteriskManager();
$res = $ami->connect($ami_host, $ami_user, $ami_secret);

ini_set('display_errors','no');
ini_set('register_globals','yes');
ini_set('short_open_tag','yes');

$AgentsEntry=array();
$QueueParams=array();
$QueueMember=array();
$QueueEntry=array();

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT"); 
header("Cache-Control: no-store, no-cache, must-revalidate"); 
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache"); 

if($_REQUEST['button'] == 'Submit')
{
        $out="<pre>".shell_exec('/usr/sbin/asterisk -rx "show queues"')."</pre>";
        echo $out;
        
}
/*
Перед началом работы агент регистрируется, воодя свой номер и пинкод
Открывается основной рабочий интефейс агента, где он может выбрать внутренний номер,
на котором будут обрабатываться вызовы. После этого ему доступны органы управления
переводом/парковкой вызовов, так как он уже может принимать звонки.
При необходимости он может зарегистрироваться в очереди (одной). при этом ему отображается
количество звонков, ожидающих обработки.
Нажатием на конопку транфера с последующим выбором экстеншена можно в два клика перевести
звонок на нужного оператора. Если ввести в специальное поле номер, а затем нажать транфер,
то вызов будет переведен на этот номер.
Оператор может поставить вызов на удержание и соединиться со специалистом для уточнения.
Оператор может запросить помощь у супервизора нажав на кнопку help и выбрав супервизора
из списка. При этом ему можно отправить короткое сообщение.
Супервизору доступен дополнительный экран с отображением состояния всех очередей.
Также нажав на кнопку супервизор может прослушать произвольный разговор на своем телефоне,
подключиться к разговору в режиме шепота.

*/

if($_REQUEST['show'] == 'list')
{
       // 
        //$out=$ami->Events('QueueParams,QueueMember,QueueEntry')
        //$out=$ami->command('database show');
        $database=$ami->database_show('AMPUSER');
        // преобразуем масиив базы данных asterisk в массив для удобного отображения средствами smarty
        $i=0;
        foreach($database as $key => $value)
        {
            $keys=split("/",$key);
            $extensions[$keys[2]][$keys[3]]=$value;
            $extensions[$keys[2]]['secret']="";
            $i++;
        }
        $smarty->assign('extensions', $extensions);
        $smarty->display('extensions-realtime.tpl');       
        /*?><pre>extensions:<?print_r($extensions);?></pre><?      */         
}

if($_REQUEST['action'] == 'originatecall')
{
        //$extennum - номер экстена, на который позвонить
        $databaseUser=$ami->database_show('AMPUSER');
        $databaseCall=$ami->database_show('CURRCALL');
        
        //найдем нашего агента и вернем данные только по нему
        //все взаимодействие через переменную сессий $AgentAccount
        if(isset($LogExtenNum))
        {
            $LogExtenName=$databaseUser["/AMPUSER/$LogExtenNum/cidname"];
            $CurrCallNum=$databaseCall["/CURRCALL/$LogExtenNum/NUM"];
            $CurrCallName=$databaseCall["/CURRCALL/$LogExtenNum/NAME"];
            
            $data[$LogExtenNum]=$ami->Originate("LOCAL/".$LogExtenNum."@".$dialplan_context,
                                                    $extennum, 
                                                    $dialplan_context,
                                                    '1', 
                                                    '30000', 
                                                    '"'.$LogExtenNum.'" <'.$LogExtenName.'>', '',
                                                    '', '', '');
//            $smarty->assign('data', $data);
//            $smarty->display('operator-json2d.tpl');      
echo json_encode($data);
        }
}
if($_REQUEST['action'] == 'transfer')
{
        //$extennum - номер экстена, на который передресовывать
        //$redirchan - канал, который передресовывать
        //найдем нашего агента и вернем данные только по нему
        //все взаимодействие через переменную сессий $AgentAccount
        if(isset($LogExtenNum))
        {
            $LogExtenName=$databaseUser["/AMPUSER/$LogExtenNum/cidname"];
            $CurrCallNum=$databaseCall["/CURRCALL/$LogExtenNum/NUM"];
            $CurrCallName=$databaseCall["/CURRCALL/$LogExtenNum/NAME"];

            $data[$LogExtenNum]=$ami->Redirect($redirchan, '', $extennum, $dialplan_context, '1');
            echo json_encode($data);
//            $smarty->assign('data', $data);
  
//            $smarty->display('operator-json2d.tpl');      
                
        }
}
if($_REQUEST['action'] == 'hangup')
{
        //$hangupchan - канал, который разорвать
        //проверим пароль, зарегистрируем и вернем аутентификационные данные для дальнейшей обработки
        if($PHPSESSID==session_id())
        {
            $data[$AgentAccount['cidnum']]=$ami->Hangup($hangupchan );
            $data[$AgentAccount['cidnum']]['PHPSESSID']=session_id();
            echo json_encode($data);
            //$smarty->assign('data', $data);
            //$smarty->display('operator-json2d.tpl');      
                
        }
}
if($_REQUEST['query'] == 'extensions')
{
        //$out=$ami->Events('QueueParams,QueueMember,QueueEntry')
        //$out=$ami->command('database show');

        //старый вариант: кнопки экстеншенов берутся из Astdb, а остальное - из файла
        /*$database=$ami->database_show('AMPUSER');
        // преобразуем масиив базы данных asterisk в массив для удобного отображения средствами smartly
        $i=0;
        foreach($database as $key => $value)
        {
            $keys=split("/",$key);
            $config1[$keys[2]][$keys[3]]=$value;
            $config1[$keys[2]]['secret']="";
            $config1[$keys[2]]['type']='exten';
            $i++;
        }
        $config = parse_ini_file( '/etc/asterisk/operator.conf', true );
        $pbuttons=$config2+$config;*/

        //новый вариант: все берется из файлов FOP, которые генерируются FreePBX
	$config1 = $config2 = array();
	if (file_exists($fop_path . 'op_buttons_additional.cfg')) {
			$config1 = parse_ini_file( $fop_path . 'op_buttons_additional.cfg', true );
	}
	if (file_exists($fop_path . 'op_buttons_custom.cfg')) {
			$config2 = parse_ini_file( $fop_path . 'op_buttons_custom.cfg', true );
	}
        $pbuttons=$config1+$config2;
        /*?><pre>pbuttons:<?print_r($pbuttons);?></pre><?*/
        
        //преобразуем формат FOP в формат нужный для нашей панели
        foreach($pbuttons as $key => $value)
        {
                //самый простой способ различать тип кнопок - по полю icon
                //Icon=1 - Парковочный слот
                //Icon=2 - хз
                //Icon=3 - Транк
                //Icon=4 - Абонент
                //Icon=5 - Очередь
                //Icon=6 - Конференция
                $name=substr($key,strpos($key,"/")+1);
                $extname=substr($key,strpos($key,"/")+1);
                if (!isset($value["Icon"])) {
            	    continue;
                }
                if($value["Icon"]==4) //если это абонент
                {
                    $buttons[$name]['name']=$extname;
                    $buttons[$name]['cidnum']=$value["Extension"];
                    $buttons[$name]['cidname']=substr($value["Label"],strpos($value["Label"],":")+2);
                    $buttons[$name]['type']="exten";
                }else if($value["Icon"]==3) //если это транк
                {
                    $name=substr($key,strpos($key,"/")+1);
                    $buttons[$name]['name']=$extname;
                    $buttons[$name]['cidnum']=$name;
                    $buttons[$name]['cidname']=$value["Label"];
                    $buttons[$name]['type']="trunk";
                } else if($value["Icon"]==5) //если это очередь
                {
                    $name=substr($key,strpos($key,"/")+1);
                    $buttons[$name]['name']=$extname;
                    $buttons[$name]['cidnum']=$name;
                    $buttons[$name]['cidname']=$value["Label"];
                    $buttons[$name]['type']="app";
                } else if($value["Icon"]==6) //если это конференция
                {
                    $name=substr($key,strpos($extname,"/")+1);
                    $buttons[$name]['name']=$key;
                    $buttons[$name]['cidnum']=$value["Extension"];
                    $buttons[$name]['cidname']=$value["Label"];
                    $buttons[$name]['type']="app";
                }
        }
       /* ?><pre>buttons:<?print_r($buttons);?></pre><?*/
        //сортируем если надо
        if($sorting=='name')
            usort($buttons, "sortName");
        if($sorting=='num')
            usort($buttons, "sortNum");
        //фильтруем вывод, если надо
        if($needle)
        {
            foreach($buttons as $key => $value)
            {
                $needle=strtolower($needle);
                $searchstr=strtolower("  ".$value['cidnum']." ".$value['cidname']);
                if(strpos($searchstr, $needle))
                    $extensions[]=$value;
            }
          
        }else{$extensions=$buttons;}
        $data['extensions']=$extensions;        
        
        
       echo json_encode($data);
       // $smarty->assign('data', $data);
       // $smarty->display('operator-json3d.tpl');                
}
if($_REQUEST['query'] == 'extstate')
{
        $database=$ami->database_show('AMPUSER');
        // преобразуем масиив базы данных asterisk в массив для удобного отображения средствами smartly
        $i=0;     

        
        foreach($database as $key => $value)
        {
            $keys=split("/",$key);
	   if (count($keys) < 2) {
	        	continue;
    	    }
            $tmp3=$ami->ExtensionState($keys[2], $dialplan_context, $i*1023);
            $connections[$keys[2]]["Status"]=$tmp3['Status'];
        }
        if (file_exists('/etc/asterisk/operator.conf'))
            $config = parse_ini_file( '/etc/asterisk/operator.conf', true );
        if($config){
            foreach ($config as $key => $value)
            {
                $tmp3=$ami->ExtensionState($key, $dialplan_context, $i*1023);
                $from_file[$key]['Status']=$tmp3['Status'];
            }
        }else{
            $from_file[]='';
        }
        $connections=$connections+$from_file;
        /*?><pre>connections:<?print_r($connections);?></pre><?*/
        echo json_encode($connections);
//        $smarty->assign('data', $connections);

  //      $smarty->display('operator-json2d.tpl');    
        
}

//запрос текущих каналов, состояния агента, и всего прочего, что делается периодически
//для уменьшения количества запросов к web серверу
//возвращает данные в трехмерном JSON массиве
if($_REQUEST['query'] == 'currentstate')
{
	if ($asterisk_version == '1.4') {
		$tmp=$ami->Command("show channels concise");
		$sBridgeCall = "Bridged Call";
		$cDialplanSeparator = '|';
		$iSecondLegIndex = 11;
		$iDurationIndex = 10;
	} else {
		$tmp=$ami->Command("core show channels concise");
		$sBridgeCall = "AppDial";
		$cDialplanSeparator = ',';
		$iSecondLegIndex = 12;
		$iDurationIndex = 11;
	}

        $databaseUser=$ami->database_show('AMPUSER');
        $databaseCall=$ami->database_show('CURRCALL');
        
        //найдем нашего агента и вернем данные только по нему
        //все взаимодействие через переменную сессий $AgentAccount
        if(isset($LogExtenNum))
        {
            $LogExtenName=$databaseUser["/AMPUSER/$LogExtenNum/cidname"];
            $CurrCallNum=$databaseCall["/CURRCALL/$LogExtenNum/NUM"];
            $CurrCallName=$databaseCall["/CURRCALL/$LogExtenNum/NAME"];
            $TalkingTo=ExtrId($data[$AgentAccount['cidnum']]['TalkingTo'], $cDialplanSeparator);
            $data[$AgentAccount['cidnum']]['LogExtenNum']=$LogExtenNum;
            $data[$AgentAccount['cidnum']]['LogExtenName']=$LogExtenName;
            $data[$AgentAccount['cidnum']]['CurrCallNum']=$CurrCallNum;
            $data[$AgentAccount['cidnum']]['CurrCallName']=$CurrCallName;
            $data[$AgentAccount['cidnum']]['TalkingTo']=$CurrCallNum;
            $data[$AgentAccount['cidnum']]['PHPSESSID']=session_id();
        }
        $displaydata['agentstate']=$data;

        //узнаем текущие соединения, отсеиваем только briged
       
        $tmp1=explode("\n",$tmp['data']);
        array_shift($tmp1);
        $i=0;
        foreach($tmp1 as $key => $value)
        {
            //если два абонента уже соединены
            $tmp2=explode("!",$value);
            if($tmp2[5]==$sBridgeCall )//and $tmp2[2]
            {
                $i++;
                $leg1=ExtrId($tmp2[0], $cDialplanSeparator); //после этого остаются только номера каналов без их технологии
                $leg2=ExtrId($tmp2[$iSecondLegIndex], $cDialplanSeparator);//однако ZAP каналы будут называться как ZAPXXX
                //echo $leg1."\n";
                //echo $leg2."\n";
                if($leg1!=$leg2)
                {
                    $tmp3=$ami->ExtensionState($leg1, $dialplan_context, $i*1023);
                    $connections[$leg1]["Status"]=$tmp3['Status'];
                    $tmp3=$ami->ExtensionState($leg2, $dialplan_context, $i*1023);
                    $connections[$leg2]["Status"]=$tmp3['Status'];
                    
                    $tmp3=$ami->database_show("AMPUSER/$leg1/cidname");
                    $leg1cid=$tmp3["/AMPUSER/$leg1/cidname"].'&nbsp;';
                    $tmp3=$ami->GetVar($tmp2[$iSecondLegIndex],"CALLERID(name)");
                    $leg2cid=$tmp3['Value'].'&nbsp;';                    
                    
                    $connections[$leg1]["Connected"]=$leg2;
                    $connections[$leg1]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                    $connections[$leg1]["Application"]=$tmp2[5];
                    $connections[$leg1]["CallerID"]=$leg2cid;
                    $connections[$leg1]["Channel"]=$tmp2[$iSecondLegIndex];
                    $connections[$leg2]["Connected"]=$leg1;
                    $connections[$leg2]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                    $connections[$leg2]["Application"]=$tmp2[5];
                    $connections[$leg2]["CallerID"]=$leg1cid;
                    $connections[$leg2]["Channel"]=$tmp2[0];
                }
            }elseif($tmp2[4]=="Ring" and $tmp2[5]=="Dial" )
            {
            $i++;
            $leg1=ExtrId($tmp2[0], $cDialplanSeparator);
            $leg2=ExtrId($tmp2[6], $cDialplanSeparator);
            $leg3=$tmp2[7];
            if($leg1!=$leg2)
            {
                $tmp3=$ami->ExtensionState($leg1, $dialplan_context, $i*1023);
                $connections[$leg1]["Status"]=$tmp3['Status'];
                $tmp3=$ami->ExtensionState($leg2, $dialplan_context, $i*1023);
                $connections[$leg2]["Status"]=$tmp3['Status'];
                
                $tmp3=$ami->GetVar($tmp2[0],"CALLERID(name)");
                $leg1cid=$tmp3['Value'].'&nbsp;';
                $tmp3=$ami->GetVar($tmp2[6],"CALLERID(name)");
                $leg2cid=$tmp3['Value'].'&nbsp;';
                $connections[$leg1]["Connected"]=$leg2;
                $connections[$leg1]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                $connections[$leg1]["Application"]=$tmp2[5];
                $connections[$leg1]["CallerID"]=$leg2cid;
                $connections[$leg1]["Channel"]=$tmp2[0];
                $connections[$leg2]["Connected"]=$leg1;
                $connections[$leg2]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                $connections[$leg2]["Application"]=$tmp2[5];
                $connections[$leg2]["CallerID"]=$leg1cid;
                $connections[$leg2]["Channel"]=$tmp2[6];
            }elseif($leg1!=$leg3){
                $leg2=$leg3;

                $tmp3=$ami->ExtensionState($leg1, $dialplan_context, $i*1023);
                $connections[$leg1]["Status"]=$tmp3['Status'];
                $tmp3=$ami->ExtensionState($leg2, $dialplan_context, $i*1023);
                $connections[$leg2]["Status"]=$tmp3['Status'];
                
                $tmp3=$ami->GetVar($tmp2[0],"CALLERID(name)");
                $leg1cid=$tmp3['Value'].'&nbsp;';
                $tmp3=$ami->GetVar($tmp2[7],"CALLERID(name)");
                $leg2cid=$tmp3['Value'].'&nbsp;';
                $connections[$leg1]["Connected"]=$leg2;
                $connections[$leg1]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                $connections[$leg1]["Application"]=$tmp2[5];
                $connections[$leg1]["CallerID"]=$leg2cid;
                $connections[$leg1]["Channel"]=$tmp2[0];
                $connections[$leg2]["Connected"]=$leg1;
                $connections[$leg2]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                $connections[$leg2]["Application"]=$tmp2[5];      
                $connections[$leg2]["CallerID"]=$leg1cid;
                $connections[$leg2]["Channel"]=$tmp2[7];
            }
            }elseif($tmp2[4]=="Up" and $tmp2[$iSecondLegIndex]=="(None)")
            {
            $i++;
            $leg1=ExtrId($tmp2[0], $cDialplanSeparator);
            $leg2=$tmp2[2];
            if($leg1!=$leg2)
            {
                $tmp3=$ami->ExtensionState($leg1, $dialplan_context, $i*1023);
                $connections[$leg1]["Status"]=$tmp3['Status'];
                $tmp3=$ami->ExtensionState($leg2, $dialplan_context, $i*1023);
                $connections[$leg2]["Status"]=$tmp3['Status'];
                
                $tmp3=$ami->GetVar($tmp2[0],"CALLERID(name)");
                $leg1cid=$tmp3['Value'].'&nbsp;';
                $tmp3=$ami->GetVar($tmp2[2],"CALLERID(name)");
                $leg2cid=$tmp3['Value'].'&nbsp;';
                $connections[$leg1]["Connected"]=$leg2;
                $connections[$leg1]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                $connections[$leg1]["Application"]=$tmp2[5];
                $connections[$leg1]["CallerID"]=$tmp2[5];
                $connections[$leg1]["Channel"]=$tmp2[0];
                $connections[$leg2]["Connected"]=$leg1;
                $connections[$leg2]["Duration"]=@date("i:s",$tmp2[$iDurationIndex]);
                $connections[$leg2]["Application"]=$tmp2[5];
                $connections[$leg2]["CallerID"]=$leg1cid;
                $connections[$leg2]["Channel"]=$tmp2[2];
            }
            }
            $channels[]=$tmp2;
        }


        /*?><pre>connections:<?print_r($connections);?></pre><?       
        ?><pre>channels:<?print_r($channels);?></pre><?      */
        
        $displaydata['connections']=$connections;
        
        $smarty->assign('data', $displaydata);
        echo json_encode($displaydata);
        //$smarty->display('operator-json3d.tpl');    
        
}

// extension sorting functions
function sortNum($a, $b) 
{
    return strcmp($a["cidnum"], $b["cidnum"]);
}
function sortName($a, $b) 
{
    return strcmp($a["cidname"], $b["cidname"]);
}

// extract TECH/XXX from channel name like Local/107@from-internal-9
function ExtrId($string, $dialplan_glue = '|')
{
    if($string!="n/a")
    {
        $string=" $string-";
        $leg1=substr($string,0,strpos($string,"-"));
        $leg1=substr($leg1,strpos($leg1,"/")+1);
        $leg1=strpos($leg1,"@")?substr($leg1,0,strpos($leg1,"@")):$leg1;
        $leg1=strpos($leg1, $dialplan_glue)?substr($leg1,0,strpos($leg1, $dialplan_glue)):$leg1;
        return $leg1;
    }
    return $string;
}

$res = $ami->Disconnect();

?>