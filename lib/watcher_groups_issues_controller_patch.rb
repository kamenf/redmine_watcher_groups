require_dependency 'watcher_groups_helper' 

module WatcherGroupsIssuesControllerPatch

    def self.included(base) # :nodoc:
        base.class_eval do
          helper :watcher_groups
          include WatcherGroupsHelper
        end
    end

end


