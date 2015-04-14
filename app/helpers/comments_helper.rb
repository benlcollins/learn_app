module CommentsHelper
	def comments_tree_for(comments)
		comments.map do |comment, nested_comments|
			# binding.pry
			render(comment) + (nested_comments.size > 0 ? content_tag(:div, comments_tree_for(nested_comments), class: "replies") : nil)
		end.join.html_safe
	end

	def comments_counter(number)
		@comments_count.has_key?(number) ? @comments_count[number] : 0
	end
end
