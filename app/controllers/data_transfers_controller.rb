class DataTransfersController < ApplicationController
    def index
        @data_transfers = DataTransfer.all
    end
    
    def new
        @data_transfer = DataTransfer.new
    end
    
end
