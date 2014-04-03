class CategorizationsController < ApplicationController

  def destroy
    begin 
      @categorization = current_user.categorizations.find(params[:id]).delete
      redirect_to :back
    rescue 
      flash[:notice] = "You do not have access"
      redirect_to jobs_path
    end
  end
end
