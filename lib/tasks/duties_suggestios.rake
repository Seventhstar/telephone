namespace :duties_suggestios do
  desc "generate search suggestions from duties"
  task :index => :environment do
    DutiesSuggestion.index_duties
  end
end