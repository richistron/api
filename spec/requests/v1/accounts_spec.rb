require 'rails_helper'

RSpec.describe 'V1::Accounts', type: :request do

  let(:tenant) {
    create :tenant
  }

  let(:user) {
    create :user, tenant: tenant
  }

  let(:table) {
    create :table, tenant: tenant
  }

  let(:account) {
    create :account, tenant: tenant, table: table
  }

  let(:session) {
    params = {
        email: user.email,
        password: user.password
    }
    post user_session_path, params: params
    {
        'access-token': response.headers['access-token'],
        client: response.headers['client'],
        uid: response.headers['uid']
    }
  }

  before :each do
    tenant
    user
    session
    table
    account
  end

  describe 'V1::Account.index' do

    it '200 status' do
      get v1_accounts_path, headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_accounts_path
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_accounts_path, headers: session
      res = JSON.parse response.body
      expect(res.first).to have_key('id')
      expect(res.first).to have_key('name')
      expect(res.first).to have_key('table_id')
      expect(res.first).to have_key('tenant_id')
    end

  end

  describe 'V1::Account.show' do

    it '200 status' do
      get v1_account_path(account), headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_account_path(account)
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_account_path(account), headers: session
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('name')
      expect(res).to have_key('table_id')
      expect(res).to have_key('tenant_id')
    end

  end

  describe 'V1::Account.create' do

    it '200 status' do
      post v1_accounts_path, headers: session, params: { account: {
          name: 'yolo',
          table_id: table.id
      }}
      expect(response).to have_http_status(201)
    end

    it '401 status' do
      post v1_accounts_path, params: { account: {
          name: 'yolo',
          table_id: table.id
      }}
      expect(response).to have_http_status(401)
    end

    it 'format' do
      post v1_accounts_path, headers: session, params: { account: {
          name: 'yolo man',
          table_id: table.id
      }}
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('name')
      expect(res).to have_key('table_id')
      expect(res).to have_key('tenant_id')
      expect(res['name']).to eq('yolo man')
    end

  end

  describe 'V1::Account.update' do

    it '200 status' do
      patch v1_account_path(account), headers: session, params: { account: {
          name: '_ yolo'
      }}
      expect(response).to have_http_status(200)
      res = JSON.parse response.body
      expect(res['name']).to eq('_ yolo')
      expect(res).to have_key('name')
      expect(res).to have_key('table_id')
      expect(res).to have_key('tenant_id')
    end

    it '401 status' do
      patch v1_account_path(account), params: { account: {
          name: 'foo'
      }}
      expect(response).to have_http_status(401)
    end

  end

  describe 'V1::Account.destroy' do
    # TODO implement destroy method only for admins
    skip 'destoy is not implemented'
  end
end

