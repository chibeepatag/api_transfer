# API Transfer
Migrates data from Imonggo C4 to Imonggo C3

* Ruby 2.7.1
* Rails 7.0.2.3
* Sidekiq for brackground task of retrieving and posting data


## To Do:
1. Create the data_transfer model with the following attributes: 
C4 account name - string, limit 150 characters
C4 token - string
C3 account name - string, limit 150 characters
c3 token - string
c3 url - string
page - integer
job_start_time - timestamp
job_end_time - timestamp
errors - text

2. Create DataTransferController 
actions are
new
create
show
index

3. Route home / to data_transfer_controller#new

4. implement data_transfer#transfer
   This method will perform the http get from c4 and post to C3 requests

5. Create a sidekiq job for transfer (Celine)