class RusheesController < ApplicationController

   def create
      @rushee = Rushee.new(rushee_params)
      if @rushee.save
         flash[:success] = "Successfully added #{@rushee.first_name} #{@rushee.last_name}"
         redirect_to @rushee
      else
         render 'new'
      end
   end

   def show
      @rushee = Rushee.find(params[:id])
   end

   def new
      @rushee = Rushee.new
   end

   private

      def rushee_params
         params.require(:rushee).permit(:first_name, :last_name, :preferred_name,
                                        :email, :phone_number, :hometown, :state,
                                        :high_school, :grade, :photo)
      end
end
