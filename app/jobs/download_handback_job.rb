class DownloadHandbackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # args[0] is handback file name, args[1] is the folder
    puts "perform download"
    system "cmdftp -s:drivehq_retrieve.txt -%filename:#{args[0]}"
    new_path = "#{args[1]}#{args[0]}"
    File.rename "./#{args[0]}", new_path
    puts "handback location: #{new_path}"
    if (File::exist?(new_path))
      AccrualProcessor.process_handback(new_path)
    else
      puts "downloaded handback not found!!!!!"
    end 
    
    puts "download ended"
  end

end
