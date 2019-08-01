class BuildingUpdaterWorker
  include Sidekiq::Worker

  def perform
    file = Rails.root.join('app/resources/building.csv')

    CsvParser::Import.call(file: file, model: Building)
  end
end
