class CreateGitrepos < ActiveRecord::Migration[5.0]
  def change
    create_table :gitrepos do |t|
      t.string :url

      t.timestamps
    end
  end
end
