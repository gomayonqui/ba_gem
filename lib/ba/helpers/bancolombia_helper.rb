module Ba
  module Helpers
    module BancolombiaHelper
      private
      def go_to_authentication_path
        @auth_path ||= agent.get("https://bancolombia.olb.todo1.com/olb/Authentication")
      end

      def need_to_answer_banks_questions?
        !get_question_form.nil?
      end

      def get_question_form
        @question_form ||= go_to_authentication_path.form_with(name: "checkChallQuestForm")
      end

      def go_to_root
        agent.get "https://bancolombia.olb.todo1.com/olb/Init"
      end

      def login_path
        agent.get "https://bancolombia.olb.todo1.com/olb/Login"
      end

      def login_path_form(username)
        login_path.form_with(name: "authenticationForm") do |f|
          f.userId = username || get_username
        end
      end

      def get_password_path
        @password_path ||= agent.get("https://bancolombia.olb.todo1.com/olb/GetUserProfile")
      end

      def password_path_body
        get_password_path.body
      end

      def get_username
        ask("Username: ")
      end

      def get_password
        ask("Password: ") { |q| q.echo = false }
      end

      def first_question
        ask(go_to_authentication_path.search("#luserAnswer1").text.strip)
      end

      def second_question
        ask(go_to_authentication_path.search("#luserAnswer2").text.strip)
      end

      def get_balance_page
        balancePage = agent.get("/olb/BeginInitializeActionFromCM?from=pageTabs")
      end

      def agent
        @agent ||= Mechanize.new
      end
    end
  end
end
