require_relative 'acceptance_helper.rb'

feature 'Vote for answer', %q{
  In order to rate answer
  Authenticated user
  can vote for answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'authenticated user like answer', js: true do
    within '.answers' do
      choose 'Like'
      click_on 'Vote'

      within "#rate-answer-#{answer.id}" do
        expect(page).to have_content "1"
      end
      expect(page).to have_content "You like it"
    end
  end

  scenario 'authenticated user dislike answer', js: true do
    within '.answers' do
      choose 'Dislike'
      click_on 'Vote'
      within "#rate-answer-#{answer.id}" do
        expect(page).to have_content "-1"
      end
      expect(page).to have_content "You dislike it"
    end
  end

  scenario 'authenticated user try vote for answer once more time', js: true do
    within '.answers' do
      choose 'Like'
      click_on 'Vote'
      expect(page).to have_no_button 'Vote'
    end
  end

  scenario 'author try vote for his answer' do
    click_on 'Sign out'
    sign_in(answer.user)
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_button 'Vote'
    end
  end

  scenario 'non-authenticated user try vote for answer' do
    click_on 'Sign out'
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_button 'Vote'
    end
  end
end