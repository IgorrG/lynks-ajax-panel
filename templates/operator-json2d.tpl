{
    {foreach key=key1 item=item1 from=$data}
    "{$key1}": {
        {foreach key=key2 item=item2 from=$item1}
            "{$key2}":"{$item2}" ,
        {/foreach}
        },
    {/foreach}
}
