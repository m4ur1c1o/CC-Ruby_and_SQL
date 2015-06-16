require "sqlite3"

class Chef

	def initialize(first_name, last_name, birthday, email, phone, created_at, updated_at)
		@first_name = first_name
		@last_name = last_name
		@birthday = birthday
		@email = email
		@phone = phone
		@created_at = created_at
		@updated_at = updated_at
	end

	def self.all
		Chef.db.execute(
			<<-SQL
				SELECT * FROM chefs
			SQL
		)
	end

	def self.where(column, value)
		# query = "SELECT * FROM chefs WHERE #{column} = \'#{value}\'"
#		value = params[:value]
		
		Chef.db.execute(
				# SELECT * FROM chefs WHERE #{column} = #{value}
			# <<-SQL
				"SELECT * FROM chefs WHERE #{column} = ?", value
				#{column} = ?", value
			# SQL
			
		) #{?}
	end

	def save
		insert = "(#{@first_name}, #{@last_name}, #{@birthday}, #{@email}, #{@phone}, #{@created_at}, #{@updated_at})"
		Chef.db.execute(
			<<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
        	('#{@first_name}', '#{@last_name}', '#{@birthday}', '#{@email}', '#{@phone}', '#{@created_at}', '#{@updated_at}');
			SQL
		)
	end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

	def self.delete(column, value)
		Chef.db.execute(
			"DELETE FROM chefs WHERE #{column} = ?" ,value
		)
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Mauricio', 'Garcia', '1987-05-15', 'mauricio@mail.com', '123456789', DATETIME('now'), DATETIME('now')),
          ('Santiago', 'Bermudez', '1992-08-12', 'santiago@mail.com', '987654321', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end



# Chef.all.each{|x| puts x[0]}
puts "Chef.all"
p Chef.all
puts "Chef.where"
p Chef.where('id', 3)

# chef = Chef.new('Mario', 'Bros', '1985-01-01', 'mario@bros.com', '112233445', '2015-06-16 16:39:24', '2015-06-16 16:39:24')
# chef.save
# Chef.delete('id',5)