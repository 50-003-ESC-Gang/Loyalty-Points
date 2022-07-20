class DownloadHandbackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # args[0] is handback file name, args[1] is the folder
    puts "perform download"
    system "cmdftp -s:drivehq_retrieve.txt -%filename:#{args[0]}"
    puts "download ended"
    # TODO: move the downloaded file to desinated folder
    File.rename "./#{args[0]}", "#{args[1]}#{args[0]}"
    Thread.new (AccrualProcessor.process_handback("#{args[1]}#{args[0]}"))
  end

end
