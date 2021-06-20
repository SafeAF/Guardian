# Guardian
Guardian Proto IDS. Uses inotify subsystem in linux to detect changes in files and directories and reports them to a backend server. Backend implemented using microservices and redis pubsub. Rails UI.

# Installation
 1. Gem install rb-intofiy, redis, connection_pool
 2. Use daemonization script bin/guardianD to execute 
   - Usage: ruby guardianD start|restart|stop <directories/,to/,/monitor/> (optional args)


# Development
 1. Clone
 2. Either create an issue (search first) or select one listed under issues, optionally ask for issue to be assigned to you.
 3. Make changes
 3. Create a pull request and submit
 
