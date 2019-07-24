require 'custom_fields_controller'

module Exonit
  module Redmine
    module Patches
      module CustomFieldsControllerPatch
        def self.included(base)
          base.class_eval do
            skip_before_filter :require_admin, :only => :index
          end
        end
      end
    end
  end
end

unless CustomFieldsController.included_modules.include? Exonit::Redmine::Patches::CustomFieldsControllerPatch
  CustomFieldsController.send(:include, Exonit::Redmine::Patches::CustomFieldsControllerPatch)
end
