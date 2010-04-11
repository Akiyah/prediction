class CreateBets < ActiveRecord::Migration
  def self.up
    create_table :bets do |t|
      t.integer :point

      t.integer :answer_index

      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :bets
  end
end
