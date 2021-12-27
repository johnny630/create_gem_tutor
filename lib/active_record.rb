module ActiveRecord
  # 拿掉原先的 support
  # autoload :CreateGemTutor, 'create_gem_tutor/support'
  autoload :Base, 'active_record/base'
  autoload :Persistence, 'active_record/persistence'
  autoload :ConnectionAdapter, 'active_record/connection_adapter'
  autoload :Relation, 'active_record/relation'
end
