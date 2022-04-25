class DataTransferController < ApplicationController
    def index
        @dt = DataTransfer.all
    end

    def new
        @dt = DataTransfer.new
    end

    def create
        @dt = DataTransfer.new(params[:data_transfer])
        if @dt.save
          flash[:success] = "Object successfully created"
          redirect_to @dt
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
    
    def show
        @dt = DataTransfer.find(params[:id])
    end
    
    private 
        def data_transfer_params 
            params.require(:data_transfer).permit(:c4_acct_name, :c4_token,
                :c3_acct_name, :c3_token, :c3_url, :page,
                :job_start_time, :job_end_time, :errors)
        end
end
