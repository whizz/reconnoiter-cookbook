require 'chef/mixin/shell_out'
require 'chef/mixin/language'
require 'securerandom'
include Chef::Mixin::ShellOut

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

def load_current_resource
  @name = new_resource.name || 'default'
  if node[:reconnoiter][:uuid].key?(@name)
    @uuid = node[:reconnoiter][:uuid][@name]
  else
    @uuid = SecureRandom.uuid
    node.set[:reconnoiter][:uuid][@name] = @uuid
  end
  @noit_module = new_resource.noit_module || 'resmon'
  @target = new_resource.target || node[:fqdn]
  @section = new_resource.section || 'chef-managed'
  @period = new_resource.period || 60000
  @timeout = new_resource.timeout || 30000
  @filterset = new_resource.filterset || 'default'
  @config = new_resource.config || {}
  @noit_host = new_resource.noit_host || node[:reconnoiter][:noit_host] || 'localhost'
  @noit_port = new_resource.noit_port || node[:reconnoiter][:noit_port] || '8888'
  @noit_schema = new_resource.noit_schema || node[:reconnoiter][:noit_schema] || 'http'
end

action :create do
  converge_by("Create reconnoiter check #{ @new_resource }") do
    create_check
  end
end

def build_payload
  r = '<check>' +
    '<attributes>'+
    "<name>#{@name}</name>"+
    "<module>#{@noit_module}</module>"+
    "<target>#{@target}</target>"+
    "<period>#{@period}</period>"+
    "<timeout>#{@timeout}</timeout>"+
    "<filterset>#{@filterset}</filterset>"+
    "</attributes>"+
    "<config>"
  @config.each do |key,val|
     r = r + "<#{key}>#{val}</#{key}>"   
  end
   r = r + "</config>"+
     "</check>"
   r
end

def create_check
  noit_url = "#{@noit_schema}://#{@noit_host}:#{@noit_port}"
  noit_url = noit_url + "/checks/set/#{@section}/#{@uuid}"

  if node[:reconnoiter][:enable_checks]
    http_request "create_check_#{@name}" do
      url noit_url
      action :put
      message build_payload
    end
  else
    Chef::Log.info("Reconnoiter checks are disabled")
  end
end