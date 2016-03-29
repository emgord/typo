require 'spec_helper'
require 'pry'

describe Admin::CategoriesController do
  render_views

  before(:each) do
    Factory(:blog)
    #TODO Delete after removing fixtures
    Profile.delete_all
    henri = Factory(:user, :login => 'henri', :profile => Factory(:profile_admin, :label => Profile::ADMIN))
    request.session = { :user => henri.id }
  end

  it "test_index" do
    get :index
    assert_response :redirect, :action => 'index'
  end

  describe "test_new" do
    before(:each) do
      get :new, :format => 'html'
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have a new category' do
      assigns(:category).should_not be_nil
      assert assigns(:category).id.should be_nil
      assigns(:categories).should_not be_nil
    end
  end

  describe "test_create" do
    let(:good_category_params) do
      {:name=>"hey", :keywords=>"what", :permalink=>"something", :description=>"so much fun"}
    end
    let(:bad_category_params) do
      {:name=>"", :keywords=>"", :permalink=>"", :description=>""}
    end
    it 'should create a new category' do
      original_count = Category.all.count
      post :edit, :format => 'html', :category => good_category_params
      assert_response :redirect, :action => 'index'
      expect(Category.all.count).to eq(original_count + 1)
      expect(flash[:notice]).to eq("Category was successfully saved.")
    end
    it 'should not create a new category with bad input' do
      original_count = Category.all.count
      post :edit, :format => 'html', :category => bad_category_params
      assert_response :redirect, :action => 'index'
      expect(Category.all.count).to eq(original_count)
      expect(flash[:error]).to eq('Category could not be saved.')
    end
  end

  describe "test_edit" do
    before(:each) do
      get :edit, :id => Factory(:category).id
    end

    it 'should render template new' do
      assert_template 'new'
      assert_tag :tag => "table",
        :attributes => { :id => "category_container" }
    end

    it 'should have valid category' do
      assigns(:category).should_not be_nil
      assert assigns(:category).valid?
      assigns(:categories).should_not be_nil
    end
  end

  it "test_update" do
    post :edit, :id => Factory(:category).id
    assert_response :redirect, :action => 'index'
  end

  describe "test_destroy with GET" do
    before(:each) do
      test_id = Factory(:category).id
      assert_not_nil Category.find(test_id)
      get :destroy, :id => test_id
    end

    it 'should render destroy template' do
      assert_response :success
      assert_template 'destroy'
    end
  end

  it "test_destroy with POST" do
    test_id = Factory(:category).id
    assert_not_nil Category.find(test_id)
    get :destroy, :id => test_id

    post :destroy, :id => test_id
    assert_response :redirect, :action => 'index'

    assert_raise(ActiveRecord::RecordNotFound) { Category.find(test_id) }
  end

end
