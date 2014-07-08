object @allocations
attributes :display_name, :email
	
node(:allocation_count) { |l| l.allocations.count } 
child :allocations do
	attributes :title, :start_date, :end_date, :duration_in_days
	child :project do
		attributes :title
	end
end
