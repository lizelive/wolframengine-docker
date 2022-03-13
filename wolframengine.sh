#!/bin/sh
image="13.0.0-cuda"
image="wolframresearch/wolframengine:${image}"
mathpass_volume="mathpass"
#user=$(docker run -it --rm ${image} id -un | xargs echo)
user="wolframengine"
mathpass_dir="/home/$user/.WolframEngine/Licensing/"

docker volume inspect ${mathpass_volume} > /dev/null
if [ $? -ne 0 ]
then
docker volume create ${mathpass_volume}

#mathpass_dir=/root/.WolframEngine/Licensing
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} --user root ${image} chown ${user} -R ${mathpass_dir}

# will not work
# docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -authenticate ${username} ${password}
# also will not work
# docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -username '${username}' -password '${password}' -activate

# this will work
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} bash -c "wolframscript -authenticate '${username}' '${password}' && wolframscript -activate"
#docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -activate
fi
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript

