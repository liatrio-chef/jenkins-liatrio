#
# Cookbook Name:: jenkins-liatrio
# Recipe:: configure_global_env
#
# Author: Drew Holt <drew@liatrio.com>
#

# load encrypted data bag
jenk_databag = Chef::EncryptedDataBagItem.load('jenkins', 'cred')

# configure administrator eglobal_env and mail server configuration
jenkins_script 'configure global_env' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.*
    import jenkins.model.*
    import hudson.*
    import hudson.model.*

    instance = Jenkins.getInstance()
    globalNodeProperties = instance.getGlobalNodeProperties()
    envVarsNodePropertyList = globalNodeProperties.getAll(hudson.slaves.EnvironmentVariablesNodeProperty.class)

    newEnvVarsNodeProperty = null
    envVars = null

    if ( envVarsNodePropertyList == null || envVarsNodePropertyList.size() == 0 ) {
      newEnvVarsNodeProperty = new hudson.slaves.EnvironmentVariablesNodeProperty();
      globalNodeProperties.add(newEnvVarsNodeProperty)
      envVars = newEnvVarsNodeProperty.getEnvVars()
    } else {
      envVars = envVarsNodePropertyList.get(0).getEnvVars()

    }

    envVars.put("DEV_BOX", "false")
    envVars.put("GIT_AUTH_TOKEN", "#{jenk_databag['GIT_AUTH_TOKEN']}")
    envVars.put("USE_FOLDERS", "true")

    instance.save()
   EOH
  notifies :create, 'ruby_block[set the global_env_configured flag]', :immediately
  not_if { node.attribute?('global_env_configured') || ::File.file?("#{node[:jenkins][:master][:home]}/global_env_configured") }
  sensitive true
end

# Set the security enabled flag and set the run_state to use the configured private key
ruby_block 'set the global_env_configured flag' do
  block do
    node.set['global_env_configured'] = true
    Chef::Config[:solo] ? ::FileUtils.touch("#{node[:jenkins][:master][:home]}/global_env_configured") : node.save
  end
  action :nothing
end
