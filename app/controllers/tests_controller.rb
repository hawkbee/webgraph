class TestsController < ApplicationController
  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tests }
    end
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @tests = Test.all
    @test = Test.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test }
    end
  end

  # GET /tests/new
  # GET /tests/new.json
  def new
    @test = Test.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = Test.find(params[:id])
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(params[:test])

    respond_to do |format|
      if @test.save
        format.html { redirect_to @test, notice: 'Test was successfully created.' }
        format.json { render json: @test, status: :created, location: @test }
      else
        format.html { render action: "new" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tests/1
  # PUT /tests/1.json
  def update
    @test = Test.find(params[:id])

    respond_to do |format|
      if @test.update_attributes(params[:test])
        format.html { redirect_to @test, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to tests_url }
      format.json { head :no_content }
    end
   end
  def compare
    @test1 = Test.find(params[:id][:src])
    @test2 = Test.find(params[:id][:dst])
    @diff_map = {}
    @diff_test = ""
    test1_map = {}
    test2_map = {}
    re = /\[(\d+)\s*,\s*(\d+)\],*/
    @test1.results.scan(re).each { |key| test1_map[key[0].to_i] = key[1].to_i };
    @test2.results.scan(re).each { |key| test2_map[key[0].to_i] = key[1].to_i };
    test1_map.each { |key, value| @diff_map[key] = test2_map[key] - test1_map[key] }
   # test1_map.each { |key, value| puts "#{key}=>#{value},"}
   # test2_map.each { |key, value| puts "#{key}=>#{value},"}
    @diff_map.each { |key, value| @diff_test << "[#{key},#{value}],"}
  end
end
