actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :section, :kind_of => String
attribute :noit_module, :kind_of => String
attribute :config, :kind_of => Hash
attribute :target, :kind_of => String
attribute :filterset, :kind_of => String
attribute :period, :kind_of => Integer
attribute :timeout, :kind_of => Integer
attribute :noit_host, :kind_of => String
attribute :noit_port, :kind_of => String
attribute :noit_schema, :kind_of => String

