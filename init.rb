require 'redmine' 

require_dependency 'watcher_groups_helper_patch' 
require_dependency 'watcher_groups/views_issues_hook'
require_dependency 'watcher_groups_helper' 

Rails.logger.info 'Starting Watcher Groups plugin for Redmine'
 

Rails.configuration.to_prepare do

    if Issue.method_defined?(:notified_watchers)
       Issue.send(:include, WatcherGroupsWatcherHelperPatch)
    end

end

Redmine::Plugin.register :redmine_watcher_groups do
  name 'Redmine Watcher Groups plugin'
  author 'Kamen Ferdinandov'
  description 'This is a plugin for Redmine to add wathcer groups functionality'
  version '0.0.1'
  url 'http://'
  author_url 'kamenf'
end
