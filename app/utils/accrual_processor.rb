class AccrualProcessor

    @@current_index=1
    def AccrualProcessor.convert_to_accrual(transaction)
        time = Time.new()
        date_str1 = "#{time.year}#{time.month}#{time.day}"  #YYYYMMDD format, used for file name
        date_str2 = "#{time.year}-#{time.month}-#{time.day}"  #YYYY-MM-DD format, used for csv field
        company_code = transaction.loyalty_program_datum.loyalty_program.id
        filepath = "./#{company_code}_#{date_str1}.txt"


        if (!File::exists?(filepath) or File.zero?(filepath))
            new_file = File.new(filepath,"w")
            new_file.syswrite("index,Member ID,Member first name,Member last name,Transfer date,Amount,Reference number,Partner code\n")
            @@current_index=1
            new_file.close()
        end
        accrual_file = File.open(filepath,"a")
        accrual_file.syswrite("#{@@current_index},#{transaction.loyalty_program_datum.account.id},#{transaction.loyalty_program_datum.account.user.name},#{transaction.loyalty_program_datum.account.user.lastname},#{transaction.date},#{transaction.amount},#{date_str1}#{@@current_index},#{company_code}\n")

        @@current_index+=1
        
    end 

    def AccrualProcessor.retrieve_handback()
    end 
end
