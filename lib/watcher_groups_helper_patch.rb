require_dependency 'watcher_groups_helper'

module WatcherGroupsWatcherHelperPatch

    def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
        base.class_eval do
            # unloadable

            alias_method_chain :notified_watchers , :groups

            Rails.logger.info 'WatcherGroupsWatcherHelperPatch monkey-patch'
        end
    end

    IssuesController.class_eval do
      helper :watcher_groups
      include WatcherGroupsHelper
    end


    Issue.class_eval do
    	include WatcherGroupsHelper

    	def watcher_groups
        groups = Watcher.where("watchable_type='#{self.class}' and watchable_id = #{self.id}")
        return [] if groups.empty?
        Group.where(id: groups.map(&:user_id))
    	end

        # Returns an array of users that are proposed as watchers
        def addable_watcher_groups
          groups = self.project.principals.select{|p| p if p.type=='Group'}
          groups = groups.sort - self.watcher_groups
          if respond_to?(:visible?)
            groups.reject! {|group| !visible?(group)}
          end
          groups
        end

        # Adds group as a watcher
        def add_watcher_group(group)
          if Watcher.where("watchable_type='#{self.class}' and watchable_id = #{self.id} and user_id = '#{group.id}'").limit(1).blank?
            # insert directly into table to avoid user type checking
            Watcher.connection.execute("INSERT INTO `#{Watcher.table_name}` (`user_id`, `watchable_id`, `watchable_type`) VALUES (#{group.id}, #{self.id}, '#{self.class.name}')")
          end
        end

        # Removes user from the watchers list
        def remove_watcher_group(group)
          return nil unless group && group.is_a?(Group)
          Watcher.delete_all "watchable_type = '#{self.class}' AND watchable_id = #{self.id} AND user_id = #{group.id}"
        end

        # Adds/removes watcher
        def set_watcher_group(group, watching=true)
          watching ? add_watcher_group(group) : remove_watcher_group(group)
        end

        # Returns true if object is watched by +user+
        def watched_by_group?(group)
          !!(group && self.watcher_groups.detect {|gr| gr.id == group.id })
        end

    end


    module InstanceMethods

        def notified_watchers_with_groups

            notified = []

            w = Watcher.where("watchable_type='#{self.class}' and watchable_id = #{self.id}")
            groups = Group.where(id: w.map(&:user_id))

            groups.each do |p|
                group_users = p.users.active.to_a
                group_users.reject! {|user| user.mail.blank? || user.mail_notification == 'none'}
                if respond_to?(:visible?)
                  group_users.reject! {|user| !visible?(user)}
                end
                notified += group_users
            end

            notified += notified_watchers_without_groups
            notified.uniq
        end

    end

end
