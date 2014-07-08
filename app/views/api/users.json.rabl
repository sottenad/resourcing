collection @users
attributes :email, :display_name, :first_name

child :allocations do
	attributes :title, :start_date, :end_date
end