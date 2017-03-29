namespace :users do
  desc 'Sending emails to inactive users for setup password'
  task send_change_password_emails_to_inactive_users: :environment do
    users = User.inactive
    users.each do |user|
      UserMailer.set_password(user).deliver
    end
  end
end
