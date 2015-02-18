namespace :test do

  # These are to test data return. They do not replace rspec.

  puts 'testing Steam return values'

  task :key do
    puts key
  end

  task :user do
    puts "\nuser"
    user = Skyhook::User.new 'ClikeX'
    puts user.steamid, user.personaname
  end

  task :game do
    puts "\ngame"
    game = Skyhook::Game.new(218620, 'ClikeX')
    puts game.game_name
  end

  task :all => ["test:user", "test:game"]

end
