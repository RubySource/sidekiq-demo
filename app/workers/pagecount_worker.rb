class PagecountWorker
  include Sidekiq::Worker
 
  def perform(attachment_id)
    attachment = Attachment.find(attachment_id)

    #notice how we reuse the model method!
    attachment.save_page_count

    puts "added attachment"
  end
end
