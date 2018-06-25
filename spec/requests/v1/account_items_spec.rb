require 'rails_helper'

RSpec.describe 'V1::AccountItemsItems', type: :request do

  let(:tenant) {
    create :tenant
  }

  let(:user) {
    create :user, tenant: tenant
  }

  let(:table) {
    create :table, tenant: tenant
  }

  let(:product) {
    create :product, tenant: tenant
  }

  let(:account) {
    create :account, tenant: tenant, table: table
  }

  let(:account_item) {
    create :account_item, tenant: tenant, account: account, product: product
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
    product
    table
    account
    account_item
  end

  describe 'V1::AccountItems.index' do

    it '200 status' do
      get v1_account_items_path, headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_account_items_path
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_account_items_path, headers: session
      res = JSON.parse response.body
      expect(res.first).to have_key('id')
      expect(res.first).to have_key('product_id')
      expect(res.first).to have_key('account_id')
      expect(res.first).to have_key('tenant_id')
    end

  end

  describe 'V1::AccountItems.show' do

    it '200 status' do
      get v1_account_item_path(account_item), headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_account_item_path(account_item)
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_account_item_path(account_item), headers: session
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('tenant_id')
      expect(res).to have_key('account_id')
    end

  end

  describe 'V1::AccountItems.create' do

    it '200 status' do
      post v1_account_items_path, headers: session, params: { account_item: {
          account_id: account.id,
          product_id: product.id
      }}
      expect(response).to have_http_status(201)
    end

    it '401 status' do
      post v1_account_items_path, params: { account_item: {
          account_id: account.id,
          product_id: product.id
      }}
      expect(response).to have_http_status(401)
    end

    it 'format' do
      post v1_account_items_path, headers: session, params: { account_item: {
          account_id: account.id,
          product_id: product.id
      }}
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('tenant_id')
      expect(res).to have_key('account_id')
    end

  end

  describe 'V1::AccountItems.update' do

    it '200 status' do
      patch v1_account_item_path(account_item), headers: session, params: { account_item: {
          product_id: product.id
      }}
      expect(response).to have_http_status(200)
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('tenant_id')
      expect(res).to have_key('account_id')
    end

    it '401 status' do
      patch v1_account_item_path(account_item), params: { account_item: {
          product_id: product.id
      }}
      expect(response).to have_http_status(401)
    end

  end

  describe 'V1::AccountItems.destroy' do
    it 'delete item' do
      delete v1_account_item_path(account_item), headers: session
      expect(response).to have_http_status(200)
    end

  end
end

