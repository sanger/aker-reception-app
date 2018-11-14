module Transformers
  class ExcelToState < ExcelToArray
    def initialize(options)
      super(options)
      @mapping_service = MappingService.new(options.fetch(:manifest_model), options.fetch(:current_user))
    end

    def contents
      @mapping_service.process_array(@contents)
    end
  end
end
