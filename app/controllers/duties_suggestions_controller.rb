class DutiesSuggestionsController < ApplicationController
  def index
     # render json: %w[foo bar]
     render json: DutiesSuggestion.terms_for(params[:term])
  end
end
