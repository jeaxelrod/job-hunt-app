class JobUpload < ActiveRecord::Base
  belongs_to :job
  validates :upload_content_type, inclusion: { in: %w(doc docx pdf), message: "%{value} is not a valid file format"  }
end
