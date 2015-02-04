class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  #include CacheableFlash
 
  skip_before_filter :authorize, :only => [:index, :show, :all, :alle_veilingen, :alle_koopjes]
#  before_filter :authorize_webmaster, :only=>[:create,:new,:edit, :update,:destroy, :index, :flush_pages]

#  caches_page :alle_veilingen, :alle_koopjes

  def index
    @categories = Category.order(:is_koopje).order(:title).all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end


  def flush_pages
    #done in view itself...
    #Category.flush_cashed_pages
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  def all
    @category = Category.first #Category.find( params[:id] )
    @veilingen = Veiling.where(:online=>true).running.order(:einde).all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end

  def alle_veilingen
    @category = Category.find( params[:id] )
    @veilingen = Veiling.where( :nu_kopen=>false, :online=>true ).running.order(:einde).all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end


  def alle_koopjes
    @category = Category.find( params[:id] )
    @veilingen = Veiling.where( :nu_kopen=>true, :online=>true ).running.order(:einde).all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @category }
    end
  end



  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
      @category = Category.new(params[:category])

      respond_to do |format|
        if @category.save
          format.html { redirect_to(categories_path, :notice => 'Category was successfully created.') }
          format.xml  { render :xml => @category, :status => :created, :location => @category }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
        end
      end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
      @category = Category.find(params[:id])

      respond_to do |format|
        if @category.update_attributes(params[:category])
          format.html { redirect_to(@category, :notice => 'Category was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
        end
      end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
