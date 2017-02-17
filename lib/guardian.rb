require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'
require 'thread'
require 'rb-inotify'
#require 'drb'
#require 'rinda'

BEGIN{
$hostname = `hostname`.chomp!
$options = {}


$options[:host] = ARGV[0] || '10.0.1.75'
$options[:db] = 1
$options[:port] = ARGV[1] || '6379'
$options[:hooker] = ARGV[2] || '/etc/'

$logger = Logger.new('enque.log', 'a+')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:db]})}

$r = Redis::List.new('system:notifications', :marshal => true) #, :expiration => 5)
$spool = Redis::List.new('system:log:spool', :marshal => true)  # for end of day mailer

$archive = Redis::List.new('system:log:archive', :marshal => true)
}
