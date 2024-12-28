class ImportTransactionsJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    user = User.find(File.basename(file_path).split('_').first)
    return false if user.blank?
    SmarterCSV.process(file_path).each do |hash|
      user.user_transactions.create({
        transaction_date: Date.parse(hash[:date]),
        description: hash[:description],
        debit: hash[:debit],
        credit: hash[:credit]
      })
    end
  end
end
