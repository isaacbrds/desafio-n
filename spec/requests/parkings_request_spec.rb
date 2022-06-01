require 'rails_helper'

RSpec.describe "Parkings", type: :request do
  let(:plate){create(:plate)}
  context "GET History" do

    let(:url){"/parking/#{plate.serial}"}
    it "returns a plate" do
      get url
      expect(response.status).to eq(200)
      expect(response.body).to include(plate.to_json)
    end
  end

  context "PUT /OUT" do
    let(:url){"/parking/#{plate.id}/out"}
    it "can't vehicle exit if not payed yet" do
      put url
      expect(response.status).to eq(401)
    end
  end

  context "PUT /OUT" do
    let(:plate_paid){create(:plate, paid: true)}
    let(:url){"/parking/#{plate_paid.id}/out"}
    it "can vehicle exit if has payed yet" do
      put url
      expect(response.status).to eq(201)
    end
  end

  context "PUT /PAID" do
    let(:url){"/parking/#{plate.id}/paid"}
    it "can't vehicle exit if not payed yet" do
      put url
      expect(response.status).to eq(201)
    end
  end

  context "POST /PARKING" do
    let(:url){"/parking"}

    context "with valid params" do
      let(:valid_params){ {parking: { serial: 'FAB-2022'} } }

      it "add a new plate" do
        expect do
          post url, params: valid_params
        end.to change(Plate, :count).by(1)
        expected_plate = Plate.last
        expect(response.status).to eq(201)
        expect(response.body).to eq(expected_plate.to_json)
      end
    end
  end
end
