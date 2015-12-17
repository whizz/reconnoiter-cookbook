# reconnoiter cookbook

A Chef library cookbook, providing LWRPs to create and maintain
Reconnoiter checks with your infrastructure.


## Usage

In your environment (usually), you should set attribute values
for your noit server:

  * `node[:reconnoiter][:noit_host]`
  * `node[:reconnoiter][:noit_port]`
  * `node[:reconnoiter][:noit_schema]`
  
In your infrastructure cookbooks, you can use the LWRPs to create
Reconnoiter checks automatically. See the `resmon_basic.erb` for
example usage.

The `reconnoiter_check` resource has there options, corresponding
to their noit counterpart (default value in brackets):

  * `name` - check name in noit (default)
  * `section` - location within noit tree (chef-managed)
  * `noit_module` - check module (resmon)
  * `config` - configuration variables [hash] (none)
  * `target` - check target (node[:fqdn])
  * `filterset` - check filterset (default)
  * `period` - check period in milliseconds (60000)
  * `timeout` - check timeout in milliseconds (30000)
  * `noit_host` - hostname or IP address of noit server (`node[:reconnoiter][:noit_host]`)
  * `noit_port` - server port (`node[:reconnoiter][:noit_port]`)
  * `noit_schema` - url schema, http or https (http)
 
 The check, when created, will store the check UUID in the node 
 adttributes, so it can be updated later on.
 
 
 ## Known issues
 
 When chef-client run ends with an error during the run where the
 check is created, chef will not store the UUID in the node attributes.
 But the check is already created in the noit server and when you run
 chef-client again, it will fail and complain that the check already
 exists (actually it will fail with an HTTP 500). You have to manually
 remove the check from noit server first.
 
 
 ## License and Author

  * Author: Michal Taborsky <michal@taborsky.cz>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0`

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
 