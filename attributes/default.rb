default[:reconnoiter][:noit_host] = "localhost"
default[:reconnoiter][:noit_port] = "8888" 
default[:reconnoiter][:noit_schema] = "http"
default[:reconnoiter][:uuid] = {} 

# this attribute can be used to disable globally the creation of checks
# can be useful in testing and dev environments, so that they do not
# pollute the monitoring server  
default[:reconnoiter][:enable_checks] = true
