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

echo -e "enter brightness from 0 to 10 (0=very dim): " | tr -d '\n'
#asks user to enter possible brightness

read input
#reads the input brightness

if [ $input -eq 0 ]
then 
    brightness=$input
else
    brightness=$(bc <<< "$input * 25 + 4")
fi
#converts the given value from 0-10 into a brightness from 0-254

curl -s -X PUT --data '{"bri":'$brightness'}' --url <YOUR BRIDGE IP>/api/<YOUR USER ID>/groups/1/action > /dev/null;
#turn all lamps to input brightness