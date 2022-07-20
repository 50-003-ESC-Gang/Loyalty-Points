class SendAccrualJob < ApplicationJob
  config.active_job.queue_adapter = :sidekiq

  queue_as :default

  def perform(*args)
    # Do something later
    puts "task performing"

    system "cmdftp -s:drivehq_send.txt -%filepath:#{args[0]}" 
    
  end
end
