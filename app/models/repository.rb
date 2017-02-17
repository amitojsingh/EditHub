class Repository < ApplicationRecord
has_attached_file :upload,
default_url: "/public/"
validates_attachment_content_type :upload, :content_type => ["application/zip"]

end
