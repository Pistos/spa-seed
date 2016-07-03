describe ProjectName::Model::RestrictedThing do
  context 'given some owned restricted things' do
    let!(:rthing1) { FactoryGirl.create(:restricted_thing, :owned) }
    let!(:rthing2) { FactoryGirl.create(:restricted_thing, :owned) }
    let(:user1) { rthing1.owner }
    let(:user2) { rthing2.owner }

    describe '#visible_to?' do
      it "is true only for the thing's owner" do
        expect(rthing1).to be_visible_to(user: user1)
        expect(rthing1).not_to be_visible_to(user: user2)
        expect(rthing2).to be_visible_to(user: user2)
        expect(rthing2).not_to be_visible_to(user: user1)
        user_one = ProjectName::Model::User[user1.id]
        expect(rthing1).to be_visible_to(user: user_one)
      end
    end
  end
end
