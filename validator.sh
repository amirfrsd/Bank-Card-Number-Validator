while getopts p: option
    do
        case "${option}"
    in
        p) PAN=${OPTARG};;
    esac
done
verify_card_pan () {
    echo "processing pan " $1;
    length=${#1}
    sub_string=${1:15:1}
    sub_string_one=${1:1:10}
    sub_string_two=${1:10:6}
    check=$sub_string
    s=0
    if [ ${#1} -lt 16 ]; then return 0; fi;
    if [ $sub_string_one -eq 0 ]; then return 0; fi;
    if [ $sub_string_two -eq 0 ]; then return 0; fi;
    for i in `seq 0 15`;
        do
            sub_str=${1:i:1};
            if [ $(($i % 2)) -eq 0 ]; then k=2; else k=1; fi;
            d=$(($sub_str * $k));
            if [ $d -gt 9 ]; then s=$(($s+$d-9)); else s=$(($s+$d)); fi;
        done
    if [ $(($s%10)) -eq 0 ]; then echo "pan is valid"; else echo "pan is not valid"; fi;
}
verify_card_pan $PAN;