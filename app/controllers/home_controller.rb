class HomeController < ApplicationController
    before_action :authenticate_customer!

    def top
    end
    def about
    end

end
