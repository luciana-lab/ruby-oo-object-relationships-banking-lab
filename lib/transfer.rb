require 'pry'
class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  #can initialize a Transfer
  #initializes with a sender
  #initializes with a receiver
  #always initializes with a status of 'pending'
  #initializes with a transfer amount
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  #can check that both accounts are valid
  #calls on the sender and receiver's #valid? methods
  def valid?
    @sender.status == "open" && @sender.balance > 0
    @receiver.status == "open" && @receiver.balance > 0
    sender.valid?
    receiver.valid?
  end

  #can execute a successful transaction between two accounts 
  #each transfer can only happen once
  #rejects a transfer if the sender does not have enough funds (does not have a valid account)
  #used help of https://github.com/learn-co-students/oo-banking-v-000/pull/359/files
  def execute_transaction
    if valid? && @sender.balance > @amount && self.status == "pending"
      @sender.balance = @sender.balance - self.amount
      @receiver.balance = @receiver.balance + self.amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  #can reverse a transfer between two accounts 
  #it can only reverse executed transfers
  def reverse_transfer
    if valid? && @receiver.balance > amount && self.status == "complete"
      @sender.balance = @sender.balance + self.amount
      @receiver.balance = @receiver.balance - self.amount
      self.status = "reversed"
    end
  end

end
