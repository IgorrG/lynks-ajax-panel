{
    {foreach key=key1 item=item1 from=$data}
    "{$key1}": {
        {foreach key=key2 item=item2 from=$item1}
        "{$key2}":{
            {foreach key=key3 item=item3 from=$item2}
                "{$key3}":"{$item3}" ,
            {/foreach}
            }, 
        {/foreach}
        },
    {/foreach}
}
