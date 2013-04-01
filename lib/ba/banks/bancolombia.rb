require 'ba/helpers/bancolombia_helper'

module Ba::Banks
  class Bancolombia < Thor
    include Ba::Helpers::BancolombiaHelper

    desc "balance optional: [username] [password]", "Returns the Bancolombia account balance"
    def balance(username = nil , password = nil)
      go_to_root
      process_username_authentication(username)
      process_password_authentication(password)
      process_questions if need_to_answer_banks_questions?
      puts "Your actual balance is: $#{get_balance}"
    end

    private

    def get_balance
      get_balance_page.search(".contentTotalNegrita").last.children.text
    end

    def process_password_authentication(password)
      passwordPageHtml = password_path_body
      ##Insert \r for correct regex on password scripts
      passwordPageHtml.gsub!(/document.getElementById/, "\r\n\t document.getElementById")
      enc_password = ""
      password = password || get_password
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
      form = login_path_form(username)
      form.click_button
    end

    def process_questions
      puts "The answer for the following questions will not be saved"
      answer_1 = first_question
      answer_2 = second_question

      form = get_question_form do |f|
        f.userAnswer1 = answer_1
        f.userAnswer2 = answer_2
      end
      agent.submit(form)
    end
  end
end
