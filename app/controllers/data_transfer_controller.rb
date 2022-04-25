class DataTransferController < ApplicationController
    def index
        @dataTransfer = DataTransfer.all
    end

    def new
        @dataTransfer = DataTransfer.new
    end

    def create
        @dataTransfer = DataTransfer.new(params[:data_transfer])
        if @dataTransfer.save
          flash[:success] = "Object successfully created"
          redirect_to @dataTransfer
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
    
    def show
        @dataTransfer = DataTransfer.find(params[:id])
    end
    
    private 
        def data_transfer_params 
            params.require(:data_transfer).permit(:c4_acct_name, :c4_token,
            )
        end
end
