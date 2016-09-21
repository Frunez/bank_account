require './lib/bank_account'

describe Bank do

  before(:each) do
    @bank = Bank.new
  end

  describe '#balance' do
    it 'returns current balance' do
      expect(@bank.balance).to be_an Integer
    end
    it 'has an initial bank balance of 0' do
      expect(@bank.balance).to eq 0
    end
  end

  describe '#deposit' do
    it 'increases the balance by the amount stated (ex. 1000)' do
      expect{@bank.deposit(1000)}.to change{@bank.balance}.by(1000)
    end
    it 'does not increase the balance if 0 is deposited' do
      expect{@bank.deposit(0)}.to change{@bank.balance}.by(0)
    end
    it 'does not accept accept negative numbers' do
      expect{@bank.deposit(-1)}.to raise_error "You can not deposit a negative amount"
    end

    context '#current_transaction' do
      before(:each) do
        @bank.deposit(500)
      end
      it 'creates a hash of data for current withdrawal' do
        expect(@bank.current_transaction).to be_a Hash
      end
      it 'stores date, amount and balance into the hash' do
        time = Time.now.strftime("%d/%m/%Y")
        expect(@bank.current_transaction).to include(:date => time, :amount => 500, :balance => 500)
      end

      # it 'stores the date in a correct format' do
      #   @withdraw_time = Time.local(2012, 1, 14)
      #   allow(Time).to receive(:now).and_return(@withdraw_time)
      #   expect(@bank.current_transaction[:date]).to eq '14/01/2012'
      # end

    end
  end

  describe '#withdraw' do
    before(:each) do
      @bank.deposit(500)
    end
    it 'decreases a withdrawn amount from the balance (ex. 500)' do
      expect{@bank.withdraw(500)}.to change{@bank.balance}.by(-500)
    end
    it 'does not decrease the balance if 0 is withdrawn' do
      expect{@bank.withdraw(0)}.to change{@bank.balance}.by(0)
    end
    it 'does not accept accept negative numbers' do
      expect{@bank.withdraw(-1)}.to raise_error "You can not withdraw a negative amount"
    end

    context '#current_transaction' do
      before(:each) do
        @bank.withdraw(500)
      end
      it 'creates a hash of data for current withdrawal' do
        expect(@bank.current_transaction).to be_a Hash
      end
      it 'stores date, amount and balance into the hash' do
        time = Time.now.strftime("%d/%m/%Y")
        expect(@bank.current_transaction).to include(:date => time, :amount => 500, :balance => 0)
      end
    end
  end

  describe '#transactions' do
    before(:each) do
      @bank.deposit(1500)
    end
    it 'stores a hash for each transaction made' do
      expect(@bank.transactions.count).to eq 1
    end
    it 'stores many hashes for all transactions made' do
      @bank.deposit(1500)
      @bank.withdraw(500)
      @bank.withdraw(200)
      @bank.deposit(100)
      expect(@bank.transactions.count).to eq 5
    end
  end

  describe '#statement' do
    before(:each) do
      @bank.deposit(1500)
      @bank.deposit(300)
      @bank.withdraw(500)
    end
    it 'should display a string containing all info about transactions' do
      expect(@bank.statement).to eq "date || credit || debit || balance\n21/09/2016 || || 500.00 || 1300.00\n21/09/2016 || 300.00 || || 1800.00\n21/09/2016 || 1500.00 || || 1500.00\n"
    end
  end
end
