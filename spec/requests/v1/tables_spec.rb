require 'rails_helper'

RSpec.describe "V1::Tables", type: :request do

  let(:table) {
    tenant = create :tenant
    build :table, tenant: tenant
  }

  let(:session) {
    tenant = create :tenant
    user = create :user, tenant: tenant
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

  describe 'V1::Tables#index' do

    it 'index 200' do
      get v1_tables_path, headers: session
      expect(response).to have_http_status(200)
    end

    it 'index 401' do
      get v1_tables_path
      expect(response).to have_http_status(401)
    end
  end

  describe 'V1::Tables#show' do

    it 'show 200' do
      table.save
      get v1_table_path(table), headers: session
      expect(response).to have_http_status(200)
    end

    it 'show 401' do
      table.save
      get v1_table_path(table)
      expect(response).to have_http_status(401)
    end
  end

  describe 'V1::Tables#create' do

    it 'create 201' do
      tenant = create :tenant
      post v1_tables_path, params: { table: {
          name: 'yolo',
          tenant_id: tenant.id
      }}, headers: session
      expect(response).to have_http_status(201)
    end

    it 'create 401' do
      post v1_tables_path, params: { table: {
          name: 'yolo'
      }}
      expect(response).to have_http_status(401)
    end
  end

  describe 'V1::Tables#update' do

    it 'update 200' do
      tenant = create :tenant
      table = create :table, tenant: tenant
      patch v1_table_path(table), params: { table: {name: 'foo'}}, headers: session
      expect(response).to have_http_status(200)
    end

    it 'update 401' do
      tenant = create :tenant
      table = create :table, tenant: tenant
      patch v1_table_path(table), params: { table: {name: 'foo'}}
      expect(response).to have_http_status(401)
    end
  end

  describe 'V1::Tables#show' do

    it 'destroy' do
      skip 'destoy is not implemented'
      table = create :table
      delete v1_table_path(table), params: { table: {name: 'foo'}}
      expect(response).to have_http_status(200)
    end
  end

end

