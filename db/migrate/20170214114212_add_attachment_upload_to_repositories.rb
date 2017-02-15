class AddAttachmentUploadToRepositories < ActiveRecord::Migration
  def self.up
    change_table :repositories do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :repositories, :upload
  end
end
