class AddUserToGitrepos < ActiveRecord::Migration[5.0]
  def change
    add_reference :gitrepos, :user, foreign_key: true
  end
end
