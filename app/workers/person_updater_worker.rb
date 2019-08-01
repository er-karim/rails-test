class PersonUpdaterWorker
  include Sidekiq::Worker

  def perform
    file = Rails.root.join('app/resources/person.csv')

    CsvParser::Import.call(file: file, model: Person)
  end
end
