Sidekiq.configure_client do |config|
  Rails.application.config.after_initialize do
    jobs = [
       Sidekiq::Cron::Job.new(name: 'PersonUpdater', cron: '0 1 * * *', class: PersonUpdaterWorker),
       Sidekiq::Cron::Job.new(name: 'BuildingUpdater', cron: '0 1 * * *', class: BuildingUpdaterWorker)
    ]

    jobs.map{ |job| p job.errors unless job.save }
  end
end
