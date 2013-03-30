module Ba::Banks
  class Bancolombia < Thor

    desc "balance optional: [username] [password]", "Returns the Bancolombia account balance"
    def balance(username = nil , password = nil)
      go_to_root
      process_username_authentication(username)
      process_password_authentication(password)
      page = go_to_authentication_path
      process_questions(page) if need_to_answer_banks_questions?(page)
      balancePage = agent.get("/olb/BeginInitializeActionFromCM?from=pageTabs")
      balance = balancePage.search(".contentTotalNegrita").last.children.text
      puts "Your actual balance is: $#{balance}"
    end

    private

    def go_to_authentication_path
      agent.get("https://bancolombia.olb.todo1.com/olb/Authentication")
    end

    def need_to_answer_banks_questions?(page)
      !get_question_form(page).nil?
    end

    def get_question_form(page)
      @question_form ||= page.form_with(name: "checkChallQuestForm")
    end

    def process_password_authentication(password)
      passwordPageHtml = get_password_path.body
      ##Insert \r for correct regex on password scripts
      passwordPageHtml.gsub!(/document.getElementById/, "\r\n\t document.getElementById")
      enc_password = ""
      password = password || ask("Password: ")
      password.to_s.split('').each do |n|
        passwordPageHtml.match(/\'td_#{n}\'\)\.addEventListener\(\'click\'\,\sfunction\(\)\{\S*\(\"(.*)\"\)\;\}/)
        enc_password << $1
      end

      ##Capture secret hidden field
      passwordPageHtml.match(/'PASSWORD\':\'(.*)\'/)
      secretHiddenField = $1

      ##Post encripted password and secret hidden field
      form = get_password_path.form_with(name: "authenticationForm") do |f|
        f.userId = "0"
        f.password = enc_password
        f.add_field!(secretHiddenField, value = enc_password)
      end

      form.click_button
    end

    def process_username_authentication(username)
      form = get_login_path.form_with(name: "authenticationForm") do |f|
        f.userId = username || ask("Username: ")
      end

      form.click_button
    end
 
    def go_to_root
      agent.get "https://bancolombia.olb.todo1.com/olb/Init"
    end

    def get_login_path
      agent.get "https://bancolombia.olb.todo1.com/olb/Login"
    end

    def get_password_path
      @password_path ||= agent.get("https://bancolombia.olb.todo1.com/olb/GetUserProfile")
    end
  
    def process_questions(page)
      puts "The answer for the following questions will not be saved"
      first_question = first_question(page)
      second_question = second_question(page)

      form = get_question_form(page) do |f|
        f.userAnswer1 = first_question
        f.userAnswer2 = secound_question
      end
      agent.submit(form)
    end

    def first_question(page)
      ask(page.search("#luserAnswer1").text.strip)
    end

    def second_question(page)
      ask(page.search("#luserAnswer2").text.strip)
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
