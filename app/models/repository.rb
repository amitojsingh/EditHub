class Repository < ApplicationRecord
has_attached_file :upload,
default_url: "/public/missing/:upload" 
validates_attachment_content_type :upload, :content_type => ["application/zip"]

end
