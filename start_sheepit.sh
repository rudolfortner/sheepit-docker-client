#!/bin/bash

add_arg () {
    CMD_ARG=$1
    CMD_VAL=$2
    if [ -n "$CMD_VAL" ]; then
        COMMAND="$COMMAND $CMD_ARG $CMD_VAL"
    fi
}

COMMAND="java -jar sheepit.jar"

add_arg "-cache-dir"		$SHEEPIT_CACHE_DIR
add_arg "-compute-method"	$SHEEPIT_COMPUTE_METHOD
add_arg "-config"			$SHEEPIT_CONFIG
add_arg "-cores"			$SHEEPIT_CORES
add_arg "-extras"			$SHEEPIT_EXTRAS
add_arg "-gpu"				$SHEEPUT_GPU
add_arg "-hostname"			$SHEEPIT_HOSTNAME
add_arg "-login"			$SHEEPIT_LOGIN
add_arg "-memory"			$SHEEPIT_MEMORY
add_arg "-password"			$SHEEPIT_PASSWORD
add_arg "-priority"			$SHEEPIT_PRIORITY
add_arg "-proxy"			$SHEEPIT_PROXY
add_arg "-rendertime"		$SHEEPIT_RENDERTIME
add_arg "-request-time"		$SHEEPIT_REQUEST_TIME
add_arg "-server"			$SHEEPIT_SERVER
add_arg "-shared-zip"		$SHEEPIT_SHARED_ZIP
add_arg "-shutdown"			$SHEEPIT_SHUTDOWN
add_arg "-shutdown-mode"	$SHEEPIT_SHUTDOWN_MODE
add_arg "-theme"			$SHEEPIT_THEME
add_arg "-title"			$SHEEPIT_TITLE
add_arg "-ui"				$SHEEPIT_UI

${COMMAND}
