class SendAccrualJob < ApplicationJob

  queue_as :default

  def perform(*args)
    # Do something later
    path = args[0][2..args[0].length]
    path = path.gsub("/","\\")
    puts "uploading #{path}"

    system "cmdftp -s:drivehq_send.txt -%filepath:#{path}" 
    
  end
end
