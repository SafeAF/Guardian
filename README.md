# Guardian
Guardian Proto IDS. Uses inotify subsystem in linux to detect changes in files and directories and reports them back to our servers for further processing, examination, and or routing by MessageHub to a configurable list of recipients including: Email, SMS, Webhooks, WebUI, Desktop Notifications, and CLI viewer.

# Installation
 1. Gem install rb-intofiy, redis, connection_pool
 2. Use daemonization script bin/guardianD to execute 
   - Usage: ruby guardianD start|restart|stop <directories/,to/,/monitor/> (optional args)
 3. ???
 4. Profit!

# Development
 1. Clone
 2. Either create an issue (search first) or select one listed under issues, optionally ask for issue to be assigned to you (open to non employees)
 3. Make changes
 3. Create a pull request and submit
 

# TODO/Plans

- Read in directories to monitor from /etc/guardian optionally, continue supporting command line opts.
- WebUI
- Connect up to MessageHub
- Give option of using redis pubsub for local distribution of alerts or HTTP for syncing with messagehub
- Installation script
- Clean up code base
- Structure according to expected/standard directory structure
- Expand functionality of parser
