require('spec_helper')

describe ProjectsController do
  let(:project) { create(:project) }
  let(:user)    { create(:user) }
  let(:png)     { fixture_file_upload(Rails.root + 'spec/fixtures/dk.png', 'image/png') }
  let(:jpg)     { fixture_file_upload(Rails.root + 'spec/fixtures/rails_sample.jpg', 'image/jpg') }
  let(:gif)     { fixture_file_upload(Rails.root + 'spec/fixtures/banana_sample.gif', 'image/gif') }
  let(:gif)     { fixture_file_upload(Rails.root + 'spec/fixtures/doc_sample.txt', 'text/plain') }

  describe "POST #upload_image" do
    before do
      sign_in(user)
    end

    context "without params['markdown_img']" do
      it "returns an error" do
        post :upload_image, project_id: project.to_param
        expect(response.status).to eq(400) #bad request
      end
    end

    context "with invalid file" do
      it "returns an error" do
        expect(response.status).to eq(400) #bad request
      end
    end

    context "with valid file" do
      before do
        post :upload_image, project_id: project.to_param, markdown_img: jpg
      end

      it "returns a JSON object" do
        expect(response.headers['Content-Type']).to have_content 'application/json'
      end

      it "returns a content with original filename and link." do
        link = {alt: 'rails_sample', link: }
        expect(response.body).to 
      end

      it "returns a correct" do
        
      end
    end
  end
end