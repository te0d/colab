desc 'task to email out a daily digest to all users'
task :email_digest => :environment do
  users = User.includes({:discussions => :posts})
  
  for user in users
  
    # variable to contain message text
    msg_content = ''
  
    # check for posts written within the past day (tentative)
    for discussion in user.discussions
      new_posts = discussion.posts.where(:created_at => (Time.now - 1.day)..(Time.now))
      
      # if there are new posts, write the discussion name and the new posts
      unless new_posts.empty?
        msg_content += ">> #{discussion.group.name} > #{discussion.name}\n"
      
        for post in new_posts
          msg_content += "   # #{post.user.email}:  #{post.content}\n"
        end
        
        msg_content += "\n"
      end
    end
    
    Pony.mail({
      :to => user.email,
      :subject => 'Chi Phi CoLab Daily Digest',
      :body => msg_content,
      :via => :smtp,
      :via_options => {
        :address => 'smtp.gmail.com',
        :port => '587',
        :enable_starttls_auto => true,
        :user_name => ENV['CHI_PHI_COLAB_EMAIL_ADDR'],
        :password => ENV['CHI_PHI_COLAB_EMAIL_PASS'],
        :authentication => :plain,
        :domain => 'localhost.localdomain'
      }
    })
  end
end
