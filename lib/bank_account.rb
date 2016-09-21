class Bank

  attr_reader :current_transaction
  attr_reader :balance
  attr_reader :transactions

  def initialize
    @balance = 0
    @transactions = []
  end

  def deposit(amount)
    (amount >= 0) ? (@balance += amount) : raise('You can not deposit a negative amount')
    self.data(amount, 'deposit')
  end

  def withdraw(amount)
    (amount >= 0) ? (@balance -= amount) : raise('You can not withdraw a negative amount')
    self.data(amount, 'withdraw')
  end

  def statement
    top = "date || credit || debit || balance\n"
    list = ""
    @transactions.reverse_each do |transaction|
      if transaction[:type] == 'deposit'
        list += transaction[:date] + " || " + '%.2f' % transaction[:amount].to_s + " || || " + '%.2f' % transaction[:balance].to_s + "\n"
      else
        list += transaction[:date] + " || || " + '%.2f' % transaction[:amount].to_s + " || " + '%.2f' % transaction[:balance].to_s + "\n"
      end
    end
    top + list
  end

  def data(amount, type)
    @current_transaction = {}
    @current_transaction[:type] = type
    @current_transaction[:date] = Time.now.strftime("%d/%m/%Y")
    @current_transaction[:amount] = amount
    @current_transaction[:balance] = @balance
    @transactions << @current_transaction
  end
end

# COMMENTS
# Time class has not been properly stubbed and tested
# Statement could have a class of its own
# data method could be privatised
# still need to define whether it is a deposit or a withdrawal and put under correct column
