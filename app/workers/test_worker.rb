class TestWorker
  include Sidekiq::Worker
  # Optional: specify a queue
  sidekiq_options queue: 'default'

  def perform(name, count)
    puts "Job's done! Hello #{name}, count is #{count}"
  end
end