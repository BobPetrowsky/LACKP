require "sinatra"
require "sinatra/reloader"
require "csv"


def get_players(target_team)
  players = []

  CSV.foreach("lackp_starting_rosters.csv", headers: true) do |csv|
    if target_team == csv["team"]
      players << csv
    end
  end

  players
end


def get_teams
  teams = []

  CSV.foreach("lackp_starting_rosters.csv", headers: true) do |csv|
    team = csv["team"]

    if !teams.include?(team)
      teams << team
    end
  end

  teams

end





get '/' do
  erb :index
end

get '/teams' do
  @teams = get_teams
  erb :teams
end


get '/teams/:team' do
  @team = params[:team]
  @players = get_players(@team)
  erb :team
end




