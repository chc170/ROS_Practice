# Xquartz stuff
xquartz_if_not_running() {
  v_nolisten_tcp=$(defaults read org.macosforge.xquartz.X11 nolisten_tcp)
  v_xquartz_app=$(defaults read org.macosforge.xquartz.X11 app_to_run)

  if [ $v_nolisten_tcp == "1" ]; then
    defaults write org.macosforge.xquartz.X11 nolisten_tcp 0
  fi

  if [ $v_xquartz_app != "/usr/bin/true" ]; then
    defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
  fi

  netstat -an | grep 6000 &> /dev/null || open -a XQuartz
  while ! netstat -an \| grep 6000 &> /dev/null; do
    sleep 2
  done
  export DISPLAY=:0
}

dockerchrome() {
  xquartz_if_not_running
  docker_if_not_running
  xhost +$(docker-machine ip ${C_DOCKER_MACHINE})

  docker run \
    --rm \
    --memory 512mb \
    --net host \
    --security-opt seccomp:unconfined \
    -e DISPLAY=$(docker-machine inspect ${C_DOCKER_MACHINE} --format={{.Driver.HostOnlyCIDR}} | cut -d'/' -f1):0 \
    jess/chrome
}
