class RusheesController < ApplicationController
   before_action :signed_in_user, only: [:index, :create, :edit, :update, :show, :new, :destroy]
   before_action :admin_user, only: :destroy

   def index
      @rushees = Rushee.reorder("last_name").paginate(page: params[:page])
   end

   def create
      @rushee = Rushee.new(rushee_params, score: Score.new(rushee_id: params[:id]))
      if @rushee.save
         flash[:success] = "Successfully added #{@rushee.first_name} #{@rushee.last_name}"
         redirect_to @rushee
      else
         render 'new'
      end
   end

   def edit
      @rushee = Rushee.find(params[:id])
   end

   def update
      @rushee = Rushee.find(params[:id])
      if @rushee.update_attributes(rushee_params)
         flash[:success] = "Profile updated"
         redirect_to @rushee
      else
         render 'edit'
      end
   end

   def show
      @rushee = Rushee.find(params[:id])
      @comments = @rushee.comments.paginate(page: params[:page])
      @comment = @rushee.comments.build(user: current_user)
   end

   def new
      @rushee = Rushee.new
   end

   def destroy
      Rushee.find(params[:id]).destroy
      flash[:success] = "Rushee deleted"
      redirect_to rushees_url
   end

   private

      def rushee_params
         params.require(:rushee).permit(:first_name, :last_name, :preferred_name,
                                        :email, :phone_number, :hometown, :state,
                                        :high_school, :grade, :photo, :score)
      end

      def signed_in_user
         unless signed_in?
            store_location
            redirect_to signin_url, notice: "Please sign in"
         end
      end

      def admin_user
         redirect_to(root_url) unless current_user.admin?
      end
end
