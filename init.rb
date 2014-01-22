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
  author 'Kamen Ferdinandov, Massimo Rossello'
  description 'This is a plugin for Redmine to add watcher groups functionality'
  version '0.0.2'
  url 'http://github.com/maxrossello/redmine_watcher_groups'
  author_url 'http://github.com/maxrossello'
end
