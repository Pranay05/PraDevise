class PagesController < ApplicationController

	before_action :authenticate_user!, except: [:index]

def index
	@pages = Page.all
end

def new
#@page = Page.new(pages_params)

end

def create
	@user = User.find_by(params[:user_id])
	if @user.blank?
		flash[:error] = "cannnot find user!"
	end
	@user_page= @user.pages.build(pages_params)
	if @user_page.save!
		flash[:sucess] = "sucessully created pages"
		redirect_to root_url
	else
		render 'new'
		flash[:error] = "failed to create page!"

	end
end

def edit

end

def update
	@user = User.find_by(params[:user_id])
	@page = @user.pages.find_by(params[:id])
	if @page.blank?
		flash[:error] = "cannnot find page!"
	end
	if  @user.pages.update_attributes(pages_params)
		flash[:sucess] = "pages sucessfully updated"
	else
		flash[:error] = "page cannot sucessfully update!"
	end
end



private

def pages_params
params.require(:page).permit(:title, :desription, :price)
end


end
