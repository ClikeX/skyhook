namespace :test do

  task :key do
    puts key
  end

  task :user do
    user = Skyhook::User.new 'ClikeX'
    puts user.steamid, user.personaname
  end

  task :game do
    game = Skyhook::Game.new(218620, 'ClikeX')
    puts game.game_name
  end

  task :all => ["test:user", "test:game"]
end
