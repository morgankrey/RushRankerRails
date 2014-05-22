class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   include SessionsHelper

   helper_method :all_rushees

   def all_rushees
      all_rushees = (Rushee.all.sort_by &:score).reverse[0..29]
   end
end
