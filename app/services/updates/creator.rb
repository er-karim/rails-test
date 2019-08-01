module Updates
  class Creator < ApplicationService
    attr_reader :record, :model

    def initialize(params)
      @model  = params[:model]
      @record = model.find_by(id: params[:record_id])
    end

    def call
      updates_list = get_update_params()

      return false if updates_list.empty?

      create_updates(updates_list)
    end

    private

    def get_update_params
      result = []

      fields = model::FIELDS_TO_CHECK_BEFORE_UPDATE

      fields.each do |field|
        params = prepare_params(field)
        result << params if Update.not_exists?(params)
      end

      result
    end

    def prepare_params(a_field)
      {
        updatable_type: record.class.name,
        updatable_id: record.id,
        field: a_field.to_s,
        value: record[a_field].downcase
      }
    end

    def create_updates(updates_list)
      sql_insert('updates', ['updatable_type', 'updatable_id', 'field', 'value'], updates_list)
    end
  end
end
