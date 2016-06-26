describe ProjectName::Model::User do
  describe '#restricted_things' do
    context 'given a user' do
      let(:user) { FactoryGirl.create(:user) }

      context 'given some restricted things owned by that user' do
        let!(:rthing1) { FactoryGirl.create(:restricted_thing, owner_user_id: user.id) }
        let!(:rthing2) { FactoryGirl.create(:restricted_thing, owner_user_id: user.id) }

        context 'and some things not owned by that user' do
          let!(:rthing3) { FactoryGirl.create(:restricted_thing, :owned) }
          let!(:rthing4) { FactoryGirl.create(:restricted_thing, :owned) }

          it 'returns the things owned by that user, and not the other things' do
            expect(user.restricted_things).to include(rthing1)
            expect(user.restricted_things).to include(rthing2)
            expect(user.restricted_things).not_to include(rthing3)
            expect(user.restricted_things).not_to include(rthing4)
          end
        end
    end
    end
  end
end
