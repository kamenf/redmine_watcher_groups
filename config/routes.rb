# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
  match 'watcher_groups/new', :controller=> 'watcher_groups', :action => 'new', :via => :get
  match 'watcher_groups', :controller=> 'watcher_groups', :action => 'create', :via => :post
  match 'watcher_groups/append', :controller=> 'watcher_groups', :action => 'append', :via => :post
  match 'watcher_groups/destroy', :controller=> 'watcher_groups', :action => 'destroy', :via => :post
  # match 'watcher_groups/watch', :controller=> 'watcher_groups', :action => 'watch', :via => :post
  # match 'watcher_groups/unwatch', :controller=> 'watcher_groups', :action => 'unwatch', :via => :post
  match 'watcher_groups/autocomplete_for_group', :controller=> 'watcher_groups', :action => 'autocomplete_for_group', :via => :get 
