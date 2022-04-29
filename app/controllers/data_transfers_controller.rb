class DataTransfersController < ApplicationController
    # Importing a module for handling HTTP Requests
    require "net/http"
    require "uri"
    require "json"

    # Controller Actions
    def index
        @data_transfers = DataTransfer.all
    end

    def new
        @data_transfer = DataTransfer.new
    end

    def create
        @data_transfer = DataTransfer.new(data_transfer_params)
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
    
    private
        def data_transfer_params
            params.require(:data_transfer).permit(
                :c4_acct_name, :c4_token, :c3_acct_name,
                :c3_token, :c3_url, :page,
                :job_start_time, :job_end_time, :http_errors,
                :transfer_data_type
            )
        end
end