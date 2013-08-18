require 'spec_helper'

describe HubotsController do

  let(:user) { create :user }
  let(:hubot) { create :hubot }
  before { sign_in :user, user }

  describe 'GET #index' do
    subject { get :index }

    it { should be_success }
  end

  describe 'GET #new' do
    subject { get :new }

    it { should be_success }
  end

  describe 'GET #show' do
    subject { get :show, id: hubot.id }

    it { should be_success }
  end

  describe 'POST #create' do
    let(:hubot_params) { {
      title: 'New Hubot',
      name: 'new_hubot',
      adapter: 'shell',
      port: 10101,
      test_port: 10102,
    }}
    subject { post :create, hubot: hubot_params }

    specify do
      expect { subject }.to change { Hubot.count }.by(1)
    end
  end

  describe 'PATCH #update' do
    let(:old_title) { hubot.title }
    let(:new_title) { 'New Hubot Title' }
    subject { patch :update, id: hubot.id, hubot: { title: new_title } }

    specify do
      expect { subject }.to change { hubot.reload.title }.from(old_title).to(new_title)
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_hubot) { delete :destroy, id: hubot.id }
    before { destroy_hubot }

    it { should redirect_to root_path }

    specify { flash[:notice].should be_present }

    specify { Hubot.where(id: hubot.id).count.should == 0 }
  end

  describe '#log' do

    context 'GET' do
      subject { get :log, id: hubot.id }

      it { should be_success }
    end

    context 'POST' do
      subject { post :log, id: hubot.id }

      it { should be_success }
    end
  end

  describe 'POST #truncate' do
    subject { post :log_truncate, id: hubot.id }

    it { should redirect_to hubot_path(hubot) }
  end
end