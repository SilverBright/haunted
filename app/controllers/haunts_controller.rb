class HauntsController < ApplicationController

	def index
		@haunts = Haunt.all
		@comments = Comment.all
	end

	def new
		@haunt = current_user.haunts.build
		@comments = @haunt.comments.build
	end

	def show
		@haunt = Haunt.find(params[:id])
		@comment = Comment.find(params[:id])
	end

	def create
		@haunt = Haunt.create(haunt_params)
		@comments = @haunt.comments.build
		# @haunt = current_user.haunts.create(haunt_params.merge(user_id: current_user.id))
		if !@haunt.valid?
			flash[:notice] = "Haunt name is already taken."
			render :new
		else 
			flash[:error] = "Success!!"
			redirect_to haunt_path(@haunt)
		end
	end

	def edit 
		@haunt = Haunt.find(params[:id])
		if @haunt && @haunt.user == current_user

		else
    		flash[:error] = "Foolish mortal. You can only edit your own entries!"
    		redirect_to haunts_path
    	end
	end

	def update
		@haunt = Haunt.find(params[:id])
		if @haunt && @haunt.user == current_user
			@haunt.update(haunt_params)

		flash[:notice] = "Success!"
		redirect_to haunts_path
		end
	end

	def destroy
	 	@haunt = Haunt.find(params[:id])
	 	if @haunt && @haunt.user == current_user
    		@haunt.destroy
    		redirect_to haunts_path
    	else
    		flash[:error] = "Foolish mortal. You can only delete your own entries!"
    		redirect_to haunts_path
    	end
  	end


	private

	def haunt_params
		params.require(:haunt).permit(:name, :location, :description, comments: [:content])
	end

end
