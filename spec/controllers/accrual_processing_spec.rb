require 'rails_helper'

RSpec.describe 'AccrualProcessor.get_names' do
  let(:lp) do
    FactoryBot.create(:loyalty_program)
  end

  let(:lpd) do
    FactoryBot.create(:loyalty_program_datum, account_id: user.account.id, loyalty_program_id: lp.loyalty_program_id)
  end

  let(:user) do
    FactoryBot.create(:user)
  end

  let(:account) do
    FactoryBot.create(:account)
  end

  before(:each) do
    @lpd = double('loyalty_program_datum')
    allow(@lpd).to receive('loyalty_program') { lp }
    allow(@lpd).to receive('loyalty_program_id') { lp.loyalty_program_id }
    allow(@lpd).to receive('account') { account }
    @transaction = double('transaction')
    allow(@transaction).to receive('loyalty_program_datum') { @lpd }
    allow(@transaction).to receive('amount') { rand 100 }
    allow(@transaction).to receive('id') { rand 10_000 }
    allow(@transaction).to receive('loyalty_program_id') { lp.loyalty_program_id }
  end

  context 'whenever called' do
    it 'should return correct date string in YYYYMMDD format at index 0' do
      time = Time.new
      names_array = AccrualProcessor.get_names(@transaction)
      date_str = names_array[0]
      expect(date_str.length).to be 8
      expect(date_str).to eq "#{time.year}#{'%02d' % time.month}#{'%02d' % time.day}"
    end

    it 'should return correct date string in YYYY-MM-DD format at index 1' do
      time = Time.new
      names_array = AccrualProcessor.get_names(@transaction)
      date_str = names_array[1]
      expect(date_str.length).to be 10
      expect(date_str).to eq "#{time.year}-#{'%02d' % time.month}-#{'%02d' % time.day}"
    end
  end

  context 'when given a valid complete transaction' do
    it 'should return correct company code represented by loyalty_program_id at index 2' do
      names_array = AccrualProcessor.get_names(@transaction)
      company_code = names_array[2]
      expect(company_code).to be_instance_of(String)
      expect(company_code).to eq @lpd.loyalty_program_id
    end

    it 'should return correct accrual file path at index 3' do
      names_array = AccrualProcessor.get_names(@transaction)
      filepath = names_array[3]
      company_code = names_array[2]
      date_str = names_array[0]
      expect(filepath).to eq "./tmp/accruals/#{company_code}_#{date_str}.txt"
    end

    it 'should return correct handback file name at index 4' do
      names_array = AccrualProcessor.get_names(@transaction)
      handback_name = names_array[4]
      company_code = names_array[2]
      date_str = names_array[0]
      expect(handback_name).to eq "#{company_code}_#{date_str}.HANDBACK.txt"
    end
  end
end

RSpec.describe 'AccrualProcessor.create_new_accrual' do
  before(:each) do
    @date_str1 = '20000405'
    @date_str2 = '2000-04-05'
    @company_code = 'sutd'
    @filepath = "./tmp/accruals/#{@company_code}_#{@date_str1}.txt"
    @handback_name = "#{@company_code}_#{@date_str1}.HANDBACK.txt"
    File.delete(@filepath) if File.exist?(@filepath)
    AccrualProcessor.create_new_accrual(@date_str1, @date_str2, @company_code, @filepath, @handback_name)
  end
  context 'when given a set of names' do
    it 'should create new csv file with correct name' do
      # AccrualProcessor.create_new_accrual(@date_str1,@date_str2,@company_code,@filepath,@handback_name)
      expect(File.exist?(@filepath)).to be true
    end

    it 'should write correct header' do
      # AccrualProcessor.create_new_accrual (@date_str1,@date_str2,@company_code,@filepath,@handback_name)
      expect(File.exist?(@filepath)).to be true
      content = IO.readlines(@filepath)
      expect(content).to be_instance_of(Array)
      expect(content.length).to be 1
      expect(content[0]).to eq "index,Member ID,Member first name,Member last name,Transfer date,Amount,Reference number,Partner code\n"
    end

    it 'should reset index of the csv file' do
      indices = AccrualProcessor.get_CURRENT_INDICES
      expect(indices[@company_code]).to be 1
    end
  end
end

RSpec.describe 'AccrualProcessor.write_accrual' do
  let(:lp) do
    FactoryBot.create(:loyalty_program)
  end

  let(:user) do
    FactoryBot.create(:user)
  end

  let(:account) do
    FactoryBot.create(:account)
  end

  before(:each) do
    @lpd = double('loyalty_program_datum')
    allow(@lpd).to receive('loyalty_program') { lp }
    allow(@lpd).to receive('account') { account }
    allow(@lpd).to receive('loyalty_program_id') { lp.loyalty_program_id }

    @transaction = double('transaction')
    allow(@transaction).to receive('loyalty_program_datum') { @lpd }
    allow(@transaction).to receive('amount') { rand 100 }
    allow(@transaction).to receive('id') { rand 10_000 }
    allow(@transaction).to receive('account_id') { user.account.id }
    allow(@transaction).to receive('loyalty_program_id') { lp.loyalty_program_id }

    @date_str1, @date_str2, @company_code, @filepath, @handback_name = AccrualProcessor.get_names(@transaction)
    File.delete(@filepath) if File.exist?(@filepath)
    AccrualProcessor.create_new_accrual(@date_str1, @date_str2, @company_code, @filepath, @handback_name)
  end
  context 'when given a set of names and a valid transaction' do
    it 'should write to the csv file at correct index' do
      10.times do
        AccrualProcessor.write_accrual(@date_str1, @date_str2, @company_code, @filepath, @handback_name,
                                       @transaction)
      end

      content = IO.readlines(@filepath)
      idx = 0
      content.each do |line|
        if idx == 0
          # skip header
          idx += 1
        else
          fields = line.split(',')
          expect(fields.length).to be 8
          expect(fields[0]).to eq idx.to_s
          idx += 1
        end
      end
    end
  end
end

# RSpec.describe 'AccrualProcessor.process_handback' do

# end
