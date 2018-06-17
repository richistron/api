require 'rails_helper'

RSpec.describe "V1::Tables", type: :request do

  let(:valid_attributes) {
    {name: 'yolo'}
  }

  it 'index' do
    get v1_tables_path
    expect(response).to have_http_status(200)
  end

  it 'show' do
    table = build :table
    table.save!
    get v1_table_path(table)
    expect(response).to have_http_status(200)
    res = JSON.parse(response.body)
    expect(res['id']).to eq(table.id)
  end

  it 'create' do
    post v1_tables_path, params: { table: valid_attributes}
    expect(response).to have_http_status(201)
  end

  it 'update' do
    table = create :table
    patch v1_table_path(table), params: { table: {name: 'foo'}}
    expect(response).to have_http_status(200)
  end

  it 'destroy' do
    table = create :table
    delete v1_table_path(table), params: { table: {name: 'foo'}}
    expect(response).to have_http_status(200)
  end

end

