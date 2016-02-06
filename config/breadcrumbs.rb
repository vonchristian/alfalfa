crumb :root do
  link "Home", root_path
end

crumb :projects do
  link "Projects", projects_path
end

crumb :project do |project|
  link truncate(project.name, length: 40)
  parent :projects
end

crumb :contractors do
  link "Contractors", contractors_path
end

crumb :contractor do |contractor|
  link contractor.full_name, contractor_path(contractor)
  parent :contractors
end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
# Root crumb
# crumb :root do
#   link "Home", root_path
# end

# # Regular crumb
# crumb :projects do
#   link "Projects", projects_path
# end

# # Parent crumbs
# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent project # inferred to :project
# end

# # Child 
# crumb :issue do |issue|
#   link issue.name, issue_path(issue)
#   parent :project_issues, issue.project
# end

# # Recursive parent categories
# crumb :category do |category|
#   link category.name, category
#   if category.parent
#     parent category.parent # inferred to :category
#   else
#     parent :categories
#   end
# end

# # Product crumb with recursive parent categories (as defined above)
# crumb :product do |product|
#   link product.name, product
#   parent product.category # inferred to :category
# end

# # Crumb with multiple links
# crumb :test do
#   link "One", one_path
#   link "Two", two_path
#   parent :about
# end

# # Example of using params to alter the parent, e.g. to
# # match the user's actual navigation path
# # URL: /products/123?q=my+search
# crumb :search do |keyword|
#   link "Search for #{keyword}", search_path(q: keyword)
# end

# crumb :product do |product|
#   if keyword = params[:q].presence
#     parent :search, keyword
#   else # default
#     parent product.category # inferred to :category
#   end
# end

# # Multiple arguments
# crumb :multiple_test do |a, b, c|
#   link "Test #{a}, #{b}, #{c}", test_path
#   parent :other_test, 3, 4, 5
# end

# # Breadcrumb without link URL; will not generate a link
# crumb :without_link do
#   link "Breadcrumb without link"
# end

# # Breadcrumb using view helper
# module UsersHelper
#   def user_name_for(user)
#     user.name
#   end
# end

# crumb :user do |user|
#   link user_name_for(user), user
# end
