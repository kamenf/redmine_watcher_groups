class WatcherGroupsController < ApplicationController

  before_filter :find_project
  # before_filter :require_login, :check_project_privacy, :only => [:watch, :unwatch]
  # before_filter :authorize, :only => [:new, :destroy]

  def new
  end

  def create
    if params[:watcher_group].is_a?(Hash) && request.post?
      group_ids = params[:watcher_group][:group_ids] || [params[:watcher_group][:group_id]]
      group_ids.each do |group_id|
        if Watcher.find(:all, 
           :conditions => "watchable_type='#{@watched.class}' and watchable_id = #{@watched.id} and user_id = '#{group_id}'",
           :limit => 1).blank?
          # insert directly into table to avoid user type checking
          Watcher.connection.execute("INSERT INTO #{Watcher.table_name} (user_id, watchable_id, watchable_type) VALUES (#{group_id}, #{@watched.id}, '#{@watched.class.name}')")
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to_referer_or {render :text => 'Watcher group added.', :layout => true}}
      format.js
    end
  end

  def append
    if params[:watcher_group].is_a?(Hash)
      group_ids = params[:watcher_group][:group_ids] || [params[:watcher_group][:group_id]]
      @groups = Group.active.find_all_by_id(group_ids)
    end
  end

  def destroy
    @watched.set_watcher_group(Group.find(params[:group_id]), false) if request.post?
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def autocomplete_for_group
    @groups = Group.active.like(params[:q]).find(:all, :limit => 100)
    if @watched
      @groups -= @watched.watcher_groups
    end
    render :layout => false
  end

private
  def find_project
    if params[:object_type] && params[:object_id]
      klass = Object.const_get(params[:object_type].camelcase)
      @watched = klass.find(params[:object_id])
      return false unless @watched.respond_to?('watched_by_group?')
      @project = @watched.project
    elsif params[:project_id]
      @project = Project.visible.find_by_param(params[:project_id])
    end
  rescue
    render_404
  end

  def set_watcher_group(group, watching)
    @watched.set_watcher_group(group, watching)
    respond_to do |format|
      format.html { redirect_to_referer_or {render :text => (watching ? 'Watcher group added.' : 'Watcher group removed.'), :layout => true}}
      format.js { render :partial => 'set_watcher_group', :locals => {:group => group, :watched => @watched} }
    end
  end
end
