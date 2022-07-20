class DownloadHandbackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "perform download"
    system "cmdftp -s:drivehq_retrieve.txt -%filename:#{args[0]}"
    puts "download ended"
    # TODO: move the downloaded file to desinated folder
    Thread.new (AccrualProcessor.process_handback("./#{args[0]}"))
  end

end
