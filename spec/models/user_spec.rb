require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    # it { should have_many(:user_courses) }
    # it { should have_many(:courses).through(:user_courses) }

    # it 'has_many :user_courses' do
    #   expect(User.reflect_on_association(:user_courses)).to_not be_nil
    # end

    # it 'has_many :courses, through: :user_courses' do
    #   expect(User.reflect_on_association(:courses)).to_not be_nil
    # end


    let(:user) { create(:user) }
    let(:course) { Course.create(title: 'Batman Course', video_url: 'http://batman.com') }
    let!(:user_course) { UserCourse.create(user_id: user.id, course_id: course.id) }

    it 'has_many :user_courses' do
      expect(user.user_courses).to include(user_course)
    end

    it 'has_many :courses, through: :user_courses' do
      expect(user.courses).to include(course)
    end
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end

  context "instance methods" do
    before do
      Timecop.freeze("01/01/2024".to_date)
    end

    after do
      Timecop.return
    end

    it "#name_and_email" do
      user = User.create(email: 'jhon@doe', name: 'Jhon Doe')
      expect(user.name_and_email).to eq('Jhon Doe - jhon@doe - 2024-01-01')
    end
  end
end
