class AddAttachmentZipUploadToRepositories < ActiveRecord::Migration
  def self.up
    change_table :repositories do |t|
      t.attachment :zip_upload
    end
  end

  def self.down
    remove_attachment :repositories, :zip_upload
  end
end
