require 'open-uri'

class ValidateFacebooksController < ApplicationController
  before_action :set_validate_facebook, only: [:show, :edit, :update, :destroy]

  # GET /validate_facebooks
  # GET /validate_facebooks.json
  def index
    @validate_facebooks = ValidateFacebook.all
  end

  # GET /validate_facebooks/1
  # GET /validate_facebooks/1.json
  def show
      @validate_facebook = ValidateFacebook.find(params[:id])
  end

  # GET /validate_facebooks/new
  def new
    @validate_facebook = ValidateFacebook.new
  end

def get_likes()
  errors = ''
  user_id = params[:user_id].to_i
  id = params[:id].to_i
  @before_count = ValidateFacebook.find_by_id(id)

#AFTER:

  url = @before_count.url;
  facebook = Nokogiri::HTML(open(url))
  likes = facebook.at('meta[name="description"]')['content']

  likes_array = likes.split(' ')

  current_likes_count = likes_array[likes_array.index("likes")-1].tr(',', '').to_i
  if @before_count.before < current_likes_count
    award_points = true
    @before_count.awarded = 1;
  else
    award_points = false
    @before_count.awarded = 0;
  end


@before_count.save
respond_to do |format|

  if @before_count.save
    format.html { redirect_to @before_count, notice: 'Validate facebook was successfully created.' }
    format.json { render :show, status: :created, location: @before_count }
  else
    format.html { render :new }
    format.json { render json: @before_count.errors, status: :unprocessable_entity }
  end
end
end

def set_likes()
  errors = ''
  id = params[:id]
  url = Product.find_by_id(id).url
  if url.include? "facebook.com"
    url.sub! 'http://', 'https://'
  end
  facebook = Nokogiri::HTML(open(url))
  likes = facebook.at('meta[name="description"]')['content'].split


  likes_count = likes[likes.index("likes")-1].tr(',', '').to_i

@validate_facebook = ValidateFacebook.new({:uid => User.find(current_user).id,:before => likes_count, :url => url})
respond_to do |format|
  if @validate_facebook.save
    format.html { redirect_to @validate_facebook, notice: 'Validate facebook was successfully created.' }
    format.json { render :show, status: :created, location: @validate_facebook }
  else
    format.html { render :new }
    format.json { render json: @validate_facebook.errors, status: :unprocessable_entity }
  end
end
end

  # GET /validate_facebooks/1/edit
  def edit
  end

  # POST /validate_facebooks
  # POST /validate_facebooks.json
  def create
    @validate_facebook = ValidateFacebook.new(validate_facebook_params)
    abort(@validate_facebook.inspect)
    @validate_facebook.before = get_likes(params[:id])
    respond_to do |format|
      if @validate_facebook.save
        format.html { redirect_to @validate_facebook, notice: 'Validate facebook was successfully created.' }
        format.json { render :show, status: :created, location: @validate_facebook }
      else
        format.html { render :new }
        format.json { render json: @validate_facebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /validate_facebooks/1
  # PATCH/PUT /validate_facebooks/1.json
  def update
    respond_to do |format|
      if @validate_facebook.update(validate_facebook_params)
        format.html { redirect_to @validate_facebook, notice: 'Validate facebook was successfully updated.' }
        format.json { render :show, status: :ok, location: @validate_facebook }
      else
        format.html { render :edit }
        format.json { render json: @validate_facebook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /validate_facebooks/1
  # DELETE /validate_facebooks/1.json
  def destroy
    @validate_facebook.destroy
    respond_to do |format|
      format.html { redirect_to validate_facebooks_url, notice: 'Validate facebook was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_validate_facebook
      new_url = params[:id]
      new_url = new_url.gsub('PrD','.')

      @validate_facebook = ValidateFacebook.find_by_url(new_url)
      new_url = "https://"+ new_url+"/"
      new_url = "https://www.facebook.com/thenextweb?fref=ts"
      facebook = Nokogiri::HTML(open(new_url))
      likes = facebook.at('meta[name="description"]')['content']
      likes_array = likes.split(' ')
      likes_count = likes_array[likes_array.index("likes")-1].tr(',', '').to_i
      #image = open(new_url).read

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def validate_facebook_params
      params.require(:validate_facebook).permit(:uid, :time, :before, :url, :url_id)
    end
end
