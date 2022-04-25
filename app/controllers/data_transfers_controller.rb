class DataTransfersController < ApplicationController
    def index
        @data_transfers = DataTransfer.all
    end

    def new
        @data_transfer = DataTransfer.new
    end

    def create
        @data_transfer = DataTransfer.new(params[:data_transfer])
        if @data_transfer.save
          flash[:success] = "DataTransfer successfully created"
          redirect_to @data_transfer
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def show
        @data_transfer = DataTransfer.find(params[:id])
    end
    
    
    
    
end
