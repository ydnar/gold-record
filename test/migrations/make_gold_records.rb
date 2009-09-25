class MakeGoldRecords < ActiveRecord::Migration
  def self.up
    # Change each int(11) id column to binary(16).
    # This preserves the column’s original value as a right-padded 16-byte string.
    [:users, :blogs, :posts, :comments].each do |table|
      change_integer_primary_key_to_uuid(table)
      add_index table, :id
    end

    # Change association columns to binary(16).
    [
      [:blogs, :user_id],
      [:posts, :blog_id],
      [:posts, :author_id],
      [:comments, :post_id],
      [:comments, :author_id],
    ].each do |table, column|
      change_integer_to_uuid(table, column)
    end
  end


  # Down migration designed to be run immediately after an up migration
  # in the event of some failure. Running this after generating any UUIDs
  # will produce unpredictable results.

  def self.down
    # Change each binary(16) id column to int(11).
    # MySQL casts the string value to an integer.
    [:users, :blogs, :posts, :comments].each do |table|
      remove_index table, :id
      change_uuid_to_integer_primary_key(table)
    end

    # Change association columns to int(11).
    [
      [:blogs, :user_id],
      [:posts, :blog_id],
      [:posts, :author_id],
      [:comments, :post_id],
      [:comments, :author_id],
    ].each do |table, column|
      change_uuid_to_integer(table, column)
    end
  end
end
