{
    {foreach key=key1 item=item1 from=$data}
    "{$key1}": {
        {foreach key=key2 item=item2 from=$item1}
        "{$key2}": {
            {foreach key=key3 item=item3 from=$item2}
                "{$key3}": {
                    {foreach key=key4 item=item4 from=$item3}
                        "{$key4}":"{$item4}" ,
                    {/foreach}
                    }, 
            {/foreach}
            }, 
        {/foreach}
        },
    {/foreach}
}
