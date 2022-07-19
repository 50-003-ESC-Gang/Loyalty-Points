class AccrualProcessor

    @@current_index=1
    def AccrualProcessor.convert_to_accrual(transaction)
        time = Time.new()
        date_str1 = "#{time.year}#{time.month}#{time.day}"  #YYYYMMDD format, used for file name
        date_str2 = "#{time.year}-#{time.month}-#{time.day}"  #YYYY-MM-DD format, used for csv field
        company_code = transaction.loyalty_program_data.loyalty_program_id
        filepath = "../../storage/tmp/#{company_code}_#{date_str1}.txt"
        accrual_file = File.open(filepath,"a")
        if (File.zero?(filepath))
            accrual_file.syswrite("index,Member ID,Member first name,Member last name,Transfer date,Amount,Reference number,Partner code")
            @@current_index=1
        end
        accrual_file.syswrite("#{current_index},#{transaction.loyalty_program_data.account_id},#{transaction.loyalty_program_data.account.user.name},#{transaction.loyalty_program_data.account.user.lastname},
            #{transaction.date},#{transaction.amount},#{date_str1}#{current_index},#{company_code}")
            #some notes:
            # not sure what is the correct way of referencing the attributes so please check
            # using loyalty program id as company code and date+index as ref number. don't think it's correct so need to update
        @@current_index+=1
        
    end 

    def AccrualProcessor.retrieve_handback()
    end 
end
