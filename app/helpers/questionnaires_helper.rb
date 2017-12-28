module QuestionnairesHelper
  def choose_new_or_edit
      if action_name == 'new'
          questionnaires_path
      elsif action_name == 'edit'
          questionnaire_path
      end
  end

end
