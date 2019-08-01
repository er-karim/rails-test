require 'csv'

module CsvParser
  class Import < ApplicationService
    attr_reader :file, :model, :fields_mapping

    def initialize(file: '', model: nil)
      @file  = file
      @model = model
    end

    RESULTS = [
      INVALID_INPUTS = :invalid_inputs,
      EMPTY_UPDATE_LIST = :empty_update_list
    ]

    def call
      return INVALID_INPUTS unless valid_inputs?

      @fields_mapping = get_fields_mapping()

      records_update_list = []

      CSV.foreach(file, headers: true) do |row|
        record = model.find_by(reference: row['reference'])

        records_update_list << {record_id: record.id, params: parse(row, record)} unless record.nil?
      end

      return EMPTY_UPDATE_LIST if records_update_list.empty?

      update_records(records_update_list)
    end

    private

    def get_fields_mapping
      model_attributes().each_with_object({}) { |col, h| h[col.to_sym] = col }
    end

    def model_attributes
      model.column_names.reject{|col| ['id', 'created_at', 'updated_at'].include?(col)}
    end

    def valid_inputs?
      file_exists? && model_exists?
    end

    def file_exists?
      File.exist? file
    end

    def model_exists?
      model != nil
    end

    def value_exists?(field, record)
      params = {
        updatable: record,
        field: field.to_s,
        value: record[field].downcase
      }
      !Update.not_exists?(params)
    end

    def parse(row, record)
      result = {}

      fields_mapping.each do |target, source|
        result[target] = row[source]

        model::FIELDS_TO_CHECK_BEFORE_UPDATE.each do |field|
          result.delete_if {|key, val| key == field} if target == field && value_exists?(field, record)
        end
      end

      result
    end

    def update_records(records_update_list)
      updates_count = 0

      model.transaction do
        records_update_list.each do |record_params|
          record = model.update(record_params[:record_id], record_params[:params])

          Updates::Creator.call(model: model, record_id: record.id)

          updates_count += 1
        end
      end

      updates_count
    end
  end
end