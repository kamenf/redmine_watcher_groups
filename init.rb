require 'redmine' 

require_dependency 'watcher_groups/views_issues_hook'
require_dependency 'watcher_groups_helper' 

Rails.logger.info 'Starting Watcher Groups plugin for Redmine'
 

Rails.configuration.to_prepare do

  unless Issue.included_modules.include?(WatcherGroupsIssuePatch)
    Issue.send(:include, WatcherGroupsIssuePatch)
  end

  unless IssuesController.included_modules.include?(WatcherGroupsIssuesControllerPatch)
    IssuesController.send(:include, WatcherGroupsIssuesControllerPatch)
  end

end

Redmine::Plugin.register :redmine_watcher_groups do
  name 'Redmine Watcher Groups plugin'
  author 'Kamen Ferdinandov, Massimo Rossello'
  description 'This is a plugin for Redmine to add watcher groups functionality'
  version '1.0.1'
  url 'http://github.com/maxrossello/redmine_watcher_groups'
  author_url 'http://github.com/maxrossello'
end
