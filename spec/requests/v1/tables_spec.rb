require 'rails_helper'

RSpec.describe 'V1::Tables', type: :request do

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

  before :each do
    session
    # puts "session hash #{ session }"
  end

  describe 'V1::Table.index' do

    it '200 status' do
      get v1_tables_path, headers: session
      expect(response).to have_http_status(200)
    end

    it 'format' do
      get v1_tables_path, headers: session
      res = JSON.parse response.body
      expect(res).to eq([])
    end

    it 'one element' do
      tenant = Tenant.first
      create :table, tenant: tenant
      get v1_tables_path, headers: session
      res = JSON.parse response.body
      expect(res.first).to have_key('id')
      expect(res.first).to have_key('name')
      expect(res.first).to have_key('tenant_id')
      expect(res.first).to have_key('created_at')
      expect(res.first).to have_key('updated_at')
    end

    it 'index 401' do
      get v1_tables_path
      expect(response).to have_http_status(401)
    end
  end




  describe 'V1::Tables.show' do
    it 'show 200' do
      tenant = Tenant.first
      table = create :table, tenant: tenant
      get v1_table_path(table), headers: session
      expect(response).to have_http_status(200)
    end

    it 'show 401' do
      tenant = Tenant.first
      table = create :table, tenant: tenant
      get v1_table_path(table)
      expect(response).to have_http_status(401)
    end

    it 'format' do
      tenant = Tenant.first
      table = create :table, tenant: tenant
      get v1_table_path(table), headers: session
      res = JSON.parse response.body
      expect(res).to have_key('id')
      expect(res).to have_key('name')
      expect(res).to have_key('tenant_id')
      expect(res).to have_key('created_at')
      expect(res).to have_key('updated_at')
    end
  end

  describe 'V1::Tables.create' do
    it 'create 201' do
      post v1_tables_path, params: { table: {
          name: 'yolo'
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

  describe 'V1::Tables.destroy' do
    it 'update 200' do
      tenant = Tenant.first
      table = create :table, tenant: tenant
      patch v1_table_path(table), params: { table: {name: 'foo'}}, headers: session
      expect(response).to have_http_status(200)
    end

    it 'update 401' do
      tenant = Tenant.first
      table = create :table, tenant: tenant
      patch v1_table_path(table), params: { table: {name: 'foo'}}
      expect(response).to have_http_status(401)
    end
  end

  describe 'V1::Tables.destroy' do
    it 'destroy' do
      # TODO implement destroy method only for admins
      skip 'destoy is not implemented'
      table = create :table
      delete v1_table_path(table), params: { table: {name: 'foo'}}
      expect(response).to have_http_status(200)
    end
  end

end

