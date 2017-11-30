require_relative "controllers/menu_controller.rb"

menu = MenuController.new  #creates menu object which holds an address book object which has an entries array with the potential to hold an entry object
system "clear" #clear the cli

puts "Welcome to address bloc!"
menu.main_menu #the method with SO menu waiting for SI