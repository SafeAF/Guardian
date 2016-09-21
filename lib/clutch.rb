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
<<EOL
    {one line to give the program's name and a brief idea of what it does.}
    Copyright (C) {year}  {name of author}

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
## insert optionparser code instead of argv reads
EOL

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
