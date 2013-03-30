module Ba::Banks
  class Bancolombia < Thor

    desc "balance", "Returns the Bancolombia account balance"
    def balance
      ##Login username page
      agent.get("https://bancolombia.olb.todo1.com/olb/Init")
      userLoginPage = agent.get("https://bancolombia.olb.todo1.com/olb/Login")
      userLoginPage.form_with(:name => "authenticationForm") do |f|
        f.userId = ask("Username: ")
      end.click_button

      ##Redirect to password page
      passwordPage = agent.get("https://bancolombia.olb.todo1.com/olb/GetUserProfile")
      passwordPageHtml = passwordPage.body
      ##Insert \r for correct regex on password scripts
      passwordPageHtml.gsub!(/document.getElementById/, "\r\n\t document.getElementById")
      enc_password = ""
      password = ask("Password: ") { |q| q.echo = "*" }
      password.to_s.split('').each do |n|
        passwordPageHtml.match(/\'td_#{n}\'\)\.addEventListener\(\'click\'\,\sfunction\(\)\{\S*\(\"(.*)\"\)\;\}/);
        enc_password << $1
      end

      ##Capture secret hidden field
      passwordPageHtml.match(/'PASSWORD\':\'(.*)\'/)
      secretHiddenField = $1

      ##Post encripted password and secret hidden field
      passwordPage.form_with(:name => "authenticationForm") do |f|
        f.userId = "0"
        f.password = enc_password
        f.add_field!(secretHiddenField, value = enc_password)
      end.click_button

      ##Get Balance
      page = agent.get("https://bancolombia.olb.todo1.com/olb/Authentication")
      process_questions(page) if page.forms_with(name: "checkChallQuestForm").any?
      balancePage = agent.get("/olb/BeginInitializeActionFromCM?from=pageTabs")
      balance = balancePage.search(".contentTotalNegrita").last.children.text
      puts "Your actual balance is: $#{balance}"
    end

    private

    def process_questions(page)
      puts "The answer for the following questions will not be saved"
      answer_one = ask(page.search("#luserAnswer1").text.strip + " ") { |q| q.echo = "*" }
      answer_two = ask(page.search("#luserAnswer2").text.strip + " ") { |q| q.echo = "*" }
      form = page.form_with(name: "checkChallQuestForm") do |f|
        f.userAnswer1 = answer_one
        f.userAnswer2 = answer_two
      end
      form.submit(form.buttons_with(name: "accept_btn").first)
    end

    def agent
      @agent ||= Mechanize.new
    end
  end
end
