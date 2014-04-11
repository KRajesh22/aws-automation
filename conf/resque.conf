#!/bin/sh -e
### BEGIN INIT INFO
# Provides:		resque
# Required-Start:	$local_fs $remote_fs
# Required-Stop:	$local_fs $remote_fs
# Should-Start:		$local_fs
# Should-Stop:		$local_fs
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	resque - a Redis-backed Ruby library for creating background jobs
# Description:		resque - a Redis-backed Ruby library for creating background jobs, placing those jobs on multiple queues, and processing them later.
### END INIT INFO

set -e

. /lib/lsb/init-functions

NAME="APP_NAME"
ROOT="/data/APP_NAME/current"
USER="APP_USER"
GROUP="APP_USER"
ENVIRONMENT="production"
QUEUES="*"
COUNT=APP_WORKER_COUNT

BUNDLER="/home/APP_NAME/.rbenv/shims/bundle"
# RAKE="/usr/bin/rake"
# TASK="resque:work"
WORK="./bin/resque work"
PIDFILE="$ROOT/tmp/pids/resque_worker.%d.pid"

start() {
	local program
	local options

	if test -f $ROOT/Gemfile.lock; then
		program="$BUNDLER"
		options="exec $WORK"
	else
		program="$RAKE"
		options="$WORK"
	fi

	options="$options --queues=$QUEUES --pid_file=$pidfile"

	for i in $(seq 1 $COUNT); do
		pidfile=$(printf "$PIDFILE" $i)

		if start-stop-daemon --start --background --quiet --pidfile $pidfile --chdir $ROOT --chuid $USER:$GROUP --exec $program -- $options
		then
			log_daemon_msg "Starting worker #$i for $NAME ..."
		else
			log_failure_msg "Failed to start worker #$i for $NAME!"
		fi
	done
}

stop() {
	local pidfile

	for i in $(seq 1 $COUNT); do
		pidfile=$(printf "$PIDFILE" $i)

		if start-stop-daemon --stop --quiet --oknodo --pidfile $pidfile
		then
			log_daemon_msg "Stopped Resque worker #$i for $NAME"
			rm -f $pidfile
		else
			log_failure_msg "Failed to stop Resque worker #$i for $NAME!" >&2
		fi
	done
}

status() {
	local pidfile

	for i in $(seq 1 $COUNT); do
		pidfile=$(printf "$PIDFILE" $i)

		status_of_proc -p $pidfile "rake $TASK" "$NAME worker #$i"
	done
}

case "$1" in
	start)	start ;;
	stop)	stop ;;
	restart|force-reload)
		stop
		sleep 1
		start
		;;
	status) status ;;
	*)
		echo "Usage: $0 {start|stop|restart|force-reload|status}" >&2
		exit 1
		;;
esac
