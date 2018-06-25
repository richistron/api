require 'rails_helper'

RSpec.describe 'V1::Tenant', type: :request do

  let(:tenant) {
    create :tenant
  }

  let(:user) {
    create :user, tenant: tenant
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
  end

  describe 'V1::Tenants.index' do

    it '200 status' do
      get v1_tenants_path, headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_tenants_path
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_tenants_path, headers: session
      res = JSON.parse response.body
      expect(res.first).to have_key('id')
      expect(res.first).to have_key('name')
      expect(res.first).to have_key('application')
    end

  end

  describe 'V1::Tenants.show' do

    it '200 status' do
      get v1_tenant_path(tenant), headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_tenant_path(tenant)
      expect(response).to have_http_status(401)
    end

    it 'format' do
      get v1_tenant_path(tenant), headers: session
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('name')
      expect(res).to have_key('application')
    end

  end

  describe 'V1::Tenants.create' do

    it '200 status requires no session' do
      post v1_tenants_path, params: { tenant: {
          name: 'foo',
          application: 'RESTAURANT'
      }}
      expect(response).to have_http_status(201)
    end
  end

  describe 'V1::Tenants.update' do

    it '200 status' do
      patch v1_tenant_path(tenant), headers: session, params: { tenant: {
          name: 'foo',
          application: 'RESTAURANT'
      }}
      expect(response).to have_http_status(200)
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('name')
      expect(res).to have_key('application')
    end

    it '401 status' do
      patch v1_tenant_path(tenant), params: { tenant: {
          name: 'foo',
          application: 'RESTAURANT'
      }}
      expect(response).to have_http_status(401)
    end

  end
end

