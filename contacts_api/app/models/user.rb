class User < ActiveRecord::Base

  has_many :contacts, dependent: :destroy

  # The set of contacts that have been shared with the user.
  has_many :contact_shares, dependent: :destroy

  # The set of contacts that a user has shared with others.

  def shared_contacts
    User.find_by_sql(<<-SQL)
      SELECT
        contacts.*
      FROM
        contacts
      JOIN
        contact_shares
      ON
        contacts.id = contact_shares.contact_id
      WHERE
        contacts.user_id = #{self.id}
    SQL
  end

end
