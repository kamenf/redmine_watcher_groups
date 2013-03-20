module WatcherGroups
  class ViewsIssuesHook < Redmine::Hook::ViewListener     
    include IssuesHelper
    
    def view_issues_sidebar_queries_bottom(context={ })
      if (context[:controller].action_name == 'show') and
         (!context[:request].parameters[:id].blank?)
         
        @issue = Issue.find(context[:request].parameters[:id])
        @project=context[:project]
        context[:controller].send(:render_to_string, {
          :partial => "watcher_groups/watcher_groups_sidebar",
          :locals => context.merge(:watched => @issue)
        })
      end  
    end
  end
end   
