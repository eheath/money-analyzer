class UploadTransactionsController < ApplicationController
  def index
  end


def upload
  uploaded_io = params[:person][:picture]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
    file.write(uploaded_io.read)
  end
end

  def create
    uploaded_io = params[:csv_file]
    tmp_upload_path = Rails.root.join('tmp', 'uploads')
    FileUtils.mkdir_p(tmp_upload_path)
    hashed_filename = "#{current_user.id}_#{SecureRandom.hex(10)}.csv"
    File.open(Rails.root.join(tmp_upload_path, hashed_filename), 'w') do |f|
      f.write(uploaded_io.read)
    end
    ImportTransactionsJob
      .perform_now(File.join(tmp_upload_path, hashed_filename))
  end
end
