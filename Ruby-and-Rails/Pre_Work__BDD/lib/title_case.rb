require 'pry'

def title_case title
  binding.pry
  title.split(' ').map(&:capitalize).join(' ')
end
