module QuestionnairesHelper
  def choose_new_or_edit
      if action_name == 'new' || action_name == 'confirm'
          confirm_questionnaires_path
      elsif action_name == 'edit'
          questionnaire_path
      end
  end

end
