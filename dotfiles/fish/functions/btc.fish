# Use bitpay to get the current value of BTC

function btc -d "btc [<value>]"
    set btc (http https://bitpay.com/api/rates | jq '.[2].rate')
    set mul $argv[1]

    if string match -r "[\d\.]+" $mul > /dev/null
        set res (math -s6 $mul / $btc)
        echo "$mul EUR = $res BTC"
    else
        echo -ne $btc
        echo " EUR = 1 BTC"
    end
end
