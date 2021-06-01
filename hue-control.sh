#!/bin/bash

curl -s -X PUT --data '{"on":true}' --url <YOUR BRIDGE IP>/api/<YOUR USER ID>/groups/1/action > /dev/null;
#turns on all lights in group 1

rgb=($1 $2 $3)
for i in "${rgb[@]}"
do 
    rgb[$c]=$(bc <<< "scale=3; "$i"/255")
    ((c=c+1))
done 
x=$(bc <<< "scale=3; 0.363 + "${rgb[0]}" * 0.349 + "${rgb[1]}" * -0.173 + "${rgb[2]}" * -0.190" | sed -e 's/^\./0./')
y=$(bc <<< "scale=3; 0.342 + "${rgb[0]}" * -0.034 + "${rgb[1]}" * 0.358 + "${rgb[2]}" * -0.294" | sed -e 's/^\./0./')
#generates xy-value from rgb-value

curl -s -X PUT --data '{"xy":['"$x"', '"$y"']}' --url <YOUR BRIDGE IP>/api/<YOUR USER ID>/groups/1/action > /dev/null;
#turns all lights in group 1 to the given rgb color

echo -e "\nenter brightness (1-254): " | tr -d '\n'
#asks user to enter possible brightness

read brightness
#reads the input brightness

curl -s -X PUT --data '{"bri":'$brightness'}' --url <YOUR BRIDGE IP>/api/<YOUR USER ID>/groups/1/action > /dev/null;
#turn all lamps to input brightness
