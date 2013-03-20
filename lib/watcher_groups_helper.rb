# encoding: utf-8

module WatcherGroupsHelper


  # Returns the css class used to identify watch links for a given +object+
  def watcher_group_css(object)
    "#{object.class.to_s.underscore}-#{object.id}-watcher_group"
  end

  # Displays a link to gruop's account page if active
  def link_to_group(group, options={})
    if group.is_a?(Group)
      name = h(group.name) # (options[:format]))
      # if group.active?  # || (User.current.admin? && user.logged?)
      #   link_to name, user_path(user), :class => user.css_classes
      # else
        name
      # end
    else
      h(group.to_s)
    end
  end

  # Returns a comma separated list of users watching the given object
  def watcher_groups_list(object)
    remove_allowed = User.current.allowed_to?("delete_#{object.class.name.underscore}_watchers".to_sym, object.project)
    content = ''.html_safe
    
    lis = object.watcher_groups.collect do |group|
      s = ''.html_safe
      # s << avatar(user, :size => "16").to_s
      s << link_to_group(group, :class => 'group')
      if remove_allowed
        url = {:controller => 'watcher_groups',
               :action => 'destroy',
               :object_type => object.class.to_s.underscore,
               :object_id => object.id,
               :group_id => group}
        s << ' '
        s << link_to(image_tag('delete.png'), url,
                     :remote => true, :method => 'post', :style => "vertical-align: middle", :class => "delete")
      end
      content << content_tag('li', s)
    end
    content.present? ? content_tag('ul', content) : content
  end

  def watcher_groups_checkboxes(object, groups, checked=nil)
    groups.map do |group|
      
      c = checked.nil? ? object.watched_by_group?(group) : checked
      tag = check_box_tag 'issue[watcher_group_ids][]', group.id, c, :id => nil
      content_tag 'label', "#{tag} #{h(group)}".html_safe,
                  :id => "issue_watcher_group_ids_#{group.id}",
                  :class => "floating"
    end.join.html_safe
  end
end
