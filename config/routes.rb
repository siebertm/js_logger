ActionController::Routing::Routes.draw do |map|
  map.connect '/js/logger', {:controller => 'js_logger/logging', :action => 'create'}
end
