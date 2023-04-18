class SquawksController < ApplicationController

  def index
    squawks = Squawk.all
    render json: squawks
  end

  def create
    @squawk = Squawk.new
    bank = @squawk.determine_bank(params[:bank])
    code = bank.min
    @squawk.code = @squawk.provide_squawk(bank, code)
    @squawk.paired = false
    puts @squawk.code

    if @squawk.save
      render json: @squawk, status: :created
    else
      render json: @squawk.errors, status: :unprocessable_entity
    end
  end
end
