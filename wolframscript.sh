#!/bin/bash
tag=${WOLFRAM_VERSION:-"latest"}
image="wolframresearch/wolframengine:${tag}"
mathpass_volume="mathpass"
#user=$(docker run -it --rm ${image} id -un | xargs echo)
user="wolframengine"
mathpass_dir="/home/$user/.WolframEngine/Licensing/"

docker volume inspect ${mathpass_volume} > /dev/null
if [ $? -ne 0 ]
then
docker volume create ${mathpass_volume} > /dev/null

#mathpass_dir=/root/.WolframEngine/Licensing
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} --user root ${image} chown ${user} -R ${mathpass_dir} > /dev/null

# will not work
# docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -authenticate ${username} ${password}
# also will not work
# docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -username '${username}' -password '${password}' -activate


if [[ -n "${WOLFRAM_USERNAME}" ]] && [[ -n "${WOLFRAM_PASSWORD}" ]]
then
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} bash -c "wolframscript -authenticate '${WOLFRAM_USERNAME}' '${WOLFRAM_PASSWORD}' && wolframscript -activate" > /dev/null
else
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -activate
fi


# this will work
#docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript -activate
fi
docker run -it --rm -v ${mathpass_volume}:${mathpass_dir} ${image} wolframscript $@