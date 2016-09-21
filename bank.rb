stty_save = `stty -g`.chomp

require_relative 'lib/bank_account'

class Interface

  attr_reader :bank

  def initialize
    @bank = Bank.new
  end

  def selection
    puts "Hello, this money place\n1. Give money\n2. Take money\n3. Print statement\n"
    choice = gets.chomp
    self.compute(choice)
  end

  def compute(choice)
    case choice
      when "1"
        puts "How much?\n"
        amount = gets.chomp.to_i
        @bank.deposit amount
        puts "your balance " + @bank.balance.to_s
      when "2"
        puts "How much?\n"
        amount = gets.chomp.to_i
        @bank.withdraw amount
        puts "your balance " + @bank.balance.to_s
      when "3"
        puts "Okay fine\n"
        puts @bank.statement
      when "4"
        puts "Okay fine bye"
        exit
      else
        puts "Why you stupid you had 1 job, put 1 or 2 or 3, simple\n"
        choice = gets.chomp
        self.compute(choice)
      end
      puts "Okay, you not gone yet, why?"
      choice = gets.chomp
      self.compute(choice)
    end
  end

  interface = Interface.new
  interface.selection
