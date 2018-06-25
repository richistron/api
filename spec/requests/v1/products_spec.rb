require 'rails_helper'

RSpec.describe 'V1::ProductController', type: :request do

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

  let(:product) {
    create :product, tenant: tenant
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
    product
  end

  describe 'V1::Product.index' do

    it '200 status' do
      get v1_products_path, headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_products_path
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_products_path, headers: session
      res = JSON.parse response.body
      expect(res.first).to have_key('id')
      expect(res.first).to have_key('price')
      expect(res.first).to have_key('name')
    end

  end

  describe 'V1::Product.show' do

    it '200 status' do
      get v1_product_path(product), headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_product_path(product)
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_product_path(product), headers: session
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('price')
      expect(res).to have_key('name')
    end

  end

  describe 'V1::Product.create' do

    it '200 status' do
      post v1_products_path, headers: session, params: { product: {
          price: 1,
          name: 'foo'
      }}
      expect(response).to have_http_status(201)
    end

    it '401 status' do
      post v1_products_path, params: { product: {
          price: 1
      }}
      expect(response).to have_http_status(401)
    end

    it 'format' do
      post v1_products_path, headers: session, params: { product: {
          name: 'coca',
          price: 10
      }}
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('price')
      expect(res).to have_key('name')
    end

  end

  describe 'V1::Product.update' do

    it '200 status' do
      patch v1_product_path(product), headers: session, params: { product: {
          price: 100
      }}
      expect(response).to have_http_status(200)
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('tenant_id')
      expect(res).to have_key('price')
      expect(res).to have_key('name')
    end

    it '401 status' do
      patch v1_product_path(product), params: { product: {
          product_id: product.id
      }}
      expect(response).to have_http_status(401)
    end

  end

  describe 'V1::Product.destroy' do
    it 'delete item' do
      delete v1_product_path(product), headers: session
      expect(response).to have_http_status(200)
    end

  end
end

